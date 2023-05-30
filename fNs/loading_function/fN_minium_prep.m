function [BAM_data, location_progress] = fN_minium_prep(BAM_config, BAM_data, pdata,datacapture, app)

        location_progress = zeros([1,length(BAM_data.interedted_channel_idx)]);
        for preprocessed_channel = 1:length(BAM_data.interedted_channel_idx)
            if(datacapture(preprocessed_channel)>2)
                channel_captal = BAM_data.ChannelName{preprocessed_channel}(1:3);
                cc = str2num(BAM_data.ChannelName{preprocessed_channel}(4));
                switch channel_captal
                    case 'Eve'
                        [ev_train,ev_time]=fN_sort_digital_port(pdata(preprocessed_channel,:), datacapture(preprocessed_channel),BAM_config.SR.DIO);
                        ev_time = ev_time-BAM_config.StartingTime;
                        BAM_data.big_ev_train = fN_stack_array(BAM_data.big_ev_train, ev_train);
                        BAM_data.big_ev_time = fN_stack_array(BAM_data.big_ev_time, ev_time);
                        location_progress(preprocessed_channel) = BAM_data.big_ev_train.location;
                    case 'SEG'
                        [spike_id, spike_time, spk_waveform, spk_number] = fN_sort_seg_port(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.SEG);
                        spike_time = spike_time - BAM_config.StartingTime;
                        field_name = ['big_spk' num2str(cc) '_time'];
                        gotten_data = getfield(BAM_data, field_name);
                        if(app.DataCapture.Data{preprocessed_channel,3}<900)
                            disp('updating wave form')
                            BAM_data.spk_profile{cc} = fN_update_spk_waveform(spk_waveform, spk_number, BAM_data.spk_profile{cc},cc);
                        end
                        BAM_data = setfield(BAM_data, field_name, fN_stack_array(gotten_data, {spike_time,spike_id}));
                        max_val = 0;
                        for ii = 1:length(gotten_data)
                            max_val = max(max_val, gotten_data{ii}.location);
                        end
                        location_progress(preprocessed_channel) = max_val;
                    case 'LFP'
                        [LFP_data, LFP_time] = fN_sort_analog_data(pdata(preprocessed_channel,:),datacapture(preprocessed_channel),BAM_config.SR.LFP);
                        LFP_time = LFP_time-BAM_config.StartingTime;
                        field_name = ['big_LFP' num2str(cc) '_train'];
                        BAM_data = setfield(BAM_data, field_name, fN_stack_ai_array(getfield(BAM_data, field_name), LFP_data, LFP_time, BAM_config.ai_downsample));
                        location_progress(preprocessed_channel) = getfield(BAM_data, ['big_LFP' num2str(cc) '_train']).location;
%                         field_name = ['big_LFP' num2str(cc) '_train'];
%                         BAM_data = setfield(BAM_data, field_name, fN_stack_array(getfield(BAM_data, field_name), LFP_time));
%                 end
                end
                % interpret eye signal
                if(BAM_data.big_ev_train.location>10)
                    try
                        % note that eye signal is 1 by default
                        % so we need to figure the time when eye signal is 0
                        all_break = find(BAM_data.big_ev_train.val==1002);
                        all_break_time = BAM_data.big_ev_time.val(all_break);
                        all_hold = find(BAM_data.big_ev_train.val==1001);
                        all_hold_time = BAM_data.big_ev_time.val(all_hold);
                        for hold_location = all_hold
                            last_break_location = max(all_break(all_break<hold_location));
                            if(isempty(last_break_location))
                                % which means this session begins with 'break'
                                last_break_location=1;
                            end
                            BAM_data.eye_in(BAM_data.big_ev_time.val(last_break_location):BAM_data.big_ev_time.val(hold_location))=false;
                        end
                        if(all_break(end)>all_hold(end))
                            % which means data ends with 'break'
                            BAM_data.eye_in(BAM_data.big_ev_time.val(all_break(end)):BAM_data.big_ev_time.val(BAM_data.big_ev_time.location-1))=false;
                        end
                    end
                    imagesc(app.UIAxes, BAM_data.eye_in(1:BAM_data.big_ev_time.val(BAM_data.big_ev_time.location-1)))
                end
            end
end