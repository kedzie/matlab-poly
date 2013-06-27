function  display( p )
%DISPLAY Displays potential in command window

disp('---------');
for k=(1:length(p))
%disp(['mu =             ' num2str(p(k).mu')]);
%disp(['Sigma =          ' num2str(diag(p(k).Sigma)')]);
%disp(['2-slice Sigma =  ',num2str(diag(p(k).Sigma_2s)')]);
disp(['p =              ',num2str(p(k).p)]);
disp(['Posterior =      ',num2str(p(k).Posterior)]);
disp(['Likelihood =      ',num2str(p(k).Likelihood)]);
disp('');
disp('Path');
disp('');
disp(num2str(p(k).Path));
disp('---------');
end