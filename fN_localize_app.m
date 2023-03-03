function [root_dir] = fN_localize_app()
% 
root_dir = which('fN_localize_app');

xx = find(root_dir=='\');
xx = xx(end);
root_dir = root_dir(1:xx);

%root_dir = 'C:\Users\Lenovo\Desktop\BAM_online_analysis';
cd(root_dir)
