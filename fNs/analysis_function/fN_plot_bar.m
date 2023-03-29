function fN_plot_bar(img_category, spk_data, spk_time_start,spk_time_end,ax1,color_now, spk_bar_time)

bar(ax1, rand([1,6]))
return
    spk_bar_time = spk_bar_time/100;
    num_of_category = length(spk_time_start);
    spk_sum = zeros([1,num_of_category]);
    for cc = 1:num_of_category
        for sample_now = 1:length(spk_time_start{cc})
            spk_sum(cc) = spk_sum(cc)+length(find(spk_time_start{cc}(sample_now)<spk_data.val & spk_data.val<spk_time_end{cc}(sample_now)));
        end
        spk_sum(cc) = spk_sum(cc)/spk_bar_time;

    end
        bar(ax1,spk_sum)
        xticklabels(ax1, img_category.category.name)
end