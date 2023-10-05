function fused_structure = L3(structure1,structure2,T)
[row,column]=size(structure1);   
window_wide=5;

SML1=SML(structure1,window_wide);
SML2=SML(structure2,window_wide);
 
for i=1:row
    for  j=1:column
        if structure1(i,j)-structure2(i,j)>T || (abs(structure1(i,j)-structure2(i,j))<T  &&  SML1(i,j)>SML2(i,j));
            fused_structure(i,j)=structure1(i,j);
        else structure2(i,j)-structure1(i,j)>T || (abs(structure2(i,j)-structure1(i,j))<T  &&  SML2(i,j)>SML1(i,j));
            fused_structure(i,j)=structure2(i,j);
        end
    end
end
end

