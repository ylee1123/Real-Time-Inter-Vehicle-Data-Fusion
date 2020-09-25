% Calculate communication delay
% DSRC based
% distance : distance between object
% packet : packet size
% rate_index : rate_index, from reference
% 1 : 12 Mbps
% 2 : 18 Mbps
% 3 : 24 Mbps
% 4 : 27 Mbps


function [d]=DSRC(distance,packet,period,rate_index)

pl_exponent=3; 
dis_gain=distance^(-pl_exponent);
F=packet*8;


ant_gain=sqrt(10); % 5dB
PT=0.01;  % 10dBm   

BW=10*10^6;  % Bandwidth : 10 MHz
W=5.9*10^(9);   % 주파수 : 5.9 GHz


N0=0.004*10^(-18);   % Noise spectral power : -174dBM   
PL0=((3*10^8/(4*W*pi))^2);     % Reference path loss : 파장/(4*pi)=(3*10^8)/(4*pi*주파수) 
H=4;     % Fading coefficient
A=1; % Attenuation

par=(H*PL0*A)/(N0*BW);
power=PT;

rate=BW*log2(1+par*ant_gain*ant_gain*dis_gain*PT);
delay=F/rate*10^3*period;  % ms 

output=delay;

%% supported DSRC data rate (depending on MCS)

r1=12*10^6;
r2=18*10^6;
r3=24*10^6;
r4=27*10^6;



d_output=[F/r1*10^3*period;
    F/r2*10^3*period;
    F/r3*10^3*period;
    F/r4*10^3*period;];


d=d_output(rate_index);


end