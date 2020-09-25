% Conventional Dempster-Shafer combination
% x,y : belief vector, 3 x 1
% x, y : 3 x 1 vector
% x, y = [existence; non-existence; uncertainty];


function output=detectDS(x,y)

deno=1-x(1)*y(2)-x(2)*y(1);

detect = (x(1)*y(1)+x(1)*y(3)+x(3)*y(1))/deno;
nondetect = (x(2)*y(2)+x(2)*y(3)+x(3)*y(2))/deno;
uncertainty = x(3)*y(3)/deno;

output = [detect;nondetect;uncertainty];

end