function [RhoR,RhoBar] = GetRealizations_v2(RhoMod,Grid,N,S)

rng(S.s);

RhoBar=RhoMod.TrendModel(RhoMod.TrendParams,Grid.Z);
C=exp(-Grid.X./RhoMod.AnomParams); %covariance matrix

%use "RhoMod.StdAnom" to determine initial density standard deviation

RhoMod.VarDecayParams(1)=RhoMod.StdAnom;

RhoStd=RhoMod.VarDecayModel(RhoMod.VarDecayParams,Grid.Z)'; %nx1

Sigma=(RhoStd*RhoStd').*C;

RhoRall=mvnrnd(RhoBar,Sigma,N);

i=Grid.Z<=100; 
RhoR=RhoBar;
RhoR(i)=RhoRall(i);

return