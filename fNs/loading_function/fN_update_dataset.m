function [BAM_config, BAM_data, app, continue_flag] = fN_update_dataset(BAM_config, BAM_data, app)
    
    success_flag = 0;
    continue_flag = 0;

    while(~success_flag)
        try
            received_datasets = load([BAM_config.ML_folder,'\DM.mat']).img_info;
            success_flag=1;
        catch
            pause(0.1)
        end
    end

    BAM_data.Dataset = app.WhichDataset.Text;
    BAM_data.img_info = received_datasets;
    if(~isempty(received_datasets)) % check dataset
        dataset_now = received_datasets.selected_dataset;
        if(~strcmp(app.WhichDataset.Text,dataset_now))
%             [BAM_data] = fN_save_file(BAM_config,BAM_data,app);
            % save current data
            % save current result
            % re-pre-register data
            app.WhichDataset.Text = dataset_now;
            example_img = received_datasets.example_img;
            imwrite(example_img,['Data/',dataset_now,'.png']);
            app.ExampleImage.ImageSource = ['Data/' ,dataset_now,'.png'];
            pause(0.3)

            BAM_data.Dataset = dataset_now;
            
            [BAM_config,BAM_data, app] = fN_add_buffer(BAM_config, BAM_data, app);
            
            %% generating plotting axis
            [BAM_config, BAM_data, app] = fN_generating_axis(BAM_config, BAM_data, app);
            continue_flag = 1;
        end
    end
    
end