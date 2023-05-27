function [BAM_data] = fN_save_file(BAM_config,BAM_data,app)
    temp =  strrep(datestr(datetime), ':', '_');
    file_name = ['data/',BAM_config.today, '/uncheck_', temp(13:end),'.mat'];
    save(file_name,'BAM_data')
    cc_name = ['data/',BAM_config.today, '/config.mat'];
    save(cc_name,'BAM_config')
    BAM_data = fN_pre_register_data(BAM_config,BAM_data,app);
end