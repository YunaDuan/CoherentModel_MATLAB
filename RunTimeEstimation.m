% Estimation the Run time needed to generate Tb database for MCMC Estimation
% from Coherent model.
% Estimation of run time based on the 1000 realiations of summit modeling.
% The model accuracy is set to be 0.1 K.

clear

% Get summit running realizations
load('Runs/CMTb4.mat')

% Average each realziation on antenna pattern file
cd ./SensorData
UWBRADAntennaConstant
cd ../

theta=[0,40,50];
for f=1:length(fGhz)
    [~,fclose]=min(fGhz(f)-UWBRADSensor.Freq);    
    for q=1:length(theta),
        j=find(UWBRADSensor.Theta==theta(q));
        GdB(q,f)=UWBRADSensor.GaindB(j,fclose);
    end    
end
Glin=10.^(GdB./10);

for i=1:1000
    Tbh(i,:)=sum(squeeze(Tb_H(i,:,:)).*Glin)./sum(Glin);
    Tbv(i,:)=sum(squeeze(Tb_V(i,:,:)).*Glin)./sum(Glin);
end
Tbc=(Tbv+Tbh)./2;

% get the standard deviation of Tb
stdh=std(Tbh);
stdv=std(Tbv);
stdc=std(Tbc);

% get the std of the mean Tb
stdhm=stdh./sqrt(1000);
stdvm=stdv./sqrt(1000);
stdcm=stdc./sqrt(1000);

figure,
plot(fGhz,stdhm,fGhz,stdvm,fGhz,stdcm,'linewidth',2);
set(gca,'fontsize',14)
xlabel('frequency Ghz');ylabel('std of Tb K')
legend('H','V','C')
title('Accuacy of 1000 realizations')

% suppose the std of the mean is 0.1 K
% std_m=std/sqrt(n);
nh=(stdh./0.1).^2;
nv=(stdv./0.1).^2;
nc=(stdc./0.1).^2;

figure,
plot(fGhz,nh,fGhz,nv,fGhz,nc,'linewidth',2);
set(gca,'fontsize',14)
xlabel('frequency Ghz');ylabel('realizations')
legend('H','V','C')
title('Realizations Needed for 0.1K accuracy')


