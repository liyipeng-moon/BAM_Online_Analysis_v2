function [BAM_config, BAM_data, app] = fN_stack_ev(BAM_config, BAM_data, app)
    if(~strcmp(app.WhichDataset.Text,'NULL') && isfield(BAM_data, 'valid_onset'))
            if(length(BAM_data.img_onset_time)>5)
                % which means we got valid data
                if(~isfield(BAM_data, 'picked_idx'))
                    BAM_data.picked_idx=1;
                end
                nearest_time = BAM_data.img_onset_time(end);
                last_image = find((nearest_time-BAM_data.img_onset_time)>1000,1,'last');
                picking_idx = BAM_data.picked_idx:last_image;
%                 disp(['Stacking ' num2str(length(picking_idx)), ' images'])
%                 disp(['Last image is' num2str(last_image)])
                BAM_data.picked_idx =last_image+1;
                for img_now = picking_idx
                    onset_time_now = BAM_data.img_onset_time(img_now);
                    img_idx_now = BAM_data.img_idx(img_now);
                    LFP_time_series = onset_time_now+BAM_config.LFP_start:onset_time_now+BAM_config.LFP_end-1;
                    PSTH_time_series = onset_time_now+BAM_config.PSTH_start:onset_time_now+BAM_config.PSTH_end-1;
                    for ee = 1:BAM_config.MaxElectrode
                        if(BAM_config.ElectrodeUsing(ee))
                            lfp_val = getfield(BAM_data, ['big_LFP' num2str(ee) '_train']).val;
                            
                            BAM_data.ev_LFP{ee} = fN_weighted_LFP(BAM_data.ev_LFP{ee}, lfp_val(LFP_time_series),img_idx_now);
                            spk_data = getfield(BAM_data, ['big_spk' num2str(ee) '_time']);
                            for uu = 1:5
                                BAM_data.ev_PSTH{ee,uu} = fN_weighted_PSTH(BAM_data.ev_PSTH{ee,uu}, spk_data{uu}.val, img_idx_now, PSTH_time_series);
                            end
                        end
                    end
                end
            end
    end
end
