function Tpz = temp_profile(Ts,H,M,z,G,Kc,Kd) 
% Calculation of the physical temperature profile

L = sqrt(2.*Kd.*H./M);
C = L.*G.*sqrt(pi)/(2.*Kc);

Tpz = Ts + C.*erf(H./L) - C.*erf((z+H)./L);

return
