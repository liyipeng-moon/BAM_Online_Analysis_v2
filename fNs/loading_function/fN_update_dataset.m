function [BAM_config, BAM_data, app, continue_flag] = fN_update_dataset(BAM_config, BAM_data, app)
    continue_flag = 0;
    all_event = BAM_data.big_ev_train.val(1:BAM_data.big_ev_train.location-1);
    if(any(all_event>100 & all_event<600)) % check dataset
        temp_array = all_event((all_event>100 & all_event<600));
        temp_array = mod(temp_array,100);
        dataset_now = BAM_config.dataset_name{temp_array(1)};
        if(~strcmp(app.WhichDataset.Text,dataset_now))
%             [BAM_data] = fN_save_file(BAM_config,BAM_data,app);
            % save current data
            % save current result
            % re-pre-register data

            app.WhichDataset.Text = dataset_now;

            pause(0.05)

            [BAM_config,BAM_data, app] = fN_add_buffer(BAM_config, BAM_data, app);
            BAM_data.Dataset = dataset_now;
            continue_flag = 1;
        end
    end
    
end