function fN_UD_updating_example(BAM_data,spk_data_now,spk_time_start,spk_time_end,pp,uu);


    num_of_category = length(BAM_data.img_info.category.name);
    for cc = 1:num_of_category
        category_now = find(BAM_data.img_info.category.idx==cc);
        sample_num = sum(spk_data_now(category_now,1));
        spike_num = sum(sum(spk_data_now(category_now, spk_time_start:spk_time_end)));
        spk_num(cc) = spike_num/sample_num;
        fr(cc) = 1000*spk_num(cc)/(spk_time_end-spk_time_start);
    end
    set(BAM_data.UD_handle{pp,uu},'YData',fr)