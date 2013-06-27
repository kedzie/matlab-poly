function EM( data, j, max_iterations )
% [An, Cn, Qn, Rn, LL, rhon] = EM( data, fixed_j, max_iterations )
% Must update rho's for each j seperately
global A C S Q R M H

H2 = H+H;

s = (j-1)*H2+1;  
e = s+H2-1;

Sn = S(s:e,s:e);
Qn = Q(s:e,s:e);
Csmall = C(1:H2);
F = A{1,j};

% Initial state estimates
x0=zeros(H2,1);

[F, Cn, Qn, R, initx, Sn, LL] = ...
    learn_kalman(data, F, Csmall, Qn, R, x0, Sn, max_iterations, true, true);
% Extract new damping coefficient
rho(1) = det(F*F')^.25;
Sn = Sn.*eye(2*H);
Qn = Qn.*eye(2*H);

%update our parameters
Q(s:e,s:e)=Qn;
S(s:e,s:e)=Sn;
A{1,j} = F;
