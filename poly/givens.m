function out = Givens(w)
% GIVENS(angular_velocity) 
% Rotation Matrix

out=[cos(w) -sin(w);sin(w) cos(w);];