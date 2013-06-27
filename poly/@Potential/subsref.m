function [out] = subsref(A,S)
% SUBSREF 
switch S(1).type
case '()'
    [out] = [A(S(1).subs{:})];
    
    if length(S)>1
        switch S(2).type
            case '.'
                [out] = [out.(S(2).subs)];
        end
    end

case '.'
    [out] = [A(:).(S(1).subs)];
end
end