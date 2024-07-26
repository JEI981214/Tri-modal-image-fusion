close all;
clear all;
clc;
addpath Source_images
addpath my_dics
D=cell2mat(struct2cell(load('my_dics\D_512.mat')));  %


A=imread('MR_Gad.jpg');
B1=imread('SPECT.jpg');


%figure,imshow(A,'border','tight'); 
%figure,imshow(G,'border','tight');
%figure,imshow(B1,'border','tight');

tic

%% Decomposition
iteration=3; 
overlap=6;    
epsilon=0.01;
T=0.00009;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=im2double(A);
B1=im2double(B1);
if size(A,3)>1
    A=rgb2gray(A);             
end
[hei, wid] = size(A);

%% 
B_YUV=ConvertRGBtoYUV(B1);   
B1=B_YUV(:,:,1);            


A=im2double(A);
B1=im2double(B1); 
structure1  = RollingGuidanceFilter(A,3,0.05,iteration);
structure2  = RollingGuidanceFilter(B1,3,0.05,iteration);

texture1=A-structure1;
texture2=B1-structure2;

%% Image fusion
%% Sparse fusion
overlap=6;    
epsilon=0.01;
fuse_high2=sparse_fusion3(texture1,texture2,D,overlap,epsilon);
%%  
fused_structure2=L3(structure1,structure2,T);
%% Reconstruction
F=fuse_high2+fused_structure2;
%% YUV to RGB
F_YUV=zeros(hei,wid,3);
F_YUV(:,:,1)=F;
F_YUV(:,:,2)=B_YUV(:,:,2);
F_YUV(:,:,3)=B_YUV(:,:,3);
final_F=ConvertYUVtoRGB(F_YUV);            
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure,imshow(final_F,'border','tight');

 %imwrite(final_fuse,'');
 %imwrite(final_F,'');