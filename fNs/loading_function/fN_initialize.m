function [BAM_config, BAM_data, app] = fN_initialize(app, mode_now, BAM_config,BAM_data)


wrong_txt=[];
if(nargin<2)
    mode_now = 'initial_all';
    BAM_config = [];
    BAM_data = [];
end
if(strcmp(mode_now, 'initial_all'))
    load('default_params.mat')
    BAM_data=[];
    Wait_interval = 0.01; % wait to show state bar
    app.SavingLamp.Color=BAM_config.colormap.blue;
    BAM_config.is_saving = 0;
    %% check what dataset we have
    % try
    %     copyfile([BAM_config.remote_img_vault, '\matfile_pool'], [BAM_config.img_vault,'\matfile_pool']);
    %     copyfile([BAM_config.remote_img_vault, '\datasets'], [BAM_config.img_vault,'\datasets']);
    % catch
    %     wrong_txt = 'Sync Remote Dataset Wrong';
    % end
    % try
    %     app.SavingLampLabel.Text='Load Dataset Success';
    %     %all_dataset = dir([BAM_config.img_vault,'\matfile_pool\*mat']);
    % 
    %     BAM_config.dataset_name = {};
    %     for ii = 1:length(all_dataset)
    %         BAM_config.dataset_name{end+1} = all_dataset(ii).name(1:end-4);
    %     end
    %     BAM_config.dataset_name{end+1} = 'NULL';
    %     pause(Wait_interval)
    % catch
    %     wrong_txt = 'Load Dataset Wrong';
    % end
    %%
    app.SavingLampLabel.Text='Adding AO Path';
    addpath(genpath(BAM_config.AO_dir))
    
    [BAM_config,BAM_data, app] = fN_ao_connect(BAM_config, BAM_data, app);
    if(~BAM_config.IP.Connected)
        wrong_txt='Fail to Connect to AO';
    end
    if(~BAM_config.IP.Buffered)
        wrong_txt='Fail to Buffer';
    end
    
    if(isempty(wrong_txt))
        % initialize success
        app.SavingLampLabel.Text='Wait to Srart:)' ;
        app.SavingLamp.Color = BAM_config.colormap.blue;
    else
        % display wrong info
        app.SavingLampLabel.Text=wrong_txt;
        app.SavingLamp.Color = BAM_config.colormap.white;
    end
     %% set electrode for the first time
%     [BAM_config, BAM_data, app] = fN_assign_electrode(BAM_config, BAM_data, app);
    app.LfpClearFlag = zeros([1,BAM_config.MaxElectrode]);
    app.SpikeClearFlag = zeros([BAM_config.MaxElectrode, BAM_config.MaxUnit+1]);
end
    
    %% set data location
    temp = strrep(datestr(datetime), ' ', '_');
    BAM_config.today = [temp(1:11)];

    app.fid = fopen(['Data/', BAM_config.today, '.txt'], 'w');
end