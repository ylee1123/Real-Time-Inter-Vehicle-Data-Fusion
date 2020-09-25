% Conventional DS for classification
% x_raw, y_raw : # of predefined class x 1 vector, in our set-up, we have
% 16 x 1 vector

% NOTE: there is no intersection between elements in x_raw
% ex) x_raw=[car; bus] -> (car interstion bus) / (car union bus) = 0

function output=CL_detectDS(x_raw,y_raw)

vector_l=length(x_raw);

x=x_raw./sum(x_raw);
y=y_raw./sum(y_raw);


for i=1:vector_l

    nu=x(i)*y(i);
    
    deno1=0;
    for j=1:vector_l
        for k=1:vector_l
            if j~=k
                deno1=deno1+x(j)*y(k);
            end
        end
    end
    
    deno=1-deno1;
    output(i,1)=nu/deno;
    
end

end