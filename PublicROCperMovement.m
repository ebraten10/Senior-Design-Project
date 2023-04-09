%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This code was used to plot the ROC curve of each type
%of eye movement (B,U,D,R,L) for one subject in the public dataset found at
%https://www.um.edu.mt/cbc/ourprojects/EOG/EOGdataset. You must have the
%folder DATASET in the same folder as this m file for the code to run.

clc
clear
subjectnum=1;

%Each value in numz is multiplied by the max/min value for each movement. 
% This results in a range of values from 0 to the max/min value that are
% used to find the TPR and FPR 
numz=0:0.01:1;

%TPR and FPR are matrices with each row corresponding to a different
%movement
%Row 1 - Right
%Row 2 - Left
%Row 3 - Up
%Row 4 - Down
%Row 5 - Blink
TPR = zeros(5,length(numz));
FPR = zeros(5,length(numz));

%AUC is a vector that saves the AUC score for each of the 5 movements
AUC=zeros(1,5);
Hangle=4.4;
Vangle=2.6;
count=1;

for mult=numz

    roothpath = sprintf('DATASET/S%d',subjectnum);
    load(fullfile(roothpath,'EOG.mat'))
    load(fullfile(roothpath,'TargetGA.mat'))
    load(fullfile(roothpath,'ControlSignal.mat'))
    
    T = TargetGA;
    H = EOG(1,:);
    V = EOG(2,:);
    dh = diff(H);
    dv = diff(V);
    C = ControlSignal;

    %id is a vector containing the start and end points of each forward
    %saccade, return saccade, and blink interval in the EOG data according
    %to the Control Signal (C). There are 300 trials that each contain
    %three separate intervals which makes id a vector of 899 points + the
    %additional starting point (1) and ending point (length(dh)) for a
    %total of 901 points.
    f = find((diff(C)==1) | (diff(C)==-2));
    id=[1,f,length(dh)]; 

    cc
    [thPH,thNH,thPV,thNV,thB] = MinAndMax(H,V,C,T);
    
    %ACCB is the vector that contains a 1 at the indices that correspond to
    %intervals where a blink actually happens
    ACCB = zeros(1,900);
    indx = 1;
    for i=3:3:900
        ACCB(i)=1;
    end

    %ACC is the vector that contains a 1 at the indices that correspond to
    %intervals where a saccadic movement actually happens
    %Row 1 - Right
    %Row 2 - Left
    %Row 3 - Up
    %Row 4 - Down
    ACC = zeros(4,300);
    for Tcount=1:2:599
        if T(Tcount,1) > Hangle
            ACC(1,indx) = 1;
        else
            ACC(1,indx) = 0;
        end
        if T(Tcount,1) < -Hangle
            ACC(2,indx) = 1;
        else
            ACC(2,indx) = 0;
        end
        if T(Tcount,2) > Vangle
            ACC(indx) = 1;
        else
            ACC(indx) = 0;
        end
        if T(Tcount,2) < -Vangle
            ACC(4,indx) = 1;
        else
            ACC(4,indx) = 0;
        end
        indx = indx+1;
    end
    
    %Pred is the vector that contains a 1 at the indices that correspond to
    %intervals where a saccadic movement is predicted 
    %Row 1 - Right
    %Row 2 - Left
    %Row 3 - Up
    %Row 4 - Down
    Pred = zeros(4,300);
    intv = 1;

    %PredB is the vector that contains a 1 at the indices that correspond to
    %intervals where a blink is predicted 
    PredB = zeros(1,900);
    intvB = 1;
    
    for i=1:900
        [pksB,locsB] = findpeaks(dv(id(i):id(i+1)),id(i):id(i+1),'MinPeakHeight',thB*mult);
        %Check if a blink was detected in each interval
        if ~isempty(pksB)
            PredB(intvB) = 1;
        else
            PredB(intvB) = 0;
        end
        intvB = intvB+1;
    
        %Predicted saccadic movements are only checked during intervals of
        %forward saccades
        if rem(i,3)==1
    
            [pksH,locsH] = findpeaks(dh(id(i):id(i+1)),id(i):id(i+1),'MinPeakHeight',thPH*mult);
            [NpksH,NlocsH] = findpeaks(-dh(id(i):id(i+1)),id(i):id(i+1),'MinPeakHeight',thNH*mult);
            [pksV,locsV] = findpeaks(dv(id(i):id(i+1)),id(i):id(i+1),'MinPeakHeight',thPV*mult);
            [NpksV,NlocsV] = findpeaks(-dv(id(i):id(i+1)),id(i):id(i+1),'MinPeakHeight',thNV*mult);
    
            if ~isempty(pksH)
                Pred(1,intv) = 1;
            else
                Pred(1,intv) = 0;
            end
    
            if ~isempty(NpksH)
                Pred(2,intv) = 1;
            else
                Pred(2,intv) = 0;
            end
    
            if ~isempty(pksV)
                Pred(3,intv) = 1;
            else
                Pred(3,intv) = 0;
            end
      
            if ~isempty(NpksV)
                Pred(4,intv) = 1;
            else
                Pred(4,intv) = 0;
            end
            intv = intv+1;
        end   
    end
    
    %TPR and FPR values for each of the 5 movements are stored in matrices
    %TPR and FPR
    %Row 1 - Right
    %Row 2 - Left
    %Row 3 - Up
    %Row 4 - Down
    %Row 5 - Blink
    for m=1:4
        [tpr,fpr]=roc(ACC(m,:),Pred(m,:));
        TPR(m,count)=max(tpr);
        FPR(m,count)=max(fpr);
    end
    [tprB,fprB]=roc(ACCB,PredB);
    TPR(5,count)=max(tprB);
    FPR(5,count)=max(fprB);
    
    count=count+1;
end

x=[0.38,0.82,0.38,0.82,0.38];
y=[0.68,0.68,0.38,0.38,0.08];
th=[thPH,thNH,thPV,thNV,thB];

%Plot the ROC curves and AUC scores for each movement
for move=1:5
    AUC(1,move)=trapz(flip(FPR(move,:)),flip(TPR(move,:)));
    best = KneePoint(TPR,FPR,numz,th(move));
    subplot(3,2,move)
    plot(FPR(move,:),TPR(move,:))
    ti=sprintf('S%d ROC Curve',subjectnum);
    title(ti)
    xlabel("False Positive Rate")
    ylabel("True Positive Rate")
    strAUC=sprintf('AUC = %f',AUC(1,move));
    strBest = sprintf('Best threshold value = %f',best);
    annotation('textbox',[x(move) y(move) .1 .1],'String',strAUC,'FitBoxToText','on')
    annotation('textbox',[x(move) y(move)+0.06 .1 .1],'String',strBest,'FitBoxToText','on')
end