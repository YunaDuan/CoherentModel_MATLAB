function density = density_profile(z,Delta,lc,alpha_d)


% Generation of the noisy part from Shurun's work before discretization :
% I use this method because it is faster than the mvnrnd function:
Rho_n=zeros(1,length(z));

% N is the number of point in the first upper layers.
range = 100; % We consider the first 100 meters
N= range/(z(2)-z(1)); % N should be a even number... 
rho_n = density_fluctuation_j(N,Delta,lc,range); % Delta is in g.cm*-3
Rho_n(z<100) = rho_n;

% Average Trend
rho_m = 0.922 - 0.564*exp(-0.0165.*z);

% Density Profile
density = (rho_m + Rho_n.*exp(-z./alpha_d))*1e3; % Density is in kg.m-3

