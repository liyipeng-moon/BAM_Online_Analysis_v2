function LFP_average = fN_category_mean_lfp(lfp_input, img_of_this_category)
    
    LFP_average = sum(lfp_input(img_of_this_category,1).*lfp_input(img_of_this_category,2:end))./sum(lfp_input(img_of_this_category,1));
end