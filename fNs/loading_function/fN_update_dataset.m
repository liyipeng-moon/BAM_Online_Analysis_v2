function [BAM_config, BAM_data, app, continue_flag] = fN_update_dataset(BAM_config, BAM_data, app)
    continue_flag = 0;
    all_event = BAM_data.big_ev_train.val(1:BAM_data.big_ev_train.location-1);
    BAM_data.Dataset = app.WhichDataset.Text;
    if(any(all_event>100 & all_event<600)) % check dataset
        
        temp_array = all_event((all_event>100 & all_event<200));
        temp_array = mod(temp_array,100);
        
        dataset_now = BAM_config.dataset_name{temp_array(end)};

        if(~strcmp(app.WhichDataset.Text,dataset_now))
%             [BAM_data] = fN_save_file(BAM_config,BAM_data,app);
            % save current data
            % save current result
            % re-pre-register data
            
            app.WhichDataset.Text = dataset_now;
            example_img = dir([BAM_config.img_vault '\datasets\*' dataset_now '*']).name;
            app.ExampleImage.ImageSource = [BAM_config.img_vault '\datasets\' example_img];
            pause(0.1)
            BAM_data.Dataset = dataset_now;
            BAM_data.img_info = load([BAM_config.img_vault,'/matfile_pool/',BAM_data.Dataset,'.mat']);
            [BAM_config,BAM_data, app] = fN_add_buffer(BAM_config, BAM_data, app);

            %% generating plotting axis
            [BAM_config, BAM_data, app] = fN_generating_axis(BAM_config, BAM_data, app);
            continue_flag = 1;
        end
    end
    
end