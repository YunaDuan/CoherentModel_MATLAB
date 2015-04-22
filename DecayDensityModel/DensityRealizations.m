%examine input data

clear all

%1) Load data
RhoTrendMod=load('DensityTrendModel.mat');
RhoAnomMod=load('~/Documents/MyMath/Project/UWBRAD/density_fit/NewDensityModel/DensityAnomModel.mat');

RhoMod=RhoAnomMod;
RhoMod.TrendModel=RhoTrendMod.TrendModel;
RhoMod.TrendParams=RhoTrendMod.TrendParams;

save('DensityModel.mat','RhoMod')

%2) Get vertical grid
[Grid] = GetGrid(false);

%3) Produce one reaslization
N=1;
S=load('RandState.mat');
[RhoR,RhoBar] = GetRealizations_v2(RhoMod,Grid,N,S);

figure(1)
plot(RhoBar,-Grid.Z,RhoR,-Grid.Z)
