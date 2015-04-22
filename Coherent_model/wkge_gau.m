function y = wkge_gau(kx,h,L)
% spectrum density of Gaussian correlation function
y = h^2*L*exp(-(kx*L*0.5).^2)/(2*sqrt(pi));
end