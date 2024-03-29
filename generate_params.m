% remote_dir = '\\desktop-ijjnup2\users\user\Desktop\Preload\img_vault';
% copyfile('\\desktop-ijjnup2\users\user\Desktop\Preload\img_vault','C:\Users\Lenovo\Desktop\img_vault\','f');
clear

% Location
%BAM_config.remote_img_vault = 'Z:\Monkey\Stimuli\LYP\Img_vault'; % nas
%BAM_config.img_vault = 'Data\img_vault';
BAM_config.AO_dir = 'C:\Program Files (x86)\AlphaOmega\AlphaLab SNR System SDK\MATLAB_SDK';

%
BAM_data=[];

%% Electrode Setting
% by default, we got 2 channel at most, each chennel would have 1-4 sorted unit.
BAM_config.MaxElectrode = 16;
BAM_config.MaxUnit = 4;
for cc = 1:BAM_config.MaxElectrode
    for uu = 1:BAM_config.MaxUnit
        if(cc==1 || cc==2 || cc==3)
            BAM_config.Electrode(cc,uu).Using = true;
            BAM_config.Electrode(cc,uu).UID = 0;
        else
            BAM_config.Electrode(cc,uu).Using = false;
            BAM_config.Electrode(cc,uu).UID = 0;
        end

    end
    BAM_config.ElectrodeUsing(cc)=1;
end
BAM_config.num_unit_used = 0;


%% SR
% check whether this matchs AO logging file
BAM_config.SR.DIO=44000;
BAM_config.SR.SEG=44000;
BAM_config.SR.LFP=1375;
BAM_config.SR.AI=2750;

%% AO IP Address
room_number = 302;
if(room_number == 302)
    BAM_config.IP.DSPMAC = 'A8:1B:6A:21:24:4B'; % Behind AO SnR
    BAM_config.IP.PCMAC = '00:E0:4C:03:94:90';% IP of online analysis PC
    % BAM_config.ML_IP = '10.129.168.39';
else
    BAM_config.IP.DSPMAC = 'A8:1B:6A:14:74:2D'; % Behind AO SnR
    BAM_config.IP.PCMAC = 'bc:6a:29:e1:49:bf';% IP of online analysis PC
end

BAM_config.IP.Connected = 0;
BAM_config.IP.DeviceFreeMode=0; % Run this when you have no AO connected
BAM_config.IP.Buffered=0;

%%  about saving
BAM_config.is_saving=0;
BAM_config.save_interval = 3;
BAM_config.read_interval = 0.3;

% add channel
BAM_config.channelidarr = [11202];
BAM_config.channel_name = {'eventcode'};
for ii = 1:16
    lfparr = 9999+ii;
    spkarr = 10127+ii;
    lfp_field = ['lfp', num2str(ii)];
    spk_field = ['seg', num2str(ii)];
    BAM_config.channelidarr = [BAM_config.channelidarr, lfparr, spkarr];
    BAM_config.channel_name{end+1} = lfp_field;
    BAM_config.channel_name{end+1} = spk_field;
end
%% about online analysis
BAM_config.session_buffer = 5000; % in ms
BAM_config.combine_interval = 0.05;
BAM_config.session_max_length = 2 * 60 * 60; % in seconds
BAM_config.ai_downsample = 1000; % in seconds
BAM_config.PSTH_NumBin = 20;
BAM_config.PSTH_start = -200;
BAM_config.PSTH_end = 1500;
BAM_config.PSTH_width = (BAM_config.PSTH_end-BAM_config.PSTH_start)./BAM_config.PSTH_NumBin; % in ms
BAM_config.LFP_start = -150;
BAM_config.LFP_end = 300;
BAM_config.eui_num=1;
BAM_config.LFP_plot_down_sample_rate=10;
%% color parameters
BAM_config.colormap.red = [1,0,0];
BAM_config.colormap.green = [0,1,0];
BAM_config.colormap.blue = [0,0,1];
BAM_config.colormap.white = [1,1,1];
BAM_config.colormap.black = [0,0,0];
BAM_config.colormap.grey = [0.3,0.3,0.3];
BAM_config.colormap.unit = {[0.5,0.5,0.5],[0 1 0],[1 1 0],[0 1 1],[1 0 0]};


BAM_config.ML_folder = '\\ml-pc\bam_communicate';

BAM_config.bit_resolution = (2500000/(2^16))./20;

save('default_params.mat',"BAM_config","BAM_data");
