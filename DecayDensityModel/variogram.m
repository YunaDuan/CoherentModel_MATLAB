function [gamma] = variogram(data,h,dist,h_tol)
%[gamma] = variogram()
%inputs:
%  data: the data we want to compute a variogram for
%  h: vector of lengths at which to compute variogram
%  dist: matrix of distances between all points

% h=[0 1 3 5 10 20 30];
% load dist.in

%initialize
pixels=[]; 
pairs=0; 
% h_tol=0.5;
clear x y

for j=1:length(h),    
    for r=1:size(dist,1), %rows of dist
        c=find(  abs(dist(r,1:r)-h(j))<h_tol    );
        for i=1:length(c),
            if r==1 & i==1,
                pixels=[r c(i)];
                pairs=pairs+1;
            else
                pixels(pairs+1,1:2,1)=[r c(i)];
                pairs=pairs+1;
            end
        end
    end
    for i=1:length(pixels),
        x(i)=data(pixels(i,1));
        y(i)=data(pixels(i,2));
    end
    gamma(j)=1./2./length(x)*sum((x-y).^2);
end

return