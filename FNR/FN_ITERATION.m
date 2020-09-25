%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% False negative errors comparison
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc
clear all

num=10; % number of sensors
mean_iter=100; % NUMBER OF ITERATION

w1=100;
w2=1; % weights for the proposed scheme

b_m=0.7; % sensor mean
b_std=0.3; % sensor std


DS_time=[]; 
PRO_time=[]; 
WDS_time=[];
t_count=1;


%%

for z=1:mean_iter
save_fn=[];
save_time=[];
save_count=1;


for n=0.3:0.1:0.9 % normal sensor ratio, 0.3 : normal sensors /all sensors = 0.3   

    num1=ceil(num*n);
    num2=num-num1;
    
    DS_FN_count=0;
    WDS_FN_count=0;
    PRO_FN_count=0;  
    UD_FN_count=0;
    
%%


for t=1:100
    
    
%% Confidence assignment 1
    
exist1=abs(b_m+b_std*randn(1,num1));
exist1(exist1>=0.9)=0.9;
uncer1=(1-exist1).*(1/2);
nex1=(1-exist1).*(1/2);

nex2=abs(b_m+b_std*randn(1,num2));
nex2(nex2>=0.9)=0.9;
uncer2=(1-nex2).*(1/2);
exist2=(1-nex2).*(1/2);

bel=[exist1 exist2;
    nex1 nex2;
    uncer1 uncer2];


%%

DS=[];
WDS=[];
PRO=[];
UD=[];

%% DS
DS=bel(:,1);
tic
for i=2:num
    DS=detectDS(DS,bel(:,i)); % ORIGINAL DS
end
DS_time(t_count)=toc;

if DS(2)>0.5
    DS_FN_count=DS_FN_count+1;
end

%% WDS (Jousselme distance)
tic
WDS=JWDSA(bel,num);
WDS_time(t_count)=toc;

if WDS(2)>0.5
   WDS_FN_count=WDS_FN_count+1;
end

t_count=t_count+1;

%% PROPOSED
tic
PRO=PWDSA(bel,num,w1,w2);
PRO_time(t_count)=toc;

if PRO(2)>0.5
    PRO_FN_count=PRO_FN_count+1;
end


%% BASELINE

UD=UDSA(bel,num);

if UD(2)>0.5
    UD_FN_count=UD_FN_count+1;
end

end


DS_time(1:5)=[];
PRO_time(1:5)=[];
WDS_time(1:5)=[];


FNcount=[DS_FN_count WDS_FN_count UD_FN_count PRO_FN_count];
T=[mean(DS_time) mean(WDS_time) mean(PRO_time)]*1000;


save_FN(:,save_count,z)=FNcount';
save_time(:,save_count,z)=T';
save_count=save_count+1;

end
end


%% FIGURE


plot_FN=zeros(4,7);
for i=1:mean_iter
plot_FN=plot_FN+save_FN(:,:,i);
end
plot_FN=plot_FN./mean_iter/100;



figure(2)
plot(plot_FN(1,:),'bo-','linewidth',2,'markersize',8,'markerface','b')
hold on
grid on
plot(plot_FN(2,:),'kd-','linewidth',2,'markersize',8,'markerface','k')
plot(plot_FN(3,:),'gs-','linewidth',2,'markersize',8,'markerface','c')
plot(plot_FN(4,:),'m*-.','linewidth',2,'markersize',8,'markerface','g')

legend('Classic DS','Weighted DS (Jousselme distance)','[38]','Proposed')
set(gca,'xticklabel',[3 4 5 6 7 8 9],'fontsize',20)
xlabel('Number of normal sensors','fontsize',20)
ylabel('False negative probability','fontsize',20)




% 
% 
% plot_FN2=zeros(6,7);
% for i=1:mean_iter
% plot_FN2=plot_FN2+save_FN(:,:,i);
% end
% 
% plot_FN2=plot_FN2./(100*mean_iter);
% 
% figure(3)
% plot(plot_FN2(1,:),'bo-','linewidth',2,'markersize',8,'markerface','b')
% hold on
% grid on
% plot(plot_FN2(2,:),'kd-','linewidth',2,'markersize',8,'markerface','k')
% plot(plot_FN2(4,:),'gs-','linewidth',2,'markersize',8,'markerface','c')
% plot(plot_FN2(5,:),'m*-.','linewidth',2,'markersize',8,'markerface','g')
% plot(plot_FN2(6,:),'m<-','linewidth',2,'markersize',8,'markerface','m')
% 
% 
% % set(gca,'xticklabel',[3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9],'fontsize',12)
% set(gca,'xticklabel',[3 4 5 6 7 8 9],'fontsize',13)
% 
% xlabel('Number of vehicles with normal sensor')
% ylabel('False negative rate')
% % legend('Classic DS','Weighted DS (Jousselme distance)','[42]','Proposed, {\fontname{Lucida Calligraphy} A}=\{2,1,3\}','Proposed, {\fontname{Lucida Calligraphy} A}=\{100,1,101\}')
% legend('Classic DS','Weighted DS (Jousselme distance)','[45]','Proposed, Q(E,U)=2/3, Q(N,U)=1/3','Proposed, Q(E,U)=100/101, Q(N,U)=1/101 ')
% 
% axes('Position',[.6 .3 .3 .2])
% box on
% plot(plot_FN2(1,5:7),'bo-','linewidth',2,'markersize',8,'markerface','b')
% hold on
% grid on
% plot(plot_FN2(2,5:7),'kd-','linewidth',2,'markersize',8,'markerface','k')
% plot(plot_FN2(4,5:7),'gs-','linewidth',2,'markersize',8,'markerface','c')
% plot(plot_FN2(5,5:7),'m*-.','linewidth',2,'markersize',8,'markerface','g')
% plot(plot_FN2(6,5:7),'m<-','linewidth',2,'markersize',8,'markerface','m')
% 
% 
% abs(plot_FN2(1,:)-plot_FN2(6,:))./plot_FN2(1,:)
% abs(plot_FN2(2,:)-plot_FN2(6,:))./plot_FN2(2,:)
% abs(plot_FN2(4,:)-plot_FN2(6,:))./plot_FN2(4,:)
% 
% % 
% % 
% % 
% % 
% % figure(2)
% % plot(plot_FN(1,:),'bo-','linewidth',2)
% % hold on
% % grid on
% % plot(plot_FN(2,:),'kd-','linewidth',2)
% % plot(plot_FN(6,:),'rh-','linewidth',2)
% % 
% % 
% % 
% %%
% 
% 
% 
% dd=[0.9474 0.7928 0.4982 0.0519 0.0492 0.0083 0;
%     0.9652 0.8282 0.4969 0.0324 0.0347 0.0051 0;
%     0.9474 0.8108 0.4999 0.0520 0.0502 0.0131 0;
%     0.9397 0.7579 0.4073 0.0185 0.0173 0.0025 0]
% 
% 
% abs(dd(1,:)-dd(4,:))./dd(1,:)
% abs(dd(2,:)-dd(4,:))./dd(2,:)
% abs(dd(3,:)-dd(4,:))./dd(3,:)
% 
% 


