function [ out ] = filter_chord( notes, y,T, note_mode)
%[ out ] = filter_chord( notes, y, T, note_mode)

global M H Q S A C R


if nargin<4
    note_mode = false;
    if nargin<3
        T = length(y);
    end
end

if note_mode
    config = 2.*ones(1,M);
    for k=(1:length(notes))
        config(notes(k))=1;
    end
else
    config = notes;
end

delta = cell(T);
% Forward Filtering
t = 1;
delta{t}=Potential;
delta{t}.p = 1;
delta{t}.Path = config;
delta{t}.mu = zeros(2*H*M,1);

t_P = cell(1,M);
t_A = cell(1,M);
for k=(1:M)
    if config(k)==1
        t_P{k} = S(1:2*H,1:2*H);
        t_A{k} = A{1,k};
    else
        t_P{k} = Q(1:2*H,1:2*H);
        t_A{k} = A{2,k};
    end
end
F = blkdiag(t_A{:});
delta{t}.Sigma = blkdiag(t_P{:});
delta{t} = Kalman_Correct( 0,delta{t},F,C, y(t));

%Forward-Pass
for t = (2:T)
    delta{t} = Kalman_Predict(delta{t-1},F,Q,1,[]);
    delta{t} = Kalman_Correct( delta{t-1},delta{t},F,C,y(t));    
%     delta{t}.Likelihood = delta{t}.Likelihood ...
%             + delta{t-1}.Likelihood;
end

out = delta{T};