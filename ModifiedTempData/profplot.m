clear
close all
%save('profileparam.mat','range', 'heatinterp', 'thick', 'airinterp', 'massinterp', 'srange', 'Tb')
set(0,'DefaultAxesFontsize',20,'DefaultAxesFontName','Calibri','DefaultAxesFontWeight','bold','defaultlinelinewidth',2)
load('profileparam.mat')
figure(20)
hold on
fname='rangeprofile3.csv';
adata=importdata(fname,',',1);

%range=adata.data(:,3);
elev=adata.data(:,4);
%thick=adata.data(:,5);
btopo=adata.data(:,6);
plot(range/1000,elev,'r')
hold on
plot(range/1000,btopo)
hold on
% stations=[220580 470594 829641 1156915 1312173 1631925]
% elevstat=[1850 2500 2950  3230 3240 2400] 
% hold on
% plot(stations/1000,elevstat,'ko')
grid on
title('UWBRAD TRANSECT')
xlabel('Range from Thule (km)')
ylabel('Surface/Basal Topography (m)')
axis([0 2100 -800 3500])
% num=size(range)
% q=1
% for j=1:23:num(1)-24
%     j
%     bslope(q)=(btopo(j+17)-btopo(j))/(range(j+17)-range(j))*180/pi;
%     eslope(q)=(elev(j+17)-elev(j))/(range(j+17)-range(j))*180/pi;
%     rslope(q)=(range(j+17)-range(j))/2+range(j);
%     q=q+1
% end
% figure(30)
% plot(rslope/1000,bslope)
% title('Basal Slope (500 m)')
% xlabel('range (km)')
% ylabel('slope (degrees)')
% axis([0 2100 -25 25])
% figure(31)
% plot(rslope/1000,eslope)
% axis([0 2100 -5 5])
% title('Surface Slope (500 m)')
% xlabel('range (km)')
% ylabel('slope (degrees)')
figure(60)
plot(range/1000,thick)
hold on
% stations=[220580 470594 829641 1156915 1312173 1631925]
% elevstat=[1500 2500 30500  3200 3150 2400] 
% hold on
% plot(stations/1000,elevstat,'ro')
grid on
title('Thickness')
xlabel('Range from Thule (km)')
ylabel('Thickness (m)')
axis([0 2100 0 3400])


% fname='greensmos.csv';
% sdata=importdata(fname,',',1);
% 
% srange=sdata.data(:,1);
% Tb=sdata.data(:,2);
figure(5)
[hAx,hLine1,hLine2] = plotyy(srange/1000,Tb,range/1000,thick)
grid on
title('SMOS Tb and Thickness')
xlabel('Range km')
ylabel(hAx(1),'Tb') % left y-axis
ylabel(hAx(2),'Thickness') % right y-axis
% hLine1.LineStyle = '-';
% hLine2.LineStyle = '-';
set(hLine1,'color','red')
set(hLine2,'color','black')
set(hAx,{'ycolor'},{'r';'k'})
set(hAx, 'Position',[0.14 0.18 0.72 0.72])
figure(6)
fname='sartop.csv';
tsdata=importdata(fname,',',1);

tsrange=tsdata.data(:,1);
tsigma=tsdata.data(:,2);
offset1=size(tsrange);
fname='sarmid.csv';
msdata=importdata(fname,',',1);

msrange=msdata.data(:,1);
msigma=msdata.data(:,2);
msrange=msrange+tsrange(offset1(1));
offset2=size(msrange);

fname='sarbot.csv';
bsdata=importdata(fname,',',1);

bsrange=bsdata.data(:,1);
bsigma=bsdata.data(:,2);
bsrange=bsrange+msrange(offset2(1))
sarrange=[tsrange' msrange' bsrange' ]
sigma=[tsigma' msigma' bsigma']
[hAx,hLine1,hLine2] = plotyy(srange/1000,Tb,sarrange/1000,sigma)
set(hLine1,'color','red')
set(hLine2,'color','black')
set(hAx,{'ycolor'},{'r';'k'})
set(hAx, 'Position',[0.14 0.18 0.72 0.72])
grid on
title('SMOS Tb and SAR Brightness')
xlabel('Range km')
ylabel(hAx(1),'Tb') % left y-axis
ylabel(hAx(2),'SAR Brightness') % 

figure(7)
% fname='heat1000.csv';
% heatdata=importdata(fname,',',1);
% 
% heatrange=heatdata.data(:,1);
heatval=G*1000;%heatinterp;%heat%data.data(:,2);
[hAx,hLine1,hLine2] = plotyy(srange/1000,Tb,range/1000,heatval)
grid on
title('SMOS Tb and Basal Heat')
xlabel('Range km')
ylabel(hAx(1),'Tb') % left y-axis
ylabel(hAx(2),'Heat Flux (mW/m^2)') % 
set(hLine1,'color','red')
set(hLine2,'color','black')
set(hAx,{'ycolor'},{'r';'k'})
set(hAx, 'Position',[0.14 0.18 0.72 0.72])
figure(8)
% fname='airtemp.csv';
% airdata=importdata(fname,',',1);
% 
% airrange=airdata.data(:,1);
airval=Ts;%airdata.data(:,2);
[hAx,hLine1,hLine2] = plotyy(srange/1000,Tb,range/1000,airval)
grid on
title('SMOS Tb and Surface Temp')
xlabel('Range km')
ylabel(hAx(1),'Tb') % left y-axis
ylabel(hAx(2),'Surface Temp (C)') % 
% axes(hAx(2))
 axis(hAx(2),[0 2000 200 300])

%ax.Ytick=[230, 240, 250]

set(hLine1,'color','red')
set(hLine2,'color','black')
set(hAx,{'ycolor'},{'r';'k'})
set(hAx, 'Position',[0.14 0.18 0.72 0.72])
figure(9)

% fname='mass100.csv';
% massdata=importdata(fname,',',1);
% 
% massrange=massdata.data(:,1);
massval=M*100;%massdata.data(:,2);
[hAx,hLine1,hLine2] = plotyy(srange/1000,Tb,range/1000,massval)
grid on
title('SMOS Tb and SMB')
xlabel('Range km')
ylabel(hAx(1),'Tb'); % left y-axis
ylabel(hAx(2),'SMB (cm/yr)')
set(hLine1,'color','red')
set(hLine2,'color','black')
set(hAx,{'ycolor'},{'r';'k'})
set(hAx, 'Position',[0.14 0.18 0.72 0.72])