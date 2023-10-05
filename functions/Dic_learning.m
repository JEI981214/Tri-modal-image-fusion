clc;
clear all;
close all;
addpath trainingData2
addpath ompbox10;
addpath ksvdbox13;

overlap=0;      
patch_size=8;   
N=512;    

D = dir(['C:\Program Files\Polyspace\R2019a\bin\JYC_RGF_SR_MAX\my_dic_datas\data3\*.tif']);

for i = 1 : length(D)
a = im2double(imread(D(i).name));
a = rgb2gray(a);
[I1]=Patches_get(a,overlap,patch_size);           

if i==1
    I0=I1;
else
    I0=[I0,I1];
end
end 

set=I0;
set=double(set/255);
params.data=(set);
[r,z]=size(set);

params.Tdata =20;
params.dictsize = N;
params.iternum =180;        
params.memusage = 'high';

[D,g,err] = ksvd(params,'');  
save('D_3-512.mat','D');%

D_2img=cell2mat(struct2cell(load('C:\Program Files\Polyspace\R2019a\bin\JYC_RGF_SR_MAX\D_3-512.mat')));  
 
patch_size=8;  
K=256;  
figure;  
im=displayDictionaryElementsAsImage(D_2img, floor(sqrt(K)), floor(size(D_2img,2)/floor(sqrt(K))),patch_size,patch_size); 




  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
