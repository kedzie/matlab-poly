function [ y ] = down_sample( wav, D)
%DOWN_SAMPLE(wav,D) Downsample the array by factor D

len = uint32(length(wav)/D);
y = zeros(1,len);

for k=(1:len)
    y(k)=wav(D*k);
end