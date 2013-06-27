function aNew = Kalman_Correct(a_prev, a, A, C, y )
%aNew = Kalman_Correct(a_prev, a, A, C, y )
global R H M

% a = p( y(1:t-1), s(t), r(1:t) )

aNew=a;
I = eye(length(C));

for k = (1:length(a))
    old = a(k);
    new = a(k);

    new.V = C * old.Sigma * C' + R;
    new.K = old.Sigma * C' * inv(new.V);

    y_pred = C * old.mu;
    e = y - y_pred;
    new.mu = old.mu + new.K * e;
    new.Sigma = old.Sigma-new.K*new.V*new.K';
    if isa(a_prev,'Potential')
        new.Sigma_2s = (I - new.K*C) * A * a_prev.Sigma;
    end

    new.Likelihood = gaussian_prob(y,y_pred,new.V,1); %p(y(1:t)|s(1:t)
    new.Posterior = old.Posterior + new.p * new.Likelihood;  % p( r(1:t) | y(1:t) )
    %new.Likelihood = old.Likelihood + new.Likelihood;

    %We keep a backup of intermediate values for smoothing
    new.mu_corr = new.mu;
    new.Sigma_corr = new.Sigma;
    new.Sigma_2s_corr = new.Sigma_2s;

    aNew(k) = new;
end
