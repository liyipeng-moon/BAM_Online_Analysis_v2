function LFP_out = fN_weighted_LFP(LFP_original, LFP_in, img_idx)
LFP_in(isnan(LFP_in))=0;
LFP_original(img_idx, 2:end) = (LFP_original(img_idx, 1)*LFP_original(img_idx, 2:end) + LFP_in)./ (LFP_original(img_idx, 1)+1);
LFP_original(img_idx, 1) = LFP_original(img_idx, 1)+1;
LFP_out=LFP_original;
end