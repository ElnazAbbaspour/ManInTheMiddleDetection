function [TP, FP, FN, TN,sens,prec,rec,FMeasure,ACC] = contingency_table(gold,test_outcome)

% True positives
TP = test_outcome(gold == 1);
TP = length(TP(TP == 1));

% False positives
FP = test_outcome(gold == 2);
FP = length(FP(FP == 1));

% False negatives
FN = test_outcome(gold == 1);
FN = length(FN(FN == 2));

% True negatives
TN = test_outcome(gold == 2);
TN = length(TN(TN == 2));

% % Sensitivity
sens =( TP/(TP+FN))*100;
% 
% % Specificity
spec = (TN/(FP+TN))*100;
% 
% % True Positives Rate
TP_Rate = (TP/(TP+FN))*100;
% 
% % True Negative Rate 
TN_Rate = (TN/(FP+TN))*100;

%% Area Under Curve 
ACC=((TP+TN)/(TP+FP+FN+TN))*100;
%
% % Precision Rate
prec=(TP/(TP+FP))*100;
%
% % Recall Rate
rec=(TP/(TP+FN))*100;
%
% % F Measure Rate
FMeasure=(2*prec*rec)/(prec+rec);

end