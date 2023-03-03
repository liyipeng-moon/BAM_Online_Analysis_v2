function combined_data = fN_assign_ev_data(combined_data, field_data, field_name, first_time)

if(strcmp(field_name, 'big_ev_time'))
    field_data.val(1:field_data.location-1) =  field_data.val(1:field_data.location-1) - first_time;
end
    useful_data_num =  field_data.location;
    if(useful_data_num>1) % with valid data
        channel_name = field_name(5:end);
        if(~isfield(combined_data, channel_name)) % asign this field for the first time
            field_val = field_data.val(1:useful_data_num-1);
            combined_data = setfield(combined_data, channel_name, field_val);
        else % adding data to the field
            old_data = getfield(combined_data, channel_name);
            new_data = [old_data, field_data.val(1:useful_data_num-1)];
            combined_data = setfield(combined_data, channel_name, new_data);
        end
    end
end