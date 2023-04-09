%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function is used to find max/min votlage value of each eye movement
%in the recorded data. It takes an input string that indicates the
%direction of the eye movement, and outputs the max/min value and a cell
%array ACC that stores the voltage value and location of acutal peaks of
%each eye movement.

function [th,ACC] = FindMinAndMax(dir)
    tempTh=0;
    switch dir
        case "U"
            for s=1:10

                %These are the times in the DUB files at which an Up
                %movment occurs
                pktimes = [3,10,18,26,34,42,49,56,65,72];
                rootpath = sprintf('DUB%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end
                
                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;

                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(V_filtered(newTime(intv):min(newTime(intv+1),length(V_filtered))),time(newTime(intv):min(newTime(intv+1),length(V_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end 

                %Output the max/min eye movement voltage
                th = tempTh;
            end
        case "B"
            for s=1:10

                %These are the times in the DUB files at which an Up
                %movment occurs
                pktimes = [7,14,22,30,38,46,53,61,68,77];
                rootpath = sprintf('DUB%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end

                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;
    
                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(V_filtered(newTime(intv):min(newTime(intv+1),length(V_filtered))),time(newTime(intv):min(newTime(intv+1),length(V_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end 

                %Output the max/min eye movement voltage
                th = tempTh;
            end  
        case "D"
            for s=1:10

                %These are the times in the Down files at which an Up
                %movment occurs
                pktimes = [18,23,28.5,33.5,39,44.3,49.5,55,60,65];
                rootpath = sprintf('Down%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end

                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;

                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(-V_filtered(newTime(intv):min(newTime(intv+1),length(V_filtered))),time(newTime(intv):min(newTime(intv+1),length(V_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end 

                %Output the max/min eye movement voltage
                th = tempTh;
            end
        case "FR"
            for s=1:10

                %These are the times in the Right files at which an Up
                %movment occurs
                pktimes = [8.7,19.3,29.8,40.3,50.9,61.5,72,82.5,93,103.5];
                rootpath = sprintf('Right%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end

                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;

                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(H_filtered(newTime(intv):min(newTime(intv+1),length(H_filtered))),time(newTime(intv):min(newTime(intv+1),length(H_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end 

                %Output the max/min eye movement voltage
                th = tempTh;
            end
        case "NR"
            for s=1:10

                %These are the times in the Right files at which an Up
                %movment occurs
                pktimes = [13.8,24.5,35,45.6,56,66.5,77,87.4,98.4,108.6];
                rootpath = sprintf('Right%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end

                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;
               
                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(H_filtered(newTime(intv):min(newTime(intv+1),length(H_filtered))),time(newTime(intv):min(newTime(intv+1),length(H_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end

                %Output the max/min eye movement voltage
                th = tempTh;
            end
        case "FL"
            for s=1:10

                %These are the times in the Lefts files at which an Up
                %movment occurs
                pktimes = [8.8,19.2,29.5,40.5,51,61,72,82,92.9,103.6];
                rootpath = sprintf('Lefts%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end

                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;

                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(-H_filtered(newTime(intv):min(newTime(intv+1),length(H_filtered))),time(newTime(intv):min(newTime(intv+1),length(H_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end 

                %Output the max/min eye movement voltage
                th = tempTh;
            end
        case "NL"
            for s=1:10

                %These are the times in the Lefts files at which an Up
                %movment occurs
                pktimes = [13.8,24.5,35,45.6,56,66.5,77,87.4,98.4,108.6];
                rootpath = sprintf('Lefts%d',s);
                load(rootpath)
                n=1;
                new=zeros(1,2*length(pktimes));

                %A range of +/-1s is added to each time value to ensure all
                %movements are detected
                rng=1;

                %Create a vector new that has the intervals [pktime(i)-1,
                %pktime(i)+1]
                for i=1:length(pktimes)
                    new(n) = pktimes(i)-rng;
                    n=n+1;
                    new(n) = pktimes(i)+rng;
                    n=n+1;
                end

                %This is the average time difference between data points
                %(the frequency)
                avgT = mean(diff(time));

                %newTime is the vector that has the indices of the time 
                % intervals in new
                newTime = floor(new./avgT);
                j=1;

                %Search for the max/min peak in the positive veritcal
                %signal
                for intv=1:2:length(newTime)
                    [pks,lcs] = findpeaks(-H_filtered(newTime(intv):min(newTime(intv+1),length(H_filtered))),time(newTime(intv):min(newTime(intv+1),length(H_filtered))));
                    tempTh = max(max(pks),tempTh);
        
                    ACC{1,s}(j,1) = max(pks);
                    t1 = lcs(pks==max(pks));
                    ACC{1,s}(j,2) = find(time==t1);
                    j=j+1;
                end 

                %Output the max/min eye movement voltage
                th = tempTh;
            end
    end
end

            

