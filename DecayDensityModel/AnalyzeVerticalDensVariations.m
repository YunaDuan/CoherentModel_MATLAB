%script to estimate density vertical spatial autocorrelation at Summit

clear all

rho=xlsread('~/Documents/MyMath/Project/UWBRAD/Summit & Camp Century/MorrisDensity.xlsx','D2:D1265').*1000;
z=xlsread('~/Documents/MyMath/Project/UWBRAD/Summit & Camp Century/MorrisDensity.xlsx','C2:C1265');

TrendModel =  @(p,xx) ( (p(1)-910) .* exp(-(xx/p(2)))  + 910 );
p0=[185 10];
TrendParams = nlinfit(-z, rho, TrendModel, p0);

rhoFit=TrendModel(TrendParams,-z);

figure(1)
plot(rho,z,rhoFit,z)

RhoAnom=rho-rhoFit;
StdAnom=std(RhoAnom);

figure(2)
plot(RhoAnom,z)

for i=1:length(z),
    for j=1:i,
        DZ(i,j)=abs(i-j);
        DZ(j,i)=DZ(i,j);
    end
end
DZ=DZ.*.01;

h=[0 .01 .02 .05:.05:1 1.1:.1:2.5 3 4 5 6 10];
htol=.005;

[gamma] = variogram(RhoAnom,h,DZ,htol);
C=1-gamma./gamma(end);

figure(3)
plot(h,C,'o-')

AnomModel =  @(p,xx) ( exp(-(xx/p(1)))   );
p0=1;
AnomParams = nlinfit(h, C, AnomModel, p0);


save('DensityAnomModel','AnomModel','AnomParams','StdAnom');