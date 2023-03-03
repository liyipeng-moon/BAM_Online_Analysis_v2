function first_time_stamp = fN_find_session_start(first_data)
all_data_field = fieldnames(first_data);
time_all = [];
for ii = 1:length(all_data_field)
    field_end_now = all_data_field{ii}(end-3:end);
    if(strcmp(field_end_now, 'time'))
        time_all = [time_all, min(getfield(first_data, all_data_field{ii}).val)];
    end
end
first_time_stamp = min(time_all);
end