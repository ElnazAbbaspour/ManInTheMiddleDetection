function [cost,output]=fitness(x,Train_Data,Train_Target,Test_Data,Test_Target)
x(x>=0.5)=1;
x(x<0.5)=0;
if(sum(x)>=1)
    index=find(x==1);
    Train_Data=Train_Data(:,index);
    Test_Data=Test_Data(:,index);
    md1=fitctree(Train_Data,Train_Target);
    output = predict(md1,Test_Data);
    err=Test_Target-output;
    cost=(numel(find(err~=0))/numel(err))*100;
else
    cost=100;
end
end