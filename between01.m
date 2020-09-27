function P01=between01(P);
[a,b]=size(P);
P01=P;
for i=1:a
    for j=1:b
        if P(i,j)<0
            P01(i,j)=0;
        elseif P(i,j)>1
            P01(i,j)=1;
        end
    end
end