function [ev_val, ev_time] = fN_sort_digital_port(datarr, datacapture,sr)


reshaped_datarr = reshape(datarr(1:datacapture),[datarr(1),datacapture/double(datarr(1))]);
ev_val = uint16(reshaped_datarr(4,:));
ev_time = fN_Convert_TS(reshaped_datarr([5,6],:)');
ev_time = int32(ev_time./(sr/1000))';
% about spike wave form?
end

