function rho_n=shurun_noisy_part(y,N,rL,Delta,lc)


WKGE    = @(kx) wkge_gau(kx,Delta,lc);
bh = zeros(1,N/2 - 1);
for n=1:(N/2-1);
    bh(n) = (y(2*n-1)+1i*y(2*n))/sqrt(2);
end
bhc = conj(bh);
bhf = fliplr(bhc);
bi  = [bh y(N-1) bhf y(N)];
kx  = 2.*pi*(-N/2+1:1:N/2)/rL;
y1  = sqrt(WKGE(kx));
y   = y1*sqrt(2*pi*rL);
b   = y.*bi;
xs  = [b(N/2+1:1:N) b(1:1:N/2)];
xt  = [xs(N),xs(1:1:N-1)];
ft  = ifft(xt,N);
ft  = ft*N/rL;
fs  = [ft(2:1:N),ft(1)];
f   = [fs(N/2+1:1:N) fs(1:1:N/2)];
rho_n = real(f);
dx  = rL/N;
% x   = (-N/2+1:1:N/2)*dx;
x   = (-N/2:1:N/2-1)*dx;
n   = 2:N-1;
df1 = (f(n+1)-f(n-1))/(2*dx);
df  = [(f(2)-f(N))/(2*dx),df1,(f(1)-f(N-1))/(2*dx)];