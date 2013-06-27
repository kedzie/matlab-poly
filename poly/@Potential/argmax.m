function [out] = argmax( a, argname )
%MESSAGE/ARGMAX argmax of structure array
%  Detailed explanation goes here

[nrows ncols] = size(a);

row = a;

maxv = max( [row.(argname)] );
out = row(find([row.(argname)]==maxv,1));