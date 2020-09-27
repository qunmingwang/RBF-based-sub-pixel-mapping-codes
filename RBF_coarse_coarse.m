function TVV=RBF_coarse_coarse(W,s,para_c);
Assume_L1=zeros(2*W+1,2*W+1);[M1,N1]=find(Assume_L1==0);
for i=1:(2*W+1)^2
    for j=1:(2*W+1)^2
        p1=[(M1(i)-1)*s+s/2,(N1(i)-1)*s+s/2];
        p2=[(M1(j)-1)*s+s/2,(N1(j)-1)*s+s/2];
        TVV(i,j)=exp(-(norm(p1-p2)/para_c)^2);  
    end
end