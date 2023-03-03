function [BAM_config, BAM_analysis, app]=fN_plot_stats(BAM_config, BAM_analysis, app)

% judge interested session
for ss = 1:length(BAM_analysis.dataset)
    if(strcmp(app.SelectSession.Value, BAM_analysis.dataset{ss}))
        combined_data = load(fullfile(BAM_analysis.ses_folder{ss},'combined_data.mat')).combined_data;
    end
end

% progress of one session

app.MemoryUseage.Value=100*find(~isnan(combined_data.EYE1), 1, 'last' )/BAM_config.session_max_length;
app.SessionTimeLabel.Text=['session progress ' num2str(BAM_config.session_max_length/1000) 's'];

% condition stats

[combined_data, BAM_config, BAM_analysis, app] = fN_find_valid_trial(combined_data, BAM_config, BAM_analysis, app);

pause(0.05)


BAM_config.img_vault = 'G:\Img_vault\matfile_pool';
BAM_analysis.img_info = load([fullfile(BAM_config.img_vault, app.SelectSession.Value(3:end)), '.mat']);

[combined_data, BAM_config, BAM_analysis, app] = fN_category_grpstat(combined_data, BAM_config, BAM_analysis, app);

combined_data.ev_train(combined_data.valid_onset);
combined_data.ev_time(combined_data.valid_onset);

interested_neuron = 1;

end