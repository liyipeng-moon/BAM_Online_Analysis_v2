function [BAM_config,BAM_data, app] = fN_saving(BAM_config, BAM_data, app)
%%

    %% adding channel name accaording to electrode
    [BAM_config, BAM_data, app] = fN_add_buffer(BAM_config, BAM_data, app);

    [BAM_config, BAM_data, app] = fN_generating_axis(BAM_config, BAM_data, app);
    %% generate fake variable for storing data
    % generate data capture table
    app.DataCapture.Data = table(BAM_data.ChannelName',zeros([1,length(BAM_data.interedted_channel_idx)])',zeros([1,length(BAM_data.interedted_channel_idx)])', BAM_config.max_save_memory','VariableNames',{'Ch','DataC', 'Valid','Mem'});
    pdata=zeros(length(BAM_data.interedted_channel_idx),20000);
    datacapture=zeros([1,length(BAM_data.interedted_channel_idx)]);
    datacapture_history = zeros([1,length(BAM_data.interedted_channel_idx)]);

    saving_time = GetSecs;
    load_interval_measure = GetSecs;
    AO_ClearChannelData();
    while(GetSecs-load_interval_measure<BAM_config.read_interval)    
    end
    load_interval_measure=GetSecs;
    delay_time = 0;
    update_capture_mark=[0,0]; % the first correspond to update_dataset, the second correspond to plot
    while(1)
            % acquiring data
            tic            
            for ii = 1:length(BAM_data.interedted_channel_idx)
                [~,pdata(ii,:),datacapture(ii)] = AO_GetChannelData(BAM_data.interedted_channel_idx(ii));
            end
            delay_time = delay_time + toc;
            
            AO_ClearChannelData();
            [BAM_data, BAM_data.location_progress] = fN_minium_prep(BAM_config,BAM_data, pdata,datacapture, app);
            app.DataCapture.Data(:,2) = table(datacapture_history');
            app.DataCapture.Data(:,3) = table(BAM_data.location_progress');
            pause(BAM_config.read_interval/20)

            if(min(update_capture_mark))
                datacapture_history = max(datacapture_history,datacapture);
            end

            [BAM_config, BAM_data, app, new_dataset] = fN_update_dataset(BAM_config, BAM_data, app);
            if(new_dataset)
                update_capture_mark=zeros(size(update_capture_mark));
                while(GetSecs-load_interval_measure<BAM_config.read_interval)    
                end
                continue;
            else
                update_capture_mark(1)=1;
            end
        [BAM_config, BAM_data, app] = fN_find_valid_trial(BAM_config, BAM_data, app);
        [BAM_config, BAM_data, app] = fN_stack_ev(BAM_config, BAM_data, app);

        
        if(GetSecs-saving_time>BAM_config.save_interval)
            app.delay_measurement.Text = ['miss ' ,num2str(1000*delay_time), 'ms to read data for ' ,num2str(BAM_config.save_interval), 's'];
            tic;[BAM_config, BAM_data, app] = fN_category_grpstat(BAM_config, BAM_data, app);disp(['bar' num2str(toc)]);
            tic;[BAM_config, BAM_data, app] = fN_plot_pipline(BAM_config, BAM_data, app);disp(['unit' num2str(toc)]);
            saving_time=GetSecs;
            delay_time=0;
            %tic;save('test_data.mat',"BAM_data");disp(['save' num2str(toc)]);
            update_capture_mark(2)=0;
        else
            update_capture_mark(2)=1;
        end

        while(GetSecs-load_interval_measure<BAM_config.read_interval)           
        end
        load_interval_measure=GetSecs;
    end
end

