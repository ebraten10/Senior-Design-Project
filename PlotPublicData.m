%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This code was used to plot the derivative of the vertical and horizontal
%EOG signals from the public dataset found at
%https://www.um.edu.mt/cbc/ourprojects/EOG/EOGdataset. You must have the
%folder DATASET in the same folder as this m file for the code to run.

%This number can be 1,2,3,4,5 or 6 to see the data plotted from subject
%1,2,3,4,5 or 6
subjectnum = 1;

roothpath = sprintf('DATASET/S%d',subjectnum);
load(fullfile(roothpath,'EOG.mat'))
load(fullfile(roothpath,'ControlSignal.mat'))

C = ControlSignal;
H = EOG(1,:);
V = EOG(2,:);

dh = diff(H);
dv = diff(V);

subplot(2,1,1)
plot(dv)
hold on
plot(C)
title("Derivative of Vertical Signal")
xlabel("# Data Point")
ylabel("Amplitude (mV))")
legend({'EOG','Control Signal'})
subplot(2,1,2)
plot(dh)
hold on
plot(C)
title("Derivative of Horizontal Signal")
xlabel("# Data Point")
ylabel("Amplitude (mV))")
legend({'EOG','Control Signal'})