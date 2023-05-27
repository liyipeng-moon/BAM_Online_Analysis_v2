function fN_plot_PSTH(BAM_data, spk_data,pp,uu, start_time)

    num_of_category = length(BAM_data.img_info.category.name);
    for cc = 1:num_of_category
        category_now = find(BAM_data.img_info.category.idx==cc);
        sample_num = sum(spk_data(category_now,1));
        spike_num_series = sum(spk_data(category_now, :));
        bins_now = BAM_data.PSTH_time_bins;
        bins_now = bins_now + abs(start_time)+1;
        PSTH = zeros([1,length(bins_now)-1]);
        for bb = 1:length(PSTH)
            PSTH(bb) = sum(spike_num_series(bins_now(bb):bins_now(bb+1)));
        end
        
        %PSTH = mean(spike_num_series);
        fr = PSTH./sample_num; % the spike number per bin per onset
        fr = fr*1000/BAM_data.PSTH_widt;
        set(BAM_data.PSTH_handle{pp,uu}(cc),'YData',fr);
    end
    
end