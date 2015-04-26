% UWBRAD MCMC temperature Estiamtion using coherent model

%% 1.Coherent_model From Alexandra
% 1) coherent_model.m: 
%    function for claculating Tb using coherent model
%    input: depth,density profile, temperature profile,frequency,theta

% 2) density_profile.m: 
%    ESL's method of generating density profile
%    rho(z)=rho_m+rho_n(z)*exp(-z/alpha)--not using

% 3) shurun_noisy_part.m: 
%    Add noise to the density profile based on Shurun's paper --not using
 
% 4) wkge_gau.m:
%    spectrum density of Gaussian correlation function-- not using

% 5) run_Coherent_Model.m: 
%    The main script to integrate all the inputs and run the coherent model.

% 6) temp_profile.m: 
%    get temperature profile from Robin Model  

%% 2.DecayDensityModel
% 1)FitDensityModel.m
%   Get smooth density profile fitting from summit twickler data. 
%   rho(z)=(rho_m-rho_i) * exp(-z/alpha)  + rho_i )

% 2)GetRealization_v2.m
%   Generate random noise for density fluctuation
%   The std of density variation decays with depth
%   sigma(z)=sigma0*exp(-z/L1)

% 3)DensityRealizatoins.m
%   An examine of the density model by generating one realization

% 4)variogram.m
%   Ploting the variogram of the density profile

% 5)AnalyzeVerticalDensVariations
%   estimate density vertical spatial autocorrelation at Summit

% 6)DenistyData
% -MorrisDensity.xlsx: Liz Morris Neutron probe data for density fluction
% -Twicker1Density.txt: The density data of summit, 0.5m-195m
% -Twicker2Density.txt: The density data of summit, 94m-bottom
%                       the resoultion of first 100m is 1m, the rest is 10m
% -Ice Sheet Density Data.docx: Ken's analysis of summit density

%% ModifiedTempData
% 1)Adjusted Temp Models.pptx
%   Ken's slides explaining the Adjusted Temperature Model for Greenland
%   Parameters(G,M,Ts) are tuned to fit the measured temperature profile

% 2)profileparam.mat
%   Adjusted parameters for Robin Model