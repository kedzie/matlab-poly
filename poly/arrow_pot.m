function arrow_pot( source, dest, t_prev, t, ax )
% arrow_pot( source, dest )

ld = length(dest);
ls = length(source);

P_s = zeros(2,2,ls);
x_s = zeros(2,ls);
P_d = zeros(2,2,ld);
x_d = zeros(2,ld);

for i=(1:ls)
    P_s(:,:,i) = source(i).Sigma;
    x_s(:,i) = [t_prev 0];
    path_s = source(i).Path;
    
    state_s = [path_s(1,end) 0];
    if t==1
        state_s(2) = 2;
    else
        state_s(2) = path_s(1,length(path_s)-1);
    end

    if state_s==[1 1]
        x_s(2,i) = .3;
    elseif state_s==[1 2]
        x_s(2,i) = .1;
    elseif state_s==[2 1]
        x_s(2,i) = -.1;
    elseif state_s==[2 2]
        x_s(2,i) = -.3;
    end
    
    for k=(1:ld)
        P_d(:,:,k) = dest(k).Sigma;
        x_d(:,k) = [t 0];
        path_d = dest(k).Path;
        
        dstate = [path_d(1,end) 0];
        if t==1
            dstate(2) = 2;
        else
            dstate(2) = path_d(1,length(path_d)-1);
        end

        if dstate==[1 1]
            x_d(2,k) = .3;
        elseif dstate==[1 2]
            x_d(2,k) = .1;
        elseif dstate==[2 1]
            x_d(2,k) = -.1;
        elseif dstate==[2 2]
            x_d(2,k) = -.3;
        end
      
        if nargin>4
        axes(ax)';
        end
        draw_ellipse(x_d(:,k),P_d(:,:,k),'black','green');
        draw_ellipse_axes(x_d(:,k),P_d(:,:,k));
        arrow(x_s(:,i), x_d(:,k) );
        
        MAP = argmin([dest(:)],'LL');
        
        text(x_d(1,k)+0.025,x_d(2,k)-.1, ...
            ['L = ' num2str(MAP.Likelihood)]   );
    end
end