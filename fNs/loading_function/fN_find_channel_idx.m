function this_idx = fN_find_channel_idx(BAM_config, channel_name)
    for ii = 1:length(BAM_config.channel_name)
        if(strcmp(channel_name,BAM_config.channel_name{ii}))
            this_idx=BAM_config.channelidarr(ii);
        end
    end
end