function subplotCallback(hobject,eventdata,signal_category,app,pp,uu,BAM_data)

electrode_to_plot = str2num(getfield(app,['ListBox' num2str(pp)]).Value(2:end));
do_clear=0;change_enable=0;
if(eventdata.Button==1) % left click
    change_enable = 1;
elseif(eventdata.Button==3) % right click
    do_clear = 1;
end

if(strcmp(signal_category,'LFP'))
    if(do_clear)
        app.LfpClearFlag(electrode_to_plot) = 1;
    end

    if(change_enable)
        if(hobject.Title.Color(1))
            hobject.Title.Color = [0,1,0];
        else
            hobject.Title.Color = [1,0,0];
        end
    end
end
if(strcmp(signal_category, 'Spike'))
    if(do_clear)
        app.SpikeClearFlag(electrode_to_plot,uu) = 1;
    end
    if(change_enable)
        [~,b] = AO_GetLatestTimeStamp;
        if(BAM_data.plot_ax(pp,2+uu).Title.Color(1))
            BAM_data.plot_ax(pp,2+uu).Title.Color = [0,1,0];
            state_now = 'Enable';
        else
            BAM_data.plot_ax(pp,2+uu).Title.Color = [1,0,0];
            state_now = 'Disable';
        end
        fprintf(app.fid, [state_now '\t' num2str(electrode_to_plot) '\t' num2str(uu) '\n']);
        text_now = [state_now 'Electrode ' num2str(electrode_to_plot), '  Unit ' num2str(uu),' at ' num2str(b)];
        AO_SendTextEvent(text_now)
        app.EnableUnit.Text = text_now;
    end
end
drawnow
end