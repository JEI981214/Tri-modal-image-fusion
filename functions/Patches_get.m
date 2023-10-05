function [P0]=Patches_get(I,overlap,patch_size)

[h,w]=size(I);

gridx = 1:patch_size - overlap : w-patch_size+1;
gridy = 1:patch_size - overlap : h-patch_size+1;

P0=zeros(patch_size*patch_size,length(gridx)*length(gridy));
i=1;
for ii = 1:length(gridx)
    for jj = 1:length(gridy)
        xx = gridx(ii);
        yy = gridy(jj);  
        patch_1 = I(yy:yy+patch_size-1, xx:xx+patch_size-1);
        P0(:,i)=patch_1(:);
        i=i+1;
    end
end