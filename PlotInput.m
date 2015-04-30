% Plot the Input parameters of coherent model for checking
    
    figure
    set(gca,'fontsize',14)
    
    %temperature
    subplot(2,2,1)
    plot(Input_param.depth, Input_param.Temp_profile)
    title('Temperature')
    xlabel('Depth m')
    ylabel('Temperature (K)')
    
    %density
    subplot(2,2,2)
    plot(Input_param.depth, Input_param.density_profile)
    title('Density')
    xlabel('Depth m')
    ylabel('Density kg/m3')
    
    %density variation
     subplot(2,2,3)
    plot(Input_param.depth(1:10000), Input_param.density_profile(1:10000))
    title('Density Variation')
    xlabel('Depth m')
    ylabel('Density kg/m3')
    
    %layer thickness
    subplot(2,2,4)
    plot(Input_param.depth(2:end), diff(Input_param.depth))
    title('Layer thickness')
    xlabel('Depth m')
    ylabel('layer thickness (m)')