function app = fN_change_gui_color(app,BAM_config,BAM_data)
%% about saving
% you dont need do modify this code when adding channel
if(BAM_config.is_saving)
    app.SavingLamp.Color=BAM_config.colormap.green;
    app.SavingLampLabel.Text='Saving';
else
    app.SavingLamp.Color=BAM_config.colormap.red;
    app.SavingLampLabel.Text='Stopped';
end

end
