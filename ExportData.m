% Export .mat file to .dat format for fortran
clear
dir='/Users/yuna/Documents/MyMath/Project/UWBRAD_Estimation/dat/';
cd /Users/yuna/Documents/MyMath/Project/CoherentModel_Fortran/dat

load([dir 'Robin_Sensitive_Study.mat'])
load([dir 'CISMG.mat'])

csvwrite('Ts.dat',Ts)
csvwrite('H.dat',H)
csvwrite('M.dat',M)
csvwrite('CISMG.dat',CISMG)




