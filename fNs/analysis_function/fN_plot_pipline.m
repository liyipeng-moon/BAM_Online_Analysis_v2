function [BAM_config, BAM_data, app] = fN_plot_pipline(BAM_config, BAM_data, app)
% if(length(BAM_data.img_onset_time)>100)
%     keyboard
% else
%     return
% end
if(~BAM_data.do_analysis)
    return
end

for cc = 1:length(BAM_data.img_info.category.name)
    category_location{cc} = find(BAM_data.img_info.category.idx(BAM_data.img_idx)==cc);
    category_onset{cc} = BAM_data.img_onset_time(category_location{cc});
    time_start = -150;
    time_end = 300;
    lfp_time_start{cc} = category_onset{cc}+time_start;
    spk_time_start{cc} = category_onset{cc}+str2num(app.BarStart.Value);
    lfp_time_end{cc} = category_onset{cc}+time_end;
    spk_time_end{cc} = category_onset{cc}+str2num(app.BarEnd.Value);
end
spk_bar_time = str2num(app.BarEnd.Value) - str2num(app.BarStart.Value);
    for pp = 1
        getfield(app, 'ListBox1').Value
        electrode_to_plot = str2num(getfield(app,['ListBox' num2str(pp)]).Value(2:end));
        fig_idx = ['F' num2str(pp)];
        ax1 = subplot(1,7,[1,2],'Parent', getfield(app,fig_idx));
        %hold(ax1)
        lfp_val = getfield(BAM_data, ['big_LFP' num2str(electrode_to_plot) '_train']).val;
        for cc = 1:length(lfp_time_start)
            LFP_sum = zeros([1,time_end-time_start+1]);
                for sample_now = 1:length(lfp_time_end{cc})
                    LFP_sum = sum([LFP_sum' , lfp_val(lfp_time_start{cc}(sample_now):lfp_time_end{cc}(sample_now))']','omitnan');
                end
            LFP_average(cc,:) = LFP_sum./length(lfp_time_start{cc});
        end
        plot(ax1,time_start:time_end,LFP_average)
        legend(ax1, BAM_data.img_info.category.name,'Location','westoutside')
        title(ax1,'LFP')
        spk_data = getfield(BAM_data, ['big_spk' num2str(electrode_to_plot) '_time']);
        if(app.BarButton.Value)
            for ii = 1:5
                ax1 = subplot(1,7,2+ii,'Parent', getfield(app,fig_idx));
                fN_plot_bar(BAM_data.img_info, spk_data{ii}, spk_time_start,spk_time_end,ax1,BAM_config.colormap.unit{ii},spk_bar_time);
                title(ax1,['E' num2str(electrode_to_plot) 'U' num2str(ii-1)])
            end
        end
    end
drawnow
end