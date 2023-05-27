function output_profile = fN_update_spk_waveform(spk_waveform, spk_number, input_profile,cc)

    output_profile.waveform=zeros([5,96]);
    for ii = 1:5
        output_profile.spk_num(ii,:) = (spk_number(ii)+input_profile.spk_num(ii));
        if(output_profile.spk_num(ii,:))
            output_profile.waveform(ii,:) = (spk_waveform(ii,:)*spk_number(ii) + input_profile.waveform(ii,:).*input_profile.spk_num(ii))./output_profile.spk_num(ii,:);
        end
    end

%    for debug
%     subplot(2,2,cc)
%     plot(output_profile.waveform')
%     drawnow
        
end