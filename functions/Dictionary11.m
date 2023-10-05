function Dksvd=Dictionary11(I1,I2)

addpath ksvdbox13;
addpath ompbox10;

k=6;   
n0=8;     
N=256;     
[P_E,P_C]=Patchesget(I1,I2,k,n0);    
P0=[P_E,P_C];

set=P0;
set=double(set/255);
params.data=(set);
[r,z]=size(set);
%params.data=X;
%params.data=X;
params.Tdata =20;
params.dictsize = N;
params.iternum =100;               
params.memusage = 'high';
tic
[Dksvd,g,err] = ksvd(params,'');  
toc;