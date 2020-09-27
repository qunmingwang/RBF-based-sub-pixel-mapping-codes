function TvV=RBF_fine_coarse(p_vm,W,s,para_c);
Assume_L1=zeros(2*W+1,2*W+1);[M1,N1]=find(Assume_L1==0);
Assume_L2=zeros(s,s);[M2,N2]=find(Assume_L2==0);
for i=1:(2*W+1)^2
    p1=[(M1(i)-1)*s+s/2,(N1(i)-1)*s+s/2];
    TvV(i,1)=exp(-(norm(p_vm-p1)/para_c)^2);  
end