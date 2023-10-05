close all;
clear all;
clc;
addpath Source_images
addpath my_dics
D=cell2mat(struct2cell(load('my_dics\D_512.mat')));  %


A=imread(MR_Gad.jpg);
B=imread(MR_T2.jpg);
A=imread(SPECT.jpg);


figure,imshow(A,'border','tight'); 
figure,imshow(G,'border','tight');
figure,imshow(B1,'border','tight');

if size(A,3)>1
    A=rgb2gray(A);            
end

if size(G,3)>1
    G=rgb2gray(G);             
end

A = im2double(A);   
G = im2double(G);    
tic

%% Decomposition
A=im2double(A);
G=im2double(G);

iteration=3; 

structure1  = RollingGuidanceFilter(A,3,0.05,iteration);
% figure,imshow(structure1,'border','tight');
texture1=A-structure1;
% figure,imshow(texture1,[-0.5,0.5],'border','tight');


structure2  = RollingGuidanceFilter(G,3,0.05,iteration);

% figure,imshow(structure1,[-0.5,0.5],'border','tight');

texture1=A-structure1;
texture2=G-structure2;

% figure,imshow(texture1,[-0.5,0.5],'border','tight')
% figure,imshow(texture2,[-0.5,0.5],'border','tight');

%% Fusion rules 
%% Sparse fusion

overlap=6;    
epsilon=0.01;
fuse_high=sparse_fusion3(texture1,texture2,D,overlap,epsilon);

%% Cartoon layer:AECS
T=0.00009;
fused_structure=L3(structure1,structure2,T);
%% Reconstruction
Fuse_img=fuse_high+fused_structure;
M = Fuse_img;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M=im2double(M);
B1=im2double(B1);
if size(M,3)>1
    M=rgb2gray(M);             
end

[hei, wid] = size(M);

%% 
B_YUV=ConvertRGBtoYUV(B1);   
B1=B_YUV(:,:,1);            


M=im2double(M);
B1=im2double(B1); 
structure1  = RollingGuidanceFilter(M,3,0.05,iteration);
structure2  = RollingGuidanceFilter(B1,3,0.05,iteration);

texture1=M-structure1;
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
final_fuse=uint8(Fuse_img*255);
figure,imshow(final_fuse,'border','tight');

final_fuse2=uint8(final_F*255);
figure,imshow(final_F,'border','tight');

 %imwrite(final_fuse,'');
 %imwrite(final_F,'');