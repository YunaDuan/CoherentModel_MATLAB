% Run the Coherent Model:

H = 3700; % Ice thickness
z = [0:0.01:99.99 100:0.5:999 1000:1:H]; % Depth
Ts=216; % Surface Temperature
Kc = 2.7 ; % Ice Thermal Conductivity in W.m-1K-1
Kd = 45 ; % Ice Thermal Diffusivity
G=0.047; % Geothermal Heat Flux
M=0.01; % Accumulation rate

%Density
alpha_d=30; % Damping Coefficient
Delta = 0.040; % Standard Deviation
lc = 0.03;   % Correlation Length, it can be an array

% Monte Carlo Analysis
Num_real = 5; % Number of realizations

% UWBRAD frequency
freq=0.5e9:0.1e9:2e9;

%Temperature Profile

Tpz = temp_profile(Ts,H,M,-z,G,Kc,Kd); %Robin Model, Becareful the depth is negative there

%Incidence Angle in degrees
theta=[0 25 45];

%Input Parameters for the Coherent Model
Input_param.depth = z;
Input_param.Temp_profile =Tpz ;
Input_param.frequency=freq;
Input_param.theta=theta;

for l=1:length(lc)
    
    for n=1:Num_real
        
        
        density = density_profile(z,Delta,lc,alpha_d);
        % Becarfull density here is in kg.m-3 but
        % the standart deviation has to be in g.cm-3 so that you can use
        % Shurun's work.
        Input_param.density_profile = density  ;
        
        
        [Tb_V(n,:,:),Tb_H(n,:,:),Tb(n,:,:)] = coherent_model(Input_param);
    end
    
    %Tb_V_m, Tb_H_m, Tb_m are matrix N*F where N is the number of incidence angles
    %and F the number of frequencies
    Tb_V_m =squeeze(mean(Tb_V,1));
    Tb_H_m =squeeze(mean(Tb_H,1));
    Tb_m =squeeze(mean(Tb,1));
    
    
    
    figure
    plot(freq, Tb_V_m,'b','linewidth',3)
    legend('CM')
    title(['Brightness Temperature Vertical Polarization, lc=' num2str(lc(l))])
    xlabel('Frequency (Hz)')
    ylabel('Brightness Temperature (K)')
    
    figure
    plot(freq, Tb_H_m,'b','linewidth',3)
    legend('CM')
    title(['Brightness Temperature Horizontal Polarization, lc=' num2str(lc(l))])
    xlabel('Frequency (Hz)')
    ylabel('Brightness Temperature (K)')
    
    figure
    plot(freq, Tb_m,'b','linewidth',3)
    legend('CM')
    title(['Brightness Temperature, lc=' num2str(lc(l))])
    xlabel('Frequency (Hz)')
    ylabel('Brightness Temperature (K)')
end