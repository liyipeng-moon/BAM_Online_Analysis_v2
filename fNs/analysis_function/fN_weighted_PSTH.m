function psth_out = fN_weighted_PSTH(psth_in, spk_in, img_idx_now, psth_range)
    useful_spk = spk_in(spk_in>psth_range(1) & spk_in<psth_range(end)) - psth_range(1);
    psth_in(img_idx_now, 1) = psth_in(img_idx_now, 1)+1;
    psth_in(img_idx_now, 1+useful_spk) = psth_in(img_idx_now, 1+useful_spk)+1;
    psth_out = psth_in;
end