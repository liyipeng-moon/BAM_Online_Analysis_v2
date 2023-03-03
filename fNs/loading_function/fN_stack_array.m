function data_array = fN_stack_array(data_array, inputs)

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