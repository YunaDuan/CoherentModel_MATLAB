fname='SensorData/ConicalSpiral_40Turns_NoseConeGeometry.csv';

UWBRADSensor.GaindB=csvread(fname,1,1,[1,1,181,16]);    
UWBRADSensor.Theta=180:-2:-180;
UWBRADSensor.Freq=linspace(0.5,2,16);

fGhz=[0.54  0.66  0.78  0.9  1.02  1.14  1.26  1.38 1.5  1.62  1.74  1.86  1.98];