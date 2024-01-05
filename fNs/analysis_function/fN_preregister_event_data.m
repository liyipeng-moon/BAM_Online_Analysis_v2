function [BAM_config,BAM_data] = fN_preregister_event_data(BAM_config,BAM_data,app)
if(~strcmp(app.WhichDataset.Text,'NULL'))
    if(~isfield(BAM_data,'img_info'))
        BAM_data.img_info = load('Data/temp_dataset.mat').received_datasets;
    end
    
    img_num = length(BAM_data.img_info.category_idx);
    psth_template = zeros(img_num, BAM_config.PSTH_end-BAM_config.PSTH_start+1);
    lfp_template = zeros(img_num, BAM_config.LFP_end-BAM_config.LFP_start+1);
    ev_PSTH = cell(0);
    ev_LFP = cell(0);
    for ii = 1:BAM_config.MaxElectrode
        if(BAM_config.ElectrodeUsing(ii))
            for uu = 1:5
                ev_PSTH{ii,uu} = psth_template;
            end
            ev_LFP{ii}=lfp_template;
        end
    end
    BAM_data.ev_PSTH = ev_PSTH;
    BAM_data.ev_LFP = ev_LFP;
end
end