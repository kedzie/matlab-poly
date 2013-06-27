function [out] = argmin( a, argname )
%MESSAGE/ARGMAX argmax of structure array
%  Detailed explanation goes here

[nrows ncols] = size(a);

row = a;

minv = min( [row.(argname)] );
out = row(find([row.(argname)]==minv,1));



