function [BAM_config, BAM_analysis, app]=fN_combine_mat(BAM_config, BAM_analysis, app)
    BAM_analysis.folder_today = [BAM_config.root_dir, 'data\',BAM_config.today_name, '*'];
    BAM_analysis.all_session = dir(BAM_analysis.folder_today);
    for ses = 1:length(BAM_analysis.all_session)
        ses_folder = fullfile(BAM_analysis.all_session(ses).folder, BAM_analysis.all_session(ses).name);
        BAM_analysis.ses_folder{ses} = ses_folder;
        all_uncheck = dir([ses_folder,'\uncheck*']);
    
        if(~isempty(all_uncheck))
            first_data = load([ses_folder,'\',all_uncheck(1).name]).BAM_data;
            BAM_analysis.first_time_stamp(ses) = fN_find_session_start(first_data)-BAM_config.session_buffer;
            BAM_analysis.dataset{ses} = [num2str(ses),'-',first_data.Dataset];
        else
            % which means there is no un-processed data or there is no data
            % yet, we can just jump over this session
            continue
        end

        % load combined data
        if(isempty(dir(fullfile(ses_folder, 'combined_data.mat'))))
            combined_data = struct;
            save(fullfile(ses_folder, 'combined_data.mat'), "combined_data")
        else
            combined_data = load(fullfile(ses_folder, 'combined_data.mat')).combined_data;
        end

        for mat_idx = 1:length(all_uncheck)
            temp_bam_data = load(fullfile(ses_folder, all_uncheck(mat_idx).name)).BAM_data;
            
            % adding temp mat to combined mat

            combined_data = fN_prep_and_stack_data(combined_data, temp_bam_data, BAM_analysis.first_time_stamp(ses), BAM_config.session_max_length);

            file_name = all_uncheck(mat_idx).name;
            eval(['!rename',' , ', fullfile(ses_folder, all_uncheck(mat_idx).name) ' ,' file_name(3:end) ])
        end
        save(fullfile(ses_folder, 'combined_data.mat'), "combined_data")
    end
    app.SelectSession.Items = BAM_analysis.dataset;
    app.SelectSession.Value = BAM_analysis.dataset{3};
end