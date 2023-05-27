function data_array = fN_stack_ai_array(data_array, inputs,LFP_time,downsample)

inputs = resample(inputs, downsample, 1000);
loc1=LFP_time;
loc2=LFP_time+length(inputs);
data_array.val(loc1:loc2-1)=inputs;
data_array.location = loc2;
end