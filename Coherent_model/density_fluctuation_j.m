function d = density_fluctuation_j(N,del,col,rL)

WKGE    = @(kx) wkge_gau(kx,del,col);
kx  = 2.*pi/rL*(0:N/2-1);
kx(N:-1:N/2+2)=-kx(2:N/2);
y  = sqrt(WKGE(kx))*sqrt(2*pi*rL);
xt(1)=0;
xt(2:N/2)=y(2:N/2).*(randn(1,N/2-1)+1i*randn(1,N/2-1))/sqrt(2);
xt(N/2+1)=0;
xt(N:-1:N/2+2)=conj(xt(2:N/2));
ft  = ifft(xt)*N/rL;
d = real(ft);
dx  = rL/N;
x   = (-N/2:1:N/2-1)*dx;
