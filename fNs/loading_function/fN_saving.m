function [BAM_config,BAM_data, app] = fN_saving(BAM_config, BAM_data, app)
%%

    %% adding channel name accaording to electrode
    [BAM_config,BAM_data, app] = fN_add_buffer(BAM_config, BAM_data, app);

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
    while(1)
            tic
            for ii = 1:length(BAM_data.interedted_channel_idx)
                [~,pdata(ii,:),datacapture(ii)] = AO_GetChannelData(BAM_data.interedted_channel_idx(ii));
            end
            delay_time = delay_time + toc;
            AO_ClearChannelData();

            datacapture_history = max(datacapture_history,datacapture);

            [BAM_data, location_progress] = fN_minium_prep(BAM_config,BAM_data, pdata,datacapture, app);
            app.DataCapture.Data(:,2) = table(datacapture_history');
            app.DataCapture.Data(:,3) = table(location_progress');
            pause(BAM_config.read_interval/10)
            [BAM_config, BAM_data, app, new_dataset] = fN_update_dataset(BAM_config, BAM_data, app);
            if(new_dataset)
                while(GetSecs-load_interval_measure<BAM_config.read_interval)    
                end
                continue;
            end

        if(GetSecs-saving_time>BAM_config.save_interval)
            app.delay_measurement.Text = ['miss ' ,num2str(1000*delay_time), 'ms to read data for ' ,num2str(BAM_config.save_interval), 's'];
            [BAM_config, BAM_data, app] = fN_find_valid_trial(BAM_config, BAM_data, app);
            %[BAM_data] = fN_save_file(BAM_config,BAM_data,app);

            [BAM_config, BAM_data, app] = fN_category_grpstat(BAM_config, BAM_data, app);
            saving_time=GetSecs;
            delay_time=0;
        end
        while(GetSecs-load_interval_measure<BAM_config.read_interval)    
        end
        load_interval_measure=GetSecs;
    end
end

