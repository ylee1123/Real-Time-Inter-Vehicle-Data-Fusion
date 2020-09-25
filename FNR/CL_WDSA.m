% Weighted DS for classification 
% num : number of belief vectors, in general, which is equal to the number
% bel : confidences about the predefined classes
%    (in our set-up, we have 16 classes) -> 16 x num
% T : Temperature parameter


function output=CL_WDSA(bel,num,T)

cl_bel=[];
for i=1:num
    cl_bel(:,i)=exp(bel(:,i)/T)/sum(exp(bel(:,i))/T); % Tempreature scaling
end


for i=1:num
    for j=1:i
        D(i,j)=CL_discal(cl_bel(:,i),cl_bel(:,j));
        D(j,i)=D(i,j);
    end
end

S0=1-D;
S=S0-eye(num);
SU=sum(S')';
W=SU./sum(SU);

for i=1:num
    B(:,i)=W(i)*cl_bel(:,i);
end

WDS=sum(B')';

for i=2:num
    WDS=CL_detectDS(WDS,WDS);
end

output=WDS;

end