function [BAM_config,BAM_data, app] = fN_add_buffer(BAM_config, BAM_data, app)
BAM_data.ChannelName={};
    BAM_data.interedted_channel_idx=fN_find_channel_idx(BAM_config,'eventcode');
    BAM_data.ChannelName{end+1} = 'EventCode';
    %% adding electrode, shall we change this to a function?
    for ii = 1:BAM_config.MaxElectrode
        if(BAM_config.ElectrodeUsing(ii))
            BAM_data.interedted_channel_idx=[BAM_data.interedted_channel_idx, fN_find_channel_idx(BAM_config,['lfp', num2str(ii)]),fN_find_channel_idx(BAM_config,['seg',num2str(ii)])];
            BAM_data.ChannelName{end+1} = ['LFP', num2str(ii)];
            BAM_data.ChannelName{end+1} = ['SEG', num2str(ii)];
        end
    end
    [BAM_config,BAM_data,app, max_save_memory] = fN_pre_register_data(BAM_config,BAM_data,app);
    BAM_config.max_save_memory = max_save_memory;
end
