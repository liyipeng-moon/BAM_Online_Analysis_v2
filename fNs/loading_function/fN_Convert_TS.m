function TS=fN_Convert_TS (Matrix_X_by_2)
% from AO engineer
if size(Matrix_X_by_2,1)==1
    TS=bin2dec([dec2bin(mod(double(Matrix_X_by_2(1,2)),2^16),16),dec2bin(mod(double(Matrix_X_by_2(1,1)),2^16),16)]);
else
    for i=1:size(Matrix_X_by_2,1)
        TS(i,1)=bin2dec([dec2bin(mod(double(Matrix_X_by_2(i,2)),2^16),16),dec2bin(mod(double(Matrix_X_by_2(i,1)),2^16),16)]);
    end
end