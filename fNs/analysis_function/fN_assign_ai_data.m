function combined_data = fN_assign_ai_data(combined_data, ai_data, ai_time, first_time, max_ai_memory, field_name)
    if(ai_time.location<2)
        return
    end
    ai_name = field_name(5:end-5);
    ai_time.val(1:ai_time.location-1) = ai_time.val(1:ai_time.location-1) - first_time;
    if(~isfield(combined_data, ai_name))
        temp_array = nan([1, max_ai_memory]);
        combined_data = setfield(combined_data, ai_name, temp_array);
    end
    for cc = 1:ai_data.location-1
        small_data = ai_data.val(cc,:);
        small_data = small_data(~isnan(small_data));
        original_ai_field = getfield(combined_data, ai_name);
        original_ai_field(ai_time.val(cc): ai_time.val(cc)+ length(small_data)-1) = small_data;
        combined_data = setfield(combined_data, ai_name, original_ai_field);
    end
end