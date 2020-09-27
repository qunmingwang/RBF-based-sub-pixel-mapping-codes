function I=MoranI(f,number_neigbors);
f_part=f(2:end-1,2:end-1);
[a,b]=size(f_part);
Mean=mean(mean(f_part));
for i=1:a
    for j=1:b
        if number_neigbors==8
            L_W=[f(i,j),f(i,j+1),f(i,j+2),f(i+1,j),f(i+1,j+2),f(i+2,j),f(i+2,j+1),f(i+2,j+2)];
        elseif number_neigbors==4
            L_W=[f(i,j+1),f(i+1,j),f(i+1,j+2),f(i+2,j+1)];
        end
        A(i,j)=(f(i+1,j+1)-Mean)*sum(L_W-Mean);
    end
end
I=sum(sum(A))/(number_neigbors*sum(sum((f_part-Mean).^2)));