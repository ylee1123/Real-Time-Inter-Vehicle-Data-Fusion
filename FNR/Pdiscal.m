% Proposed distance
% x,y : belief vector, 3 x 1
% x, y : 3 x 1 vector
% x, y = [existence; non-existence; uncertainty];
% w1 : weight for 'existence'
% w2 : weight for 'non-existence'


function output=Pdiscal(x,y,w1,w2)

w3=w1+w2;

x1=x-y;
x2=[1 0 w1/w3;
    0 1 w2/w3;
    w1/w3 w2/w3 1];

output = sqrt(1/2*x1'*x2*x1);


end