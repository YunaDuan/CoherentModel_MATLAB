%script to estimate density vertical spatial autocorrelation at Summit

%clear all
cd ..
BaseDir='SummitData/DensityData';

fid=fopen([BaseDir 'Twickler1Density.txt'],'r');
fgetl(fid); %header line
i=0;
while ~feof(fid),
    i=i+1;
    Twickler1.z(i)=fscanf(fid,'%f',1);
    Twickler1.rho(i)=fscanf(fid,'%f',1);
    fscanf(fid,'%f',2);
end
fclose(fid);

fid=fopen([BaseDir 'Twickler2Density.txt'],'r');
fgetl(fid); %header line
i=0;
while ~feof(fid),
    i=i+1;
    Twickler2.z(i)=fscanf(fid,'%f',1);
    Twickler2.rho(i)=fscanf(fid,'%f',1).*1000;
end
fclose(fid);

%fit model
TrendModel =  @(p,xx) ( (p(1)-917) .* exp(-(xx/p(2)))  + 917 );
p0=[185 10];
TrendParams = nlinfit(Twickler1.z, Twickler1.rho, TrendModel, p0);

z=1:3000;

rhoFit=TrendModel(TrendParams,z);

figure(1)
plot(Twickler1.rho,-Twickler1.z,'b-',Twickler2.rho,-Twickler2.z,'b-',rhoFit,-z,'r-')

save('DensityTrendModel','TrendModel','TrendParams')