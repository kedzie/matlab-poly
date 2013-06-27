function a = Potential
%Potential constructor

a.p = 0;
a.mu = [];  % E [ r | y ]
a.Sigma = [];   
a.Sigma_2s = []; % For learning

%Store for smoothing pass
a.mu_pred = [];
a.Sigma_pred = [];
a.mu_corr = [];
a.Sigma_corr = [];
a.Sigma_2s_corr = [];
a.J = [];
a.K = [];
a.V = [];

a.LL = 1;
a.Likelihood = 1;
a.Path = [[0 0]];  %Tag Path
a.Posterior = 0; % N(y;x,P) = p( r(1:t) | y(1:t) )

a = class(a,'Potential');