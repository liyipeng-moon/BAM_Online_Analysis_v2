function [BAM_config,BAM_data,app, max_save_memory] = fN_pre_register_data(BAM_config,BAM_data,app)
    % event code
    max_save_memory = [BAM_config.session_max_length*10];
    lfp_memory = floor(BAM_config.ai_downsample*BAM_config.session_max_length);
    spk_memory = floor([BAM_config.session_max_length * 100]);
    BAM_data.big_ev_train.val=nan([1,max_save_memory]);BAM_data.big_ev_train.location=1;
    BAM_data.big_ev_time.val=nan([1,max_save_memory]);BAM_data.big_ev_time.location=1;
    eye_memory = true([1, lfp_memory]);
for ii = 1:BAM_config.MaxElectrode
    if(BAM_config.ElectrodeUsing(ii))
        % % LFP
        temp_field.val=nan([1,lfp_memory]);
        temp_field.location=1;
        field_name = ['big_LFP' num2str(ii) '_train'];
        BAM_data = setfield(BAM_data,field_name,temp_field);
        max_save_memory = [max_save_memory, lfp_memory];
        % spk
        for uu = 1:5
            spk_temp_field{uu}.val=nan([1,spk_memory]);
            spk_temp_field{uu}.location=1;
        end
        field_name = ['big_spk' num2str(ii) '_time'];
        BAM_data = setfield(BAM_data, field_name, spk_temp_field);  
        max_save_memory = [max_save_memory, spk_memory];
    end
end
        BAM_data.eye_in = eye_memory;

end