% Run the Coherent Model:
% Modified by Yuna Feb 11th for running on mulitiple  point
clear
%% 1 Get data
%1.1 Temperature data: Robin model result
addpath ~/Documents/MyMath/Project/UWBRAD/NewFlightRange
load('RobinTemp.mat');
m=length(RobinT.z);

%1.2 Get the grid for each point

for i=1:m
    h=RobinT.z{i};
    if h < 1000
        Z{i}=[ 0:0.01:99.99 100:0.5:h(1)];
    else
        Z{i}=[ 0:0.01:99.99 100:0.5:999 1000:h(1)];
    end
end

%% 2 interpolate data to grid 

for i=1:m
    T{i}=interp1(RobinT.z{i},flip(RobinT.T{i}),Z{i});
end

%% 3 Put together MEMLS inputs
freq=1.4;
theta=[28.8 38 45.8];
Input_param.frequency=freq;
Input_param.theta=theta;

alpha_d=30; % Damping Coefficient
Delta = 0.040; % Standard Deviation [g/cm3]
lc = 0.4;   % Correlation Length, it can be an array

% Monte Carlo Analysis
Num_real = 10; % Number of realizations

tic
for i=1:m

    disp(['Running point '  num2str(i) '/' num2str(m) ...
        '. Elapsed time=' num2str(toc) 'seconds.' ])
%Input Parameters for the Coherent Model
Input_param.depth = Z{i};
Input_param.Temp_profile =T{i} ;
            
    for n=1:Num_real
   
        density = density_profile(Z{i},Delta,lc,alpha_d);
        % Becarfull density here is in kg.m-3 but
        % the standart deviation has to be in g.cm-3 so that you can use
        % Shurun's work.
        Input_param.density_profile = density;
        [Tb_V(n,:,:),Tb_H(n,:,:),Tb(n,:,:)] = coherent_model(Input_param);
    end
    
    %Tb_V_m, Tb_H_m, Tb_m are matrix N*F where N is the number of incidence angles
    %and F the number of frequencies
    %The Tb is finally stored in a N*F*M matrix, with each page for a
    %point, each column for a frequency and each row for a incidence angle
    Tb_V_m(:,:,i) =squeeze(mean(Tb_V,1));
    Tb_H_m(:,:,i) =squeeze(mean(Tb_H,1));
    Tb_m(:,:,i) =squeeze(mean(Tb,1));
    
end  
toc   

%% 4.compare with SMOS and AQ
SMOS_AQ;

TBV=squeeze(Tb_V_m);
for i=1:3
    figure(1),subplot(1,2,1),plot(RobinT.range/1000,TBV(i,:),'b');hold on
    plot(RobinT.range/1000,SMOS.tbv(i,6:99),'r');
end
xlabel('Range [km]','fontsize',14);ylabel('Tb [k]','fontsize',14);
title('vertical polarization','fontsize',14);
legend('CM','Aquarius');

TBH=squeeze(Tb_H_m);
for i=1:3
    figure(1),subplot(1,2,2),plot(RobinT.range/1000,TBH(i,:),'b');hold on
    plot(RobinT.range/1000,SMOS.tbh(i,6:99),'r');
end
xlabel('Range [km]','fontsize',14);ylabel('Tb [k]','fontsize',14);
title('horizontal polarization','fontsize',14);
legend('CM','SMOS');
