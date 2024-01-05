function BAM_data = fN_UD_generating_example(BAM_config,BAM_data,app,pp,uu)

num_of_category=length(BAM_data.img_info.condition_nm);
BAM_data.UD_handle{pp,uu} = barh(BAM_data.plot_ax(pp,2+uu),ones([1,num_of_category]));
BAM_data.UD_handle{pp,uu}.FaceColor = 'flat';

for cc = 1:num_of_category
    BAM_data.UD_handle{pp,uu}.CData(cc,:)=BAM_data.img_info.category_color(cc,:);
end
yticklabels(BAM_data.plot_ax(pp,2+uu), BAM_data.img_info.condition_nm)
set(BAM_data.UD_handle{pp,uu}, 'ButtonDownFcn', @(hobject,eventdata) subplotCallback(hobject,eventdata,'Spike',app,pp,uu))