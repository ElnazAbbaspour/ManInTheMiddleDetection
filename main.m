clc;
clear;

%% Load Data
% load MITMData.mat;
% load MITMTarget.mat
% Final_Target(find(Final_Target==0))=2;

load  SDN-ARP-dataset.mat
%% Split Data
idx=crossvalind('Holdout',numel(Final_Target),0.7);
Train_Data=Final_Data(find(idx==0),:);
Train_Target=Final_Target(find(idx==0),:);
Test_Data=Final_Data(find(idx==1),:);
Test_Target=Final_Target(find(idx==1),:);

%% SVM Model 
%Model=fitcsvm(Train_Data,Train_Target)
%out=predict(Model,Test_Data);
%[TP, FP, FN, TN,Acc,Prec,Rec,F_Measure] = contingency_table(Test_Target,out);
%% KNN Model
%out=knnclassify(Test_Data,Train_Data,Train_Target,3);
%[TP, FP, FN, TN,Acc,Prec,Rec,F_Measure] = contingency_table(Test_Target,out);
%% DT Model
%Tree=ClassificationTree.fit(Train_Data,Train_Target);
%out=predict(Tree,Test_Data);
%[TP, FP, FN, TN,Acc,Prec,Rec,F_Measure] = contingency_table(Test_Target,out);
%% NB Model
%Model = fitcnb(Train_Data,Train_Target);
%out = predict(Model,Test_Data);
%[TP, FP, FN, TN,Acc,Prec,Rec,F_Measure] = contingency_table(Test_Target,out);
%% RF Model
%Model= fitensemble(Train_Data,Train_Target,'Bag',100,'Tree','type','classification')
%Model = fitensemble(Train_Data,Train_Target,'AdaBoostM1',100,'Tree');
%Model= fitcensemble(Train_Data,Train_Target);
%out = predict(Model,Test_Data);
%[TP, FP, FN, TN,Acc,Prec,Rec,F_Measure] = contingency_table(Test_Target,out);
%% Proposed Model
MaxIteration=100;
PopSize=30;
Low=0;
Up=1;
Dim=size(Test_Data,2);
[BestX_ARO_SA,BestF_ARO_SA,HisBestF_ARO_SA]=ARO_SA(MaxIteration,PopSize,Low,Up,Dim,Train_Data,Train_Target,Test_Data,Test_Target);
[cost,output]=fitness(BestX_ARO_SA,Train_Data,Train_Target,Test_Data,Test_Target);
[TP, FP, FN, TN,sens,prec,rec,FMeasure,ACC] = contingency_table(Test_Target,output);

disp(' ');
disp(['TP= ' num2str(TP) ' FP= ' num2str(FP) ' FN= ' num2str(FN) ' TN= ' num2str(TN)]);
disp(' ');
disp(['Accuracy= ' num2str(ACC) ' Precison= ' num2str(prec) ' Recall= ' num2str(rec) ' F Measure= ' num2str(FMeasure)]);
disp(' ');

