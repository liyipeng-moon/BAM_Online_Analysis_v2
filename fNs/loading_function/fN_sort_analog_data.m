function [ev_val, ev_time] = fN_sort_analog_data(datarr, datacapture, sr)
ev_val = resample(datarr(8:datacapture), 1000,sr);
ev_time = fN_Convert_TS(datarr([5,6]));
ev_time = int32(ev_time./(sr/1000))';
end