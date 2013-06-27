function aNew = Kalman_Smooth(a, a_next, A)
% Kalman_Smooth(a, a_next, A, y)
% a = alpha{t};  a_next = alpha{t+1}, A= A{r(t+1),j(t+1),
% Adapted from "Switching Kalman Filters", Kevin Murphy, 1998

global R H

aNew=a;

%Efficiency-saver pre-computations
At = A';

for k = (1:length(a))
    old = a(k);
    new = a(k);

    % We have the predicted quantities from forward pass.
    % So first compute 'Smoother gain matrix' J
    new.J = a.Sigma * At * int(a_next.Sigma_pred);

    % Update our estimates of mean, variance, and cross variance
    new.mu = old.mu + new.J*(a_next.mu - a_next.mu_pred);
    new.Sigma = old.Sigma-new.J*(a_next.Sigma - a_next.Sigma_pred)*new.J';
    new.Sigma_2s = a_next.Sigma_2s_corr + (a_next.Sigma - a_next.Sigma_corr) ...
        * inv(a_next.Sigma_corr) * a_next.Sigma_2s_corr;

    aNew(k) = new;
end
