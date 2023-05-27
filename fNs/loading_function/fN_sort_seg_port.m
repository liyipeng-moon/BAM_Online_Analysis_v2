function [ev_val, ev_time, spk_waveform, spk_number] = fN_sort_seg_port(datarr, datacapture,sr)
reshaped_datarr = reshape(datarr(1:datacapture),[datarr(1),datacapture/double(datarr(1))]);
ev_val = uint8(reshaped_datarr(4,:));
ev_time = fN_Convert_TS(reshaped_datarr([5,6],:)');
ev_time = int32(ev_time./(sr/1000))';

% about spike wave form?
spk_waveform = zeros([5,96]);
for uu = 0:4
    spk_idx = find(ev_val==uu);
    spk_number(uu+1)=length(spk_idx);
    if(~isempty(spk_idx))
        spk_waveform(uu+1, :) = mean(reshaped_datarr(8:end, spk_idx)');
    end
end


end

