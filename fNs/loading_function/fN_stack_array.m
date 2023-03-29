function data_array = fN_stack_array(data_array, inputs)
if(iscell(data_array))
    % is a cell, which means this is a seg spk
    spk_id = inputs{2};
    spk_time = inputs{1};
    for ii = 1:length(data_array)
        spk_idx = find(spk_id==ii-1);
        if(~isempty(spk_idx))
            loc1 = data_array{ii}.location;
            loc2 = loc1+length(spk_idx);
            data_array{ii}.location = loc2;
            data_array{ii}.val(loc1:loc2-1)=spk_time(spk_idx);
        end
    end
else
    % is a matrix
    if(size(data_array.val,1)==1)
        % which means we stack input to a array
        loc1 = data_array.location;
        data_array.location = data_array.location + length(inputs);
        data_array.val(loc1:data_array.location-1) = inputs;
    else
        % which means we stack input to a matrix
        data_array.val(data_array.location, 1:length(inputs))=inputs;
        data_array.location = data_array.location + 1;
    end
end
end