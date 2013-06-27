function aNew = Kalman_Predict(a,A,Q, p,rt)

aNew = a;

for k = (1:length(a))
    old = a(k);
    new = a(k);

    new.mu = A * old.mu;
    new.Sigma = A * old.Sigma * A'+Q;

    new.mu_pred = new.mu; %Save these for the backward pass
    new.Sigma_pred = new.Sigma;

    new.p = old.p * p;
    %new.Prior = new.p * normal_coef(new.Sigma);
    new.Path = horzcat(old.Path,rt);
    aNew(k) = new;
end