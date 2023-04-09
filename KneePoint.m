%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to find the best threshold value for a given
%movement. It takes the TPR and FPR values from PublicROCperMovement() and
%outputs the best threshold value. The best value is found by finding the
%point in the ROC curve closest to the top left corner.

function [threshold] = KneePoint(TPR,FPR,numz,th)
    d=inf(1,101);
    for x=1:length(d)
        X = [0,1;FPR(x),TPR(x)];
        d(x)=pdist(X);
    end
    %Find the point with the smallest distance to the top left corner
    final=min(d);

    %Find the index of the point "final". Multiply the value of numz at
    %the same index by the threshold of the movement given to get the best
    %value
    finalindx=find(d==final,1,'last');
    threshold=th*numz(finalindx);
end