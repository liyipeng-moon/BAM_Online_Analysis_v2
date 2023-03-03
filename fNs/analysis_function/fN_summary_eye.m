function combined_data = fN_summary_eye(combined_data, app)

%% some parameters to fix...
grid_size = 100;
r_bias = app.CXSpinner.Value*10;
c_bias = app.CYSpinner.Value*10;

[eye_ygrid,eye_xgrid] = meshgrid(1:grid_size,1:grid_size);
cy = grid_size/2 + r_bias;
cx= grid_size/2 + c_bias;

heat_now = zeros(grid_size,grid_size);

EYEx = combined_data.EYE1(find((~isnan(combined_data.EYE1))))+5;
EYEx = round(10*EYEx);
EYEy = combined_data.EYE2(find((~isnan(combined_data.EYE2))))+5;
EYEy = round(10*EYEy);

for ii = 1:min(length(EYEx), length(EYEy))
    heat_now(EYEx(ii), EYEy(ii)) = heat_now(EYEx(ii), EYEy(ii))+1;
end
heat_now = heat_now./max(heat_now(:));
thres = app.WinSizeSpinner.Value;
window_idx = ((abs(eye_xgrid-cx)==thres & abs(eye_ygrid-cy)<thres) | (abs(eye_ygrid-cy)==thres & abs(eye_xgrid-cx)<thres));
heat_now(window_idx)=1;
heat_now(cx,cy)=1.3;
heat_now = log(heat_now);

p=imagesc(app.EyeSummary, heat_now);

%%

tr_eye1 = round((combined_data.EYE1+5)*10);
tr_eye2 = round((combined_data.EYE2+5)*10);


with_in_window_idx = abs(tr_eye2-cy)<=thres & abs(tr_eye1-cx)<=thres;
combined_data.valid_time_series = zeros(size(tr_eye2));
combined_data.valid_time_series(with_in_window_idx)=1;


