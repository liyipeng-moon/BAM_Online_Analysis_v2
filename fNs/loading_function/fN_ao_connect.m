function [BAM_config,BAM_data, app] = fN_ao_connect(BAM_config, BAM_data, app)
%% connect to AO
    if(BAM_config.IP.DeviceFreeMode)
        BAM_config.IP.Connected=1;
        return;
    else
        try
            AO_CloseConnection
        end
        for ii = 1:50
            if(BAM_config.IP.Connected==1 || BAM_config.IP.Connected==10)
                disp('connected')
                break
            end
            pause(1)
            BAM_config.IP.Connected = AO_startConnection(BAM_config.IP.DSPMAC, BAM_config.IP.PCMAC, -1);
        end
    end

%% buffer channel
    for ii = 1:length(BAM_config.channel_name)
        interested_channel = BAM_config.channelidarr(ii);
        for tt = 1:10
            [rr2(ii)] = AO_AddBufferingChannel(interested_channel,5000);
        end
    end
    if(min(abs(rr2))==0)
        BAM_config.IP.Buffered = 1;
    end
    
end
