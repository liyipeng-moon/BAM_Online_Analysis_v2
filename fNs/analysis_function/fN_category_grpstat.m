function [BAM_config, BAM_data, app] = fN_category_grpstat(BAM_config, BAM_data, app)


img_idx=mod(BAM_data.big_ev_train.val(BAM_data.valid_onset), 10000);
% if(~isempty(img_idx))
%     keyboard
% end
grp_idx=[];

if(isfield(BAM_data,'Dataset'))
    BAM_data.img_info = load([BAM_config.img_vault,'/',BAM_data.Dataset,'.mat']);
    for cc = 1:length(BAM_data.img_info.category.name)
        match_idx = (BAM_data.img_info.category.idx(img_idx)==cc);
        grp_idx(cc) = sum(match_idx);
    end
    bar_plot = bar(app.CategoryGrp,grp_idx);
    app.CategoryGrp.XTickLabel=BAM_data.img_info.category.name;
end
end