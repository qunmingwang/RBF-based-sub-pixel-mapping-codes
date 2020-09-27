%%%%%This is a code for Radial Basis Function interpolation-based sub-pixel mapping
%%%%%Copyrights are reserved. If you use this code, please cite
%%%%%Q. Wang, W. Shi, P. M. Atkinson. Sub-pixel mapping of remote sensing images based on radial basis function interpolation.
%%%%%ISPRS Journal of Photogrammetry and Remote Sensing, 2014, 92: 1¨C15

clear all;
load Image;J=Image;%%%%%Here Image is a thematic map covering four classes: 1,2,3,4. 
%%%%%Please revise the code according to the number of clases in your studied image
s=4;%%%%%%zoom factor
%%%%%%Coarse proportion images are simulated by degarding the fine spatial resolution thematic map
S1=dowmsample_plane(J==1,s);S2=dowmsample_plane(J==2,s);S3=dowmsample_plane(J==3,s);S4=dowmsample_plane(J==4,s);

W=2;
S1=dowmsample_plane(J==1,s);S2=dowmsample_plane(J==2,s);S3=dowmsample_plane(J==3,s);S4=dowmsample_plane(J==4,s);
[a1,b1]=size(S1);
S1_extend=zeros(a1+2*W,b1+2*W);S1_extend(W+1:end-W,W+1:end-W)=S1;
S2_extend=zeros(a1+2*W,b1+2*W);S2_extend(W+1:end-W,W+1:end-W)=S2;
S3_extend=zeros(a1+2*W,b1+2*W);S3_extend(W+1:end-W,W+1:end-W)=S3;
S4_extend=zeros(a1+2*W,b1+2*W);S4_extend(W+1:end-W,W+1:end-W)=S4;

%%%%%%%%%%Predicting the soft class values (between 0 and 1) at sub-pixel resoltuion
para_c=10;
TVV=RBF_coarse_coarse(W,s,para_c);

for i=1:s
    for j=1:s
        cordinate_vm=[W*s+i-0.5,W*s+j-0.5];
        TvV(i,j,:)=RBF_fine_coarse(cordinate_vm,W,s,para_c);
    end
end
P1_vm=RBF_interpolationF(S1_extend,s,W,TVV,TvV);P2_vm=RBF_interpolationF(S2_extend,s,W,TVV,TvV);
P3_vm=RBF_interpolationF(S3_extend,s,W,TVV,TvV);P4_vm=RBF_interpolationF(S4_extend,s,W,TVV,TvV);

P1=P1_vm(W*s+1:end-W*s,W*s+1:end-W*s);P2=P2_vm(W*s+1:end-W*s,W*s+1:end-W*s);
P3=P3_vm(W*s+1:end-W*s,W*s+1:end-W*s);P4=P4_vm(W*s+1:end-W*s,W*s+1:end-W*s);
P1=between01(P1);P2=between01(P2);P3=between01(P3);P4=between01(P4);
P_all=P1+P2+P3+P4;
P1=P1./P_all;P2=P2./P_all;P3=P3./P_all;P4=P4./P_all;

%%%%%%%%%%Class allocation based on UOC, which is propsoed in
%%%%%Q. Wang, W. Shi, L. Wang. Allocating classes for soft-then-hard subpixel mapping algorithms in units of class.
%%%%%IEEE Transactions on Geoscience and Remote Sensing, 2014, 52(5): 2940¨C2959
MoI(:,1)=MoranI(S1,8);MoI(:,2)=MoranI(S2,8);MoI(:,3)=MoranI(S3,8);MoI(:,4)=MoranI(S4,8);
[a2,b2]=size(J);
P_all(:,:,1)=P1;P_all(:,:,2)=P2;P_all(:,:,3)=P3;P_all(:,:,4)=P4;
S_all(:,:,1)=S1;S_all(:,:,2)=S2;S_all(:,:,3)=S3;S_all(:,:,4)=S4;
[PP,class_order]=sort(MoI,2,'descend');

P_result1=allocate_c_after_c(P_all(:,:,class_order(1)),S_all(:,:,class_order(1)),s);
P02=P_all(:,:,class_order(2))-2*P_result1;P_result2=allocate_c_after_c(P02,S_all(:,:,class_order(2)),s);
P03=P_all(:,:,class_order(3))-2*(P_result1+P_result2);P_result3=allocate_c_after_c(P03,S_all(:,:,class_order(3)),s);
P_result=class_order(1)*P_result1+class_order(2)*P_result2+class_order(3)*P_result3;
for i=1:a2
    for j=1:b2
        if P_result(i,j)==0
            P_result(i,j)=class_order(4);
        end
    end
end
figure,imshow(P_result,[]);
