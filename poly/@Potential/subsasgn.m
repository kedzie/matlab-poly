function A = subsasgn(A,S,val)
% SUBSREF 
switch S(1).type
case '{}'
case '()'
    A(S(1).subs{:}) = val;
case '.'
    A.(S(1).subs)=val;
end
end