
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Time measurement
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all

%% input

num=10; % number of data points
iter=1000; % number of iterations

conf_m=0.5; % confidence mean
conf_std=0.3; % confidence std

T=1; % Temperature parameter

del_index=4; % process-warm-up time. (will be eliminated)

v_m=70; % Velocity : ground truth
v_std=0.1;


%% confidence setup

exist=abs(conf_m+conf_std*randn(1,num));
exist(exist>=0.9)=0.9;
uncer=(1-exist).*(1/2);
nex=(1-exist).*(1/2);
bel=[exist;nex;uncer];

w1=2;
w2=1;
ref_bel=[0.6;0.0;0.4];


%% CLASSIC DS 
for x=1:iter
tic
DS=bel(:,1);
for i=2:num
    DS=detectDS(DS,bel(:,i)); % Classic DS
end
DS_time(x)=toc;

end

DS_time=DS_time*1000;
DS_time(1:del_index)=[];


%% PROPOSED

for x=1:iter
tic
PRO=PWDSA(bel,num,w1,w2);
PRO_time(x)=toc;
end

PRO_time=PRO_time*1000;
PRO_time(1:del_index)=[];


%% Classification

cl_bel=abs(conf_m+conf_std*randn(16,num));
cl_bel(cl_bel>=1)=0.9;
cl_bel(cl_bel<0)=0.1;

for x=1:iter
tic
CL=CL_WDSA(bel,num,T);
CL_time(x)=toc;
end

CL_time=CL_time*1000;
CL_time(1:del_index)=[];


%% Velocity

v_count=1;
v_time=[];

v_measure=v_m+v_std*randn(1,num);

v_s(1:num)=v_std;

for i=1:iter
    tic
    v_w=1./((v_s).^2*sum(1./((v_s).^2)));
    v_est=sum(v_measure.*v_w);
    v_time(i)=toc;
end


v_time=1000.*v_time;
v_time(1:del_index)=[];



%% Mean of time consumptions

time=[mean(DS_time) mean(PRO_time) mean(CL_time) mean(v_time)];
% unit [ms]









