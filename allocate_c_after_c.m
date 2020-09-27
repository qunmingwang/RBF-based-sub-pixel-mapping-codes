function P=allocate_c_after_c(P0,S0,s);
[a,b]=size(P0);
Assume_S=zeros(a/s,b/s);[M,N]=find(Assume_S==0);
for k=1:a*b/s^2
    PICK=P0((M(k)-1)*s+1:M(k)*s,(N(k)-1)*s+1:N(k)*s);
    Row=reshape(PICK,1,s^2);
    [R,T]=sort(Row,2,'descend');
    E1=zeros(1,s^2);
    n0=int16(S0(M(k),N(k))*s^2);
    for i=1:n0
        E1(1,T(i))=1;
    end
    E2=reshape(E1,s,s);
    for i=1:s
        for j=1:s
            P((M(k)-1)*s+i,(N(k)-1)*s+j)=E2(i,j);
        end
    end
end