function [BAM_config, BAM_data, app] = fN_category_grpstat(BAM_config, BAM_data, app)



% if(~isempty(img_idx))
%     keyboard
% end
grp_idx=[];
if(~strcmp(BAM_data.Dataset, 'NULL'))
    for cc = 1:length(BAM_data.img_info.category.name)
        match_idx = (BAM_data.img_info.category.idx(BAM_data.img_idx)==cc);
        grp_idx(cc) = sum(match_idx);
    end
    bar_plot = bar(app.CategoryGrp,grp_idx);
    app.CategoryGrp.XTickLabel=BAM_data.img_info.category.name;
    BAM_data.do_analysis = 1;
else
    BAM_data.do_analysis = 0;
end
end