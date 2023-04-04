function fN_plot_bar(img_category, spk_data, spk_time_start,spk_time_end,ax1,color_now)

num_of_category = length(img_category.category.name);
for cc = 1:num_of_category
    category_now = find(img_category.category.idx==cc);
    sample_num = sum(spk_data(category_now,1));
    spike_num = sum(sum(spk_data(category_now, spk_time_start:spk_time_end)));
    spk_num(cc) = spike_num/sample_num;
    fr(cc) = 1000*spk_num(cc)/(spk_time_end-spk_time_start);
end
    b = bar(ax1,fr);
    b.FaceColor = 'flat';
    for cc = 1:num_of_category
        b.CData(cc,:) = color_now.category(cc,:);
    end
    xticklabels(ax1, img_category.category.name)
end