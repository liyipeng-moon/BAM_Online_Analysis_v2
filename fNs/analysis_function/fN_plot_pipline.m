function [BAM_config, BAM_data, app] = fN_plot_pipline(BAM_config, BAM_data, app)
% if(length(BAM_data.img_onset_time)>100)
%     keyboard
% end
if(~BAM_data.do_analysis)
    return
end

for cc = 1:length(BAM_data.img_info.category.name)
    category_location{cc} = find(BAM_data.img_info.category.idx(BAM_data.img_idx)==cc);
    category_onset{cc} = BAM_data.img_onset_time(category_location{cc});
    time_start = -250;
    time_end = 500;
    lfp_time_start{cc} = category_onset{cc}+time_start;
    lfp_time_end{cc} = category_onset{cc}+time_end;
end

using_lfp = find(BAM_config.ElectrodeUsing);
for lfp_idx = 1:length(using_lfp)
    lfp_now = using_lfp(lfp_idx);
    app.Panel.AutoResizeChildren='off';
    ax1 = subplot(1,length(using_lfp),lfp_idx,'Parent', app.Panel);
    hold(ax1)

    lfp_val = getfield(BAM_data, ['big_LFP' num2str(lfp_now) '_train']).val;
    for cc = 1:length(lfp_time_start)
        LFP_sum = zeros([1,time_end-time_start+1]);
            for sample_now = 1:length(lfp_time_end{cc})
                LFP_sum = sum([LFP_sum' , lfp_val(lfp_time_start{cc}(sample_now):lfp_time_end{cc}(sample_now))']','omitnan');
            end
        LFP_average(cc,:) = LFP_sum./length(lfp_time_start{cc});
        plot(ax1,time_start:time_end,LFP_average(cc,:),'Color',BAM_config.colormap.category(cc,:))
    end
    
    %if(lfp_idx==length(using_lfp))
        legend(ax1, BAM_data.img_info.category.name,'Location','eastoutside')
    %end
    title(ax1,['LFP ' num2str(lfp_now)])
end
    pause(0.1)
end