function [BAM_config, BAM_data, app] = fN_check_clear_button(BAM_config, BAM_data, app)

%% LFP
clear_channels = find(app.LfpClearFlag);
if(~isempty(clear_channels))
    for electrode = clear_channels
        BAM_data.ev_LFP{electrode} = zeros(size(BAM_data.ev_LFP{electrode}));
        app.LfpClearFlag(electrode)=0;
    end
end

[uxx,uyy] = find(app.SpikeClearFlag);
if(~isempty(uxx))
    for idx = 1:length(uxx)
        BAM_data.ev_PSTH{uxx(idx), uyy(idx)} = zeros(size(BAM_data.ev_PSTH{uxx(idx), uyy(idx)}));
        app.SpikeClearFlag(uxx(idx), uyy(idx))=0;
    end
end

% 
% if(app.LfpClearFlag(1))
%     keyboard
% end
% 
%     for pp = 1:BAM_config.eui_num
%         electrode_to_plot = str2num(getfield(app,['ListBox' num2str(pp)]).Value(2:end));
%         % clear LFP
%         field_name = ['ClearLFP' num2str(pp) 'Button'];
%         if(getfield(app,field_name).Value)
%             BAM_data.ev_LFP{electrode_to_plot} = zeros(size(BAM_data.ev_LFP{electrode_to_plot}));
%             temp_field = getfield(app,field_name);
%             temp_field.Value = 0;
%             setfield(app,field_name, temp_field);
%         end
% 
%         % clear unit
%         for uu = 1:5
%             field_name = ['ClearP' num2str(pp), 'U' num2str(uu-1) ,'Button'];
%             if(getfield(app,field_name).Value)
%                 BAM_data.ev_PSTH{electrode_to_plot,uu} = zeros(size(BAM_data.ev_PSTH{electrode_to_plot,uu}));
%                 temp_field = getfield(app,field_name);
%                 temp_field.Value = 0;
%                 setfield(app,field_name, temp_field);
%             end
%        end
%     end
% 
end