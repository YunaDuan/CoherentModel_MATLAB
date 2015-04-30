alpha_d=30; % Damping Coefficient
Delta = 0.04; % Standard Deviation
lc = 0.03;   % Correlation Length, it can be an array

srho = (rho_m + Rho_n.*exp(-z./alpha_d))*1e3;
b=density_profile(Grid.Z,Delta,lc,alpha_d);