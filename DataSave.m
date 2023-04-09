%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: David Zalzohin

%This code was used to plot and save data recorded from the EOG electrodes.

clc
clear
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%Arduino connection
a = arduino(); 

%Interval of running time
interv = 1900; 
init = 1;

count=0;
time=0;

%Set up vertical and horizontal channels
vertical=0;
horizontal=0;
V_filtered=0;
H_filtered=0;

plotGrid = 'on';

%Vertical and horizontal plots of raw and filtered data against time
subplot(4,1,1)
plotGraph1 = plot(time,vertical,'-b');
title('Raw Vertical')
xlabel('Time(s)')
ylabel('Amplitude(mV)')

subplot(4,1,2)
plotGraph3 = plot(time,V_filtered,'-b' );
title('Smoothed Vertical')
xlabel('Time(s)')
ylabel('Amplitude(mV)')
ylim([-3 3])

subplot(4,1,3)
plotGraph2 = plot(time,horizontal,'-b' );
title('Raw Horizontal')
xlabel('Time(s)')
ylabel('Amplitude(mV)')

subplot(4,1,4)
plotGraph4 = plot(time,H_filtered,'-b' );
title('Smoothed Horizontal')
xlabel('Time(s)')
ylabel('Amplitude(mV)')

pause(7)
tic

%Continuously reads and plots data points until the interval is complete
while (init<interv)
    %Rad data from the arduino for both channels
    vert = readVoltage(a, 'A0')-1.2;
    horz = readVoltage(a, 'A1')-1.8;
    
    count = count + 1;    
    time(count) = toc;
    
    vertical(count) = vert(1);
    horizontal(count) = horz(1);
    
    %Apply filtering method using movmean with a 10 data point window
    mV = movmean(vertical, 10);
    mH = movmean(horizontal, 10);
    
    %Second step of filtering using smooth function to eliminate noise
    V_filtered = smooth(mV);
    H_filtered = smooth(mH);
    
    %Plot raw and filtered signals as they are being read from Arduino
    set(plotGraph1,'XData',time,'YData',vertical);
    set(plotGraph2,'XData',time,'YData',horizontal);
    set(plotGraph3,'XData',time,'YData',V_filtered);
    set(plotGraph4,'XData',time,'YData',H_filtered);
    
    init = init+1;
end

%Uncomment this link to save data in a .mat file
 %save('Blink_10_2.mat', 'vertical', 'horizontal', 'V_filtered', 'H_filtered','time')