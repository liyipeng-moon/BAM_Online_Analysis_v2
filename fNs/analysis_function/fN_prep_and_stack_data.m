function combined_data = fN_prep_and_stack_data(combined_data, temp_bam_data, first_time, max_ai_memory)

all_avai_data = fieldnames(temp_bam_data);
continue_flag = 0;
for field_now = 1:length(all_avai_data)
    if(continue_flag)
        continue_flag = 0;
        continue
        % which means this channel is pre-processed in tha last for loop
    end
    
    field_name = all_avai_data{field_now};
    if(strcmp(field_name(1:3),'big')) % useful channel
        switch field_name(5:7)
            case 'ev_'
                combined_data = fN_assign_ev_data(combined_data, getfield(temp_bam_data, field_name), field_name, first_time);
            case 'spk'
                spk_data = getfield(temp_bam_data, field_name); % spk data
                field_name = all_avai_data{field_now+1};
                spk_time = getfield(temp_bam_data, field_name); % spk time
                electrode_idx = str2num(field_name(8));
                electrode_config = temp_bam_data.Electrode(electrode_idx,:);
                combined_data = fN_assign_spk_data(combined_data, spk_data, spk_time, electrode_config, first_time, electrode_idx);
                continue_flag = 1;
            otherwise % lfp of eye
                ai_data = getfield(temp_bam_data, field_name);
                field_name = all_avai_data{field_now+1};
                ai_time = getfield(temp_bam_data, field_name);
                combined_data = fN_assign_ai_data(combined_data, ai_data, ai_time, first_time, max_ai_memory, field_name);
                continue_flag = 1;
        end

    end

    
end


end






