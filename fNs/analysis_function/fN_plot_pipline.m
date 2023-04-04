function [BAM_config, BAM_data, app] = fN_plot_pipline(BAM_config, BAM_data, app)
if(length(BAM_data.img_onset_time)<20)
    return
end

spk_time_start = str2num(app.BarStart.Value);
spk_time_end = str2num(app.BarEnd.Value);
spk_time_start = -BAM_config.PSTH_start+spk_time_start;
spk_time_end = -BAM_config.PSTH_start+spk_time_end;

    for pp = [1,2]

        electrode_to_plot = str2num(getfield(app,['ListBox' num2str(pp)]).Value(2:end));
        fig_idx = ['F' num2str(pp)];
        ax1 = subplot(1,7,[1,2],'Parent', getfield(app,fig_idx));
        
        LFP_average = zeros([length(BAM_data.img_info.category.name), BAM_config.LFP_end-BAM_config.LFP_start]);
        for cc = 1:length(BAM_data.img_info.category.name)
            img_of_this_category = find(BAM_data.img_info.category.idx==cc);
            LFP_average(cc,:) = fN_category_mean_lfp(BAM_data.ev_LFP{electrode_to_plot}, img_of_this_category);
        end

        p=plot(ax1,LFP_average');
        for cc = 1:length(BAM_data.img_info.category.name)
            p(cc).Color=BAM_config.colormap.category(cc,:);
        end

        legend(ax1, BAM_data.img_info.category.name,'Location','westoutside')
        title(ax1,'LFP')
        if(app.BarButton.Value)
            for uu = 1:5
                spk_data_now = BAM_data.ev_PSTH{electrode_to_plot,uu};
                ax1 = subplot(1,7,2+uu,'Parent', getfield(app,fig_idx));
                fN_plot_bar(BAM_data.img_info, spk_data_now, spk_time_start,spk_time_end,ax1,BAM_config.colormap);
                title(ax1,['E' num2str(electrode_to_plot) 'U' num2str(uu-1)])
            end
        end
    end
drawnow
end