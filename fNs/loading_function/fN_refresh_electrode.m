function [BAM_config,BAM_data, app] = fN_refresh_electrode(BAM_config, BAM_data, app)

pause(0.1)
%% electrode changing
for electrode = 1:BAM_config.MaxElectrode
    lfp_field = ['ChannelUsingLFP' num2str(electrode)];
    lfp_field = ['E' num2str(electrode), 'CheckBox'];
    temp = getfield(app,lfp_field);
    BAM_config.ElectrodeUsing(electrode) = temp.Value;
    if(BAM_config.ElectrodeUsing(electrode))
        for channel = 1:BAM_config.MaxUnit
            BAM_config.Electrode(electrode,channel).Using=1;
        end
    else
        for channel = 1:BAM_config.MaxUnit
            BAM_config.Electrode(electrode,channel).Using=0;
            BAM_config.Electrode(electrode,channel).UID = 0;
        end
    end
end
end