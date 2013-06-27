function [y yj] = gen_chord_samples( r, T, note_mode)
%[y yj] = gen_chord_samples( r, T)

global M R

y(1:T) = 0;
yj(1:M,1:T) = 0;

if note_mode
    config = 2.*ones(1,M);
    for k=(1:length(r))
        config(r(k))=1;
    end
else
    config = r;
end


for j=(1:M)
    if config(j) == 1
        yj(j,:) = gen_chord_section( j, T);
    else
        yj(j,:) = zeros(1,T);
    end
end

y = sum(yj);
%for t=(1:T)
%   y(t) = sum(yj(:,t)) + gaussian_sample(0,R,1);
%end