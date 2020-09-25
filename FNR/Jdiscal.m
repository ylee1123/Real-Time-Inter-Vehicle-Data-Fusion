% Jousselme distance
% x,y : belief vector, 3 x 1
% x, y : 3 x 1 vector
% x, y = [existence; non-existence; uncertainty];


function output=Jdiscal(x,y)


x1=x-y;
x2=[1 0 1/2;
    0 1 1/2;
    1/2 1/2 1];

output = sqrt(1/2*x1'*x2*x1);


end