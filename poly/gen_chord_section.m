function [y sv]=gen_chord_section(j, T )
%  [y sv]=gen_chord_section(j, T )
% Generate samples for one part of a chord
% Does not add observation noise.
global M H A S Q R C

y(1:T)=0;

ix = (j-1)*2*H+1;
s = zeros(2*H*M,1);
t = 1;
% Create transition function
t_A = cell(1,M);
for k=(1:M)
    if k==j
        t_A{k} = A{1,k};
    else
        t_A{k} = A{2,k};
    end
end
F = blkdiag(t_A{:});

%s(ix:ix+2*H-1)=[gaussian_sample(zeros(2*H,1),S(1:2*H,1:2*H),1)]';
s(ix:ix+2*H-1)=C(ix:ix+2*H-1);
y(1)=C*s;

sv = zeros(2*H,T);
sv(1:2*H,1) = s(ix:ix+2*H-1);
for t = (2:T)
    s = F*s + gaussian_sample(zeros(2*H*M,1),Q,1)';
    y(t) = C*s;
    sv(1:2*H,t)=s(ix:ix+2*H-1);
end
