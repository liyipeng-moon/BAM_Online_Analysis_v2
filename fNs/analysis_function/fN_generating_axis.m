function [BAM_config, BAM_data, app] = fN_generating_axis(BAM_config, BAM_data, app)
%% plotting axis
    if(~strcmp(app.WhichDataset.Text,'NULL'))

        if(isfield(BAM_data, 'plot_ax')) new_axis = 0; else new_axis = 1; end
        
        num_of_category = length(BAM_data.img_info.condition_nm);
        LFP_time_series = sort(resample(BAM_config.LFP_start:BAM_config.LFP_end-1,1,1*BAM_config.LFP_plot_down_sample_rate));
        fake_lfp = ones([num_of_category, length(LFP_time_series)]);

        %PSTH_time_series = sort(resample(BAM_config.PSTH_start:BAM_config.PSTH_end-1,1,1*BAM_config.LFP_plot_down_sample_rate));
        fake_psth = rand([num_of_category, BAM_config.PSTH_NumBin]);
        BAM_data.PSTH_time_bins = floor(linspace(BAM_config.PSTH_start, BAM_config.PSTH_end, BAM_config.PSTH_NumBin+1));
        PSTH_halfband = floor(0.5*(BAM_config.PSTH_end-BAM_config.PSTH_start)/BAM_config.PSTH_NumBin);
        PSTH_time_series = BAM_data.PSTH_time_bins(1:end-1)+PSTH_halfband;
        BAM_data.PSTH_widt = BAM_config.PSTH_width;
        ui_num = BAM_config.eui_num;
            for pp = 1:ui_num
                fig_idx = ['F' num2str(pp)];
                if(new_axis) 
                    BAM_data.plot_ax(pp,1) = subplot(1,7,[1,2],'Parent', getfield(app,fig_idx));
                    %disableDefaultInteractivity(BAM_data.plot_ax(pp,1));
                end
                BAM_data.lfp_handle{pp}=plot(BAM_data.plot_ax(pp,1),LFP_time_series,fake_lfp);
                for cc = 1:length(BAM_data.img_info.condition_nm)
                    BAM_data.lfp_handle{pp}(cc).Color=BAM_data.img_info.category_color(cc,:);
                end
                title(BAM_data.plot_ax(pp,1), ['LFP'])
                BAM_data.plot_ax(pp,1).Title.Color = BAM_config.colormap.red;
                BAM_data.plot_ax(pp,1).Title.FontWeight='bold';
                set(BAM_data.plot_ax(pp,1), 'ButtonDownFcn', @(hobject,eventdata) subplotCallback(hobject,eventdata,'LFP',app, pp))
                set(BAM_data.plot_ax(pp,1),'YLim',[-1000,1000])

                for uu = 1:5
                    if(new_axis) 
                        BAM_data.plot_ax(pp,2+uu) = subplot(1,7,2+uu,'Parent', getfield(app,fig_idx)); 
                        %disableDefaultInteractivity(BAM_data.plot_ax(pp,2+uu));
                    else
                        Current_title = get(BAM_data.plot_ax(pp,2+uu), 'Title');
                        Unit_color = Current_title.Color;
                    end
                    %% generating bar axis
                    if(app.BarButton.Value)
                        BAM_data.plot_method = 'Bar';
                        BAM_data.bar_handle{pp,uu} = bar(BAM_data.plot_ax(pp,2+uu),ones([1,num_of_category]));
                        BAM_data.bar_handle{pp,uu}.FaceColor = 'flat';
                        for cc = 1:num_of_category
                            BAM_data.bar_handle{pp,uu}.CData(cc,:)=BAM_data.img_info.category_color(cc,:);
                        end
                        xticklabels(BAM_data.plot_ax(pp,2+uu), BAM_data.img_info.condition_nm)
                        set(BAM_data.bar_handle{pp,uu}, 'ButtonDownFcn', @(hobject,eventdata) subplotCallback(hobject,eventdata,'Spike',app,pp,uu,BAM_data))                       
                        
                    end
                    %% generating PSTH axis
                    if(app.PSTHButton.Value)
                        BAM_data.plot_method = 'PSTH';
                        BAM_data.PSTH_handle{pp,uu}=plot(BAM_data.plot_ax(pp,uu+2),PSTH_time_series,fake_psth);
                        for cc = 1:length(BAM_data.img_info.condition_nm)
                            BAM_data.PSTH_handle{pp,uu}(cc).Color=BAM_data.img_info.category_color(cc,:);
                        end
                        xlabel(BAM_data.plot_ax(pp,uu+2),'ms')
                        set(BAM_data.PSTH_handle{pp,uu}, 'ButtonDownFcn', @(hobject,eventdata) subplotCallback(hobject,eventdata,'Spike',app,pp,uu,BAM_data))

                    end
                    
                    %% generating user defined axis
                    if(app.UserDefinedButton.Value)
                        BAM_data.plot_method = 'UserDefined';
                        BAM_data = fN_UD_generating_example(BAM_config,BAM_data,app,pp,uu,BAM_data);
                    end

                    title(BAM_data.plot_ax(pp,2+uu),['U', num2str(uu-1)]);
                    BAM_data.plot_ax(pp,2+uu).Title.FontWeight='bold';
                    if(~new_axis)
                        BAM_data.plot_ax(pp,2+uu).Title.Color = Unit_color;
                    else
                        BAM_data.plot_ax(pp,2+uu).Title.Color = BAM_config.colormap.red;
                    end

                end
            end
    end
    drawnow
    % function end
end
