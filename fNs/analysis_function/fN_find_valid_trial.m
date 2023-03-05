function[BAM_config, BAM_data, app] = fN_find_valid_trial(BAM_config, BAM_data, app)

%find onset
img_ev_idx = find(BAM_data.big_ev_train.val>10000); % this is the location in event train
stimuli_idx = BAM_data.big_ev_train.val(img_ev_idx); % this is the ev value
onset_idx = []; offset_idx = [];
for ii = 1:length(stimuli_idx)-2
    if(stimuli_idx(ii+1)-stimuli_idx(ii)==10000) % diff ev value = 10000
        onset_idx  = [onset_idx, img_ev_idx(ii)];
        offset_idx = [offset_idx, img_ev_idx(ii+1)]; % the idx is the location in event train
    elseif(stimuli_idx(ii+2)-stimuli_idx(ii)==10000) % 不优雅，就是"最近两个是ev"
        onset_idx  = [onset_idx, img_ev_idx(ii)];
        offset_idx = [offset_idx, img_ev_idx(ii+2)]; 
    end
end
onset_time = BAM_data.big_ev_time.val(onset_idx);
offset_time = BAM_data.big_ev_time.val(offset_idx);

valid_img = ones(size(onset_time));
time_thres = app.TimeSpinner.Value/100;
pause(0.02) % necessary for edited value

% repair...
for img = 1:length(onset_idx)
    eye_within_onset = BAM_data.eye_in(onset_time(img):offset_time(img));
    valid_img(img) = sum(eye_within_onset)/length(eye_within_onset)>time_thres;
end

show_valid_txt = ['Valid Trial: ', num2str(sum(valid_img)), '/' num2str(length(valid_img))];
app.ValidTrialLabel.Text = show_valid_txt;
% app.ValidTrialGauge.Value = ;
% app.ValidTrialGauge.Limits = [1,length(valid_img)];
% app.ValidTrialGauge.MajorTicks = [1, floor([0.25,0.5,0.75,1]*length(valid_img))];

BAM_data.valid_onset = onset_idx(find(valid_img));

end