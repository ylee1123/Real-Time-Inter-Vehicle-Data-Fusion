% Baseline : Weighted DS with uncertainty measure
% num : number of belief vectors, in general, which is equal to the number
% of sensors
% bel : belief vector, 3 x num, [existence; non-existence; uncertainty]


function output=UDSA(bel,num)

for i=1:num
    for j=1:num
        D(i,j)=Jdiscal(bel(:,i),bel(:,j));
    end
end

S0=1-D;
S=S0-eye(num);
SU=sum(S')';
W=SU./sum(SU);

U=2*bel(3,1:num)';
CR=W.*exp(1).^(U);
CRD=CR./(sum(CR));

for i=1:num
    B(:,i)=CRD(i)*bel(:,i);
end

WDS=sum(B')';

for i=2:num
    WDS=detectDS(WDS,WDS);
end

output=WDS;

end