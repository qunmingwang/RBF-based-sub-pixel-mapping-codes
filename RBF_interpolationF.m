%%%%%%fast RBF, where TVV and TvV are calculated only once
function P_vm=RBF_interpolationF(S,s,W,TVV,TvV);
[c,d]=size(S);
[M1,N1]=find(S~=0&S~=1);numberM1=length(M1);
P_vm=zeros(c*s,d*s);
for k=1:numberM1
    Local_W=S(M1(k)-W:M1(k)+W,N1(k)-W:N1(k)+W);
    rvV=reshape(Local_W,(2*W+1)^2,1);
    gama=inv(TVV)*rvV;
    for i=1:s
        for j=1:s
            cordinate_vm=[W*s+i,W*s+j];
            Fai=D3_D2(TvV(i,j,:));
            P_vm((M1(k)-1)*s+i,(N1(k)-1)*s+j)=Fai'*gama;
        end
    end
end
%%%%%%Within pure pixels, pixel-level classes are copyed to the sub-pixels
[M11,N11]=find(S==1);numberM11=length(M11);
for k=1:numberM11
    for i=1:s
        for j=1:s
            P_vm((M11(k)-1)*s+i,(N11(k)-1)*s+j)=1;
        end
    end
end
