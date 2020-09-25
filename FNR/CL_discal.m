% Jousselme distance for classification
% x,y : belief vector, 3 x 1
% x, y : 3 x 1 vector
% x, y = [existence; non-existence; uncertainty];


function output=CL_discal(x,y)


x1=x-y;
si=length(x);
x2=eye(si);

output = sqrt(1/2*x1'*x2*x1);


end