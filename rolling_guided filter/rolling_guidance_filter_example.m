
close all;
clear  all;clc;
[imagename1 imagepath1]=uigetfile('medical images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
ima1=imread(strcat(imagepath1,imagename1));
[imagename2 imagepath2]=uigetfile('medical images\*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
ima2=imread(strcat(imagepath2,imagename2));

I1 = im2double(ima1);
I2 = im2double(ima2);
%figure,imshow(I1,[]);
%figure,imshow(I2,[]);
iteration=8;      

C1 = RollingGuidanceFilter(I1,3,0.05,iteration);
C2 = RollingGuidanceFilter(I2,3,0.05,iteration);
figure,imshow(C1);   figure,imshow(C2);

T1=I1-C1;
T2=I2-C2;
% figure,imshow(T1,[]);   figure,imshow(T2,[]);


map1=abs(C1>C2);
FC=C1.*map1+~map1.*C2;
% FC=(C1+C2)/2;

% ST1=str_tensor_map(T1);
% ST2=str_tensor_map(T2);
% map2=abs(ST1>ST2);
map2=abs(T1>T2);
FT=T1.*map2+~map2.*T2;
F=FC+FT;

figure,imshow(FC);
figure,imshow(FT,[]);
figure,imshow(F);



