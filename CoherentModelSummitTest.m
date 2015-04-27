% Test the coherent model on summit
% Compare the Tb results with MEMLS

clear

%% 1 Get data
%1.1 Temperature data: from Ken's "resampled GISP temps, 1 meter" on the site
%    The data's unit is C and in bottom first order
Temps.Data=load('SummitData/GISP1m.txt');
Temps.z=Temps.Data(:,1);
Temps.T=Temps.Data(:,2);

%1.2 Density data: using the Twickler and Morris data 
load('DecayDensityModel/DensityModel.mat');

%1.3 Get grid 
%    for 0-100m, layer thickness is 1cm
%    for 100-1000m, layer thickness is 0.5m
%    for the rest,layer thickness is 1m

Grid=CoherentGrid(Temps.z(end));

%1.4 Get Sensor data
cd SensorData
UWBRADAntennaConstant
cd ../
 
%1.5 % Interpolate temperature to grid and convert to K
T=interp1(Temps.z,Temps.T,Grid.Z)+273.16;

%% 2 Put together inputs

%2.1 theta, frequency, depth and temperature
theta=[0 40 50];
Input_param.frequency=fGhz;
Input_param.theta=theta;
Input_param.depth = Grid.Z;
Input_param.Temp_profile =T;

%2.2 get density realization
S=load('DecayDensityModel/RandState.mat');
Num_real = 20; % Number of realizations

density=GetRealizations_v2(RhoMod,Grid,Num_real,S);

cd Coherent_model
tic
for n=1:Num_real
    Input_param.density_profile = density(n,:);
    if mod(n,5)==0,
        disp(['Running realization #' num2str(n) '/' num2str(Num_real)])
    end
    [Tb_V(n,:,:),Tb_H(n,:,:),Tb(n,:,:)] = coherent_model(Input_param);
end
    
    %Tb_V_m, Tb_H_m, Tb_m are matrix N*F where N is the number of incidence angles
    %and F the number of frequencies
    %The Tb is finally stored in a N*F*M matrix, with each page for a
    %point, each column for a frequency and each row for a incidence angle
    Tb_V_m(:,:,i) =squeeze(mean(Tb_V,1));
    Tb_H_m(:,:,i) =squeeze(mean(Tb_H,1));
    Tb_m(:,:,i) =squeeze(mean(Tb,1));      
toc   

