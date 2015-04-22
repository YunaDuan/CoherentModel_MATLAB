% Get the model results and comapre with SMOS and AQ data
% 1 Get SMOS data in the same range and resolution with MEMLS result

addpath ~/Documents/MyMath/Project/UWBRAD/SMOS&AQ
SMOS=load('SMOS_Jan13_Greenland_Data.mat');
AQ13=load('AQ_Jan13_Greenland_Data.mat');
AQ14=load('AQ_Jan14_Greenland_Data.mat');

SMOS.tbh(1,:)=downsample(SMOS.tbh1,5);
SMOS.tbh(2,:)=downsample(SMOS.tbh2,5);
SMOS.tbh(3,:)=downsample(SMOS.tbh3,5);
SMOS.tbv(1,:)=downsample(SMOS.tbv1,5);
SMOS.tbv(2,:)=downsample(SMOS.tbv2,5);
SMOS.tbv(3,:)=downsample(SMOS.tbv3,5);

AQ13.tbh(1,:)=downsample(AQ13.tbh1,5);
AQ13.tbh(2,:)=downsample(AQ13.tbh2,5);
AQ13.tbh(3,:)=downsample(AQ13.tbh3,5);
AQ13.tbv(1,:)=downsample(AQ13.tbv1,5);
AQ13.tbv(2,:)=downsample(AQ13.tbv2,5);
AQ13.tbv(3,:)=downsample(AQ13.tbv3,5);

AQ14.tbh(1,:)=downsample(AQ14.tbh1,5);
AQ14.tbh(2,:)=downsample(AQ14.tbh2,5);
AQ14.tbh(3,:)=downsample(AQ14.tbh3,5);
AQ14.tbv(1,:)=downsample(AQ14.tbv1,5);
AQ14.tbv(2,:)=downsample(AQ14.tbv2,5);
AQ14.tbv(3,:)=downsample(AQ14.tbv3,5);

