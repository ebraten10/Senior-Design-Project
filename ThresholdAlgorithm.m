%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten and David Zalozhin

%This code implements the final classification algorithm of the EOG
%signals. You must have the following m files and folders in the same path
%as this m file for the code to run: MainMenu, AEIOUY, XJZQ, RSTN, LCPD,
%MHGB, FWKV, OpenHorz, OpenVert, Highlight, Letters.

clc
clear
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

a = arduino();

interv = 10000;
init = 1;
count=0;
time=0;
timespace=0;

%Initialize the vectors to be created from data points received from the
%Arduino
vertical=0;
horizontal=0;
V_filtered=0;
H_filtered=0;

%Start searching for peaks after 100 data points have been received
startpt=100;

%Initialize the matrices that will store detected peak values and
%locations
PkLocH = zeros(1,2);
PkLocV = zeros(1,2);

%Initialize the number of peaks detected in each EOG signal to 1
countH=1;
countV=1;

%Open: number corresponding to the menu that is currently open
%1 = main
%2 = aeiouy
%3 = xjzq
%4 = lcpd
%5 = rstn
%6 = mhgb
%7 = fwkv
open=1;

%Initialize the output string
edtVal="";

%Initialize all uifigures
background=uifigure;
set(background, 'WindowState', 'maximized')
f6=uifigure;
f4=uifigure;
f=uifigure;

%Start the spelling session with the Main Menu open first
MainMenu(f,edtVal);

%Subject specific threshold values
thFR = 0.7502;
thNR = 0.5;
thFL = -0.6579;
thNL = -0.4160;
thU = 0.4007;
thD = -0.6005;
thB = 1.2;

%Set the the first current image to be a random image to be used once. The
%current image is need for input to Highlight()
im.ImageSource = 'Letters/blank.png';
im.Position = [5 5 5 5];
im.Visible='off';

pause(7)

while (init<interv)
    %Read the data points sent from teh Arduino
    vert = readVoltage(a, 'A0')-1.8;
    horz = readVoltage(a, 'A1')-2.2;
    
    count = count + 1;    
    
    %Add each new point to horz and vert
    vertical(count) = vert(1);
    horizontal(count) = horz(1);
    
    %Use movmean and smooth to get the final vectors of data to be searched
    %for peaks
    mV = movmean(vertical, 10);
    mH = movmean(horizontal, 10);
    V_filtered = smooth(mV);
    H_filtered = smooth(mH);
    
    if count-startpt >= 48
        %Find peaks that pass each of the thresholds
        [pksB,lcsB] = findpeaks(V_filtered(startpt:count),startpt:count,'MinPeakHeight',thB);
        [pksFR,lcsFR] = findpeaks(H_filtered(startpt:count),startpt:count,'MinPeakHeight',thFR);
        [pksNR,lcsNR] = findpeaks(H_filtered(startpt:count),startpt:count,'MinPeakHeight',thNR);
        [NRindx,~] = setdiff(lcsNR,lcsFR,'stable');
        [pksFL,lcsFL] = findpeaks(-H_filtered(startpt:count),startpt:count,'MinPeakHeight',-thFL);
        [pksNL,lcsNL] = findpeaks(-H_filtered(startpt:count),startpt:count,'MinPeakHeight',-thNL);
        [NLindx,~] = setdiff(lcsNL,lcsFL,'stable');
        [pksU,lcsU] = findpeaks(V_filtered(startpt:count),startpt:count,'MinPeakHeight',thU);
        [vindx,~] = setdiff(lcsU,lcsB,'stable');
        [pksD,lcsD] = findpeaks(-V_filtered(startpt:count),startpt:count,'MinPeakHeight',-thD);
        
        pFR = length(pksFR);
        pNR = length(NRindx);
        pFL = length(pksFL);
        pNL = length(NLindx);
        pV = length(vindx);
        NpV = length(pksD);
      
        %If a blink was found
        if ~isempty(lcsB)
            %If it is the first blink, do not process any other movements
            %found, and start the next searching interval at the 
            % x-location of the blink peak
            if startpt == 100
                startpt = lcsB(end);
                PkLocH = zeros(1,2);
                PkLocV = zeros(1,2);
                countH = 1;
                countV = 1;
            %If a horizontal movement is the last movement detected before
            %a blink, open the corresponding menu and start the next
            %searching interval at the x-location of the blink
            elseif PkLocH(end,2) > PkLocV(end,2) && lcsB(end)>PkLocH(end,2)
                [edtVal,opValue] = OpenHorz(open,PkLocH(end,1),thFR,thNR,thFL,thNL,edtVal,f,f4,f6);
                pause(2)
                open = opValue;
                startpt = lcsB(end);
                PkLocH = zeros(1,2);
                countH = 1;
            %If a vertical movement is the last movement detected before
            %a blink, open the corresponding menu and start the next
            %searching interval at the x-location of the blink
            elseif PkLocV(end,2) > PkLocH(end,2) && lcsB(end)>PkLocV(end,2)
                [edtVal,opValue] = OpenVert(open,PkLocV(end,1),thU,thD,edtVal,f,f4,f6);
                pause(2)
                open = opValue;
                startpt = lcsB(end);
                PkLocV = zeros(1,2);
                countV = 1;
            %If no saccades were detected between this blink and the
            %previous blink, start the next searching interval at the
            %x-location of the last blink detected
            else
                startpt = lcsB(end);
            end
        else
            %If a Far Left movement is detected and at least 100 data
            %points have been collected:
            if pFL > 0 && startpt~=100
                for r = 1:length(pFL)
                    %Check if the peak has been detected before and if its
                    %location is at least 36 data points after the last
                    %saccade detected
                    if ~ismember([-pksFL(r),lcsFL(r)], PkLocH,'rows')  && lcsFL(r)>timespace+36
                        PkLocH(countH,1) = -pksFL(r);
                        PkLocH(countH,2) = lcsFL(r);
                        timespace = lcsFL(r);
                        countH = countH + 1;
                        im = Highlight(0,im,open,-pksFL(r),thFR,thNR,thFL,thNL,thU,thD,f,f4,f6);

                    end
                end
            end
            %If a Near Left movement is detected and at least 100 data
            %points have been collected:
            if pNL > 0 && startpt~=100 
                for n = 1:length(NLindx)
                    %Check if the peak has been detected before and if its
                    %location is at least 36 data points after the last
                    %saccade detected
                    if ~ismember([H_filtered(NLindx(n)),NLindx(n)], PkLocH,'rows') && NLindx(n)>timespace+36
                        PkLocH(countH,1) = H_filtered(NLindx(n));
                        PkLocH(countH,2) = NLindx(n);
                        timespace=NLindx(n);
                        countH = countH + 1;
                        pause(0.5)
                        im = Highlight(0,im,open,H_filtered(NLindx(n)),thFR,thNR,thFL,thNL,thU,thD,f,f4,f6);
                    end
                end
            end
            %If a Far Right movement is detected and at least 100 data
            %points have been collected:
            if pFR > 0 && startpt~=100
                for j = 1:length(pFR)
                    %Check if the peak has been detected before and if its
                    %location is at least 36 data points after the last
                    %saccade detected
                    if ~ismember([pksFR(j),lcsFR(j)], PkLocH,'rows') && lcsFR(j)>timespace+36
                        PkLocH(countH,1) = pksFR(j);
                        PkLocH(countH,2) = lcsFR(j);
                        timespace = lcsFR(j);
                        countH = countH + 1;
                        pause(0.5)
                        im = Highlight(0,im,open,pksFR(j),thFR,thNR,thFL,thNL,thU,thD,f,f4,f6);
                    end
                end
            end
            %If a Near Right movement is detected and at least 100 data
            %points have been collected:
            if pNR > 0 && startpt~=100
                for m = 1:length(NRindx)
                    %Check if the peak has been detected before and if its
                    %location is at least 36 data points after the last
                    %saccade detected
                    if ~ismember([H_filtered(NRindx(m)),NRindx(m)], PkLocH,'rows') && NRindx(m)>timespace+36
                        PkLocH(countH,1) = H_filtered(NRindx(m));
                        PkLocH(countH,2) = NRindx(m);
                        timespace = NRindx(m);
                        countH = countH + 1;
                        pause(0.5)
                        im = Highlight(0,im,open,H_filtered(NRindx(m)),thFR,thNR,thFL,thNL,thU,thD,f,f4,f6);
                    end
                end
            end
            %If an Up movement is detected and at least 100 data
            %points have been collected:
            if pV > 0 && startpt~=100
                for k = 1:length(vindx)
                    %Check if the peak has been detected before and if its
                    %location is at least 36 data points after the last
                    %saccade detected
                    if ~ismember([V_filtered(vindx(k)),vindx(k)], PkLocV,'rows') && vindx(k)>timespace+36
                        PkLocV(countV,1) = V_filtered(vindx(k));
                        PkLocV(countV,2) = vindx(k);
                        timespace = vindx(k);
                        countV = countV + 1;
                        pause(0.5)
                        im = Highlight(1,im,open,V_filtered(vindx(k)),thFR,thNR,thFL,thNL,thU,thD,f,f4,f6);
                    end
                end
            end
            %If a Down movement is detected and at least 100 data
            %points have been collected:
            if NpV > 0 && startpt~=100
                for q = 1:length(NpV)
                    %Check if the peak has been detected before and if its
                    %location is at least 36 data points after the last
                    %saccade detected
                    if ~ismember([-pksD(q),lcsD(q)], PkLocV,'rows') && lcsD(q)>timespace+36
                        PkLocV(countV,1) = -pksD(q);
                        PkLocV(countV,2) = lcsD(q);
                        timespace=lcsD(q);
                        countV = countV + 1;
                        pause(0.5)
                        im = Highlight(1,im,open,-pksD(q),thFR,thNR,thFL,thNL,thU,thD,f,f4,f6);
                    end
                end
            end
        end
    end
    init = init+1;
end