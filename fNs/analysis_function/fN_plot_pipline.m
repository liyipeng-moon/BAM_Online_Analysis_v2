function [BAM_config, BAM_data, app] = fN_plot_pipline(BAM_config, BAM_data, app)

if(length(BAM_data.img_onset_time)<10 || strcmp(app.WhichDataset.Text,'NULL'))
    return
end

if(~getfield(app,[BAM_data.plot_method, 'Button']).Value)
    [BAM_config, BAM_data, app] = fN_generating_axis(BAM_config, BAM_data, app);
end

report_plot_time=0;

LFP_plot_down_sample_rate = BAM_config.LFP_plot_down_sample_rate;
% plotting parameters
spk_time_start = -BAM_config.PSTH_start+str2num(app.BarStart.Value);
spk_time_end = -BAM_config.PSTH_start+str2num(app.BarEnd.Value);
LFP_time_series = resample(BAM_config.LFP_start:BAM_config.LFP_end-1,1,1*LFP_plot_down_sample_rate);

% plotting
    for pp = 1:BAM_config.eui_num
        electrode_to_plot = str2num(getfield(app,['ListBox' num2str(pp)]).Value(2:end));
        tic
        LFP_average = zeros([length(BAM_data.img_info.category.name), BAM_config.LFP_end-BAM_config.LFP_start]);
        for cc = 1:length(BAM_data.img_info.category.name)
            img_of_this_category = find(BAM_data.img_info.category.idx==cc);
            LFP_average = fN_category_mean_lfp(BAM_data.ev_LFP{electrode_to_plot}, img_of_this_category);
            set(BAM_data.lfp_handle{pp}(cc),'YData',resample(LFP_average,1,1*LFP_plot_down_sample_rate))
        end
        %legend(ax1, BAM_data.img_info.category.name,'Location','westoutside')
        if(report_plot_time) disp(['plot lfp cost ' ,num2str(toc)]); end
        
        tic
        for uu = 1:5
            spk_data_now = BAM_data.ev_PSTH{electrode_to_plot,uu};
            if(app.BarButton.Value)
                BAM_data.plot_method = 'Bar';
                fN_plot_bar(BAM_data, spk_data_now, spk_time_start,spk_time_end,pp,uu);
            end
            if(app.PSTHButton.Value)
                BAM_data.plot_method = 'PSTH';
                fN_plot_PSTH(BAM_data,spk_data_now, pp,uu,BAM_config.PSTH_start)
            end
            if(app.UserDefinedButton.Value)
                BAM_data.plot_method = 'UserDefined';
                fN_UD_updating_example(BAM_data,spk_data_now,spk_time_start,spk_time_end,pp,uu);
            end
        end
        if(report_plot_time) disp(['plot all unit cost ' ,num2str(toc)]); end
            
    end

drawnow
end