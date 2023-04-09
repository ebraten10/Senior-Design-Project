%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function is used to open the menu corresponding to a horizontal
%movement detected in ThresholdAlgorithm(). It takes several inputs and
%outputs the new value of the string (txt) in the textbox on the Main Menu as
%well as the value corresponding to the menu that was just opened (opValue).

%Inputs:
%num: is a value that indicates which menu is currently open
%1 = Main Menu
%2 = AEIOUY
%3 = XJZQ
%4 = RSTN
%5 = LCPD
%6 = MHGB
%7 = FWKV

%pkVal: is the value of the peak that is being analyzed. It is compared to
%one of the 7 thresholds depending on which menu is open. 

%Thresold values:
%thFR = threshold value for far right movements
%thNR = threshold value for near right movements
%thFL = threshold value for far left movements
%thNL = threshold value for near left movements

%edtVal: is the current string that has been written by the user that will
%be displayed in the textbox

%f, f4, f6: are uifigures that house the letter menus
%f = Main Menu
%f4 = RSTN, LCPD, MHGB, FWKV
%f6 = AEIOUY, XJZQ
function [txt,opValue] = OpenHorz(num,pkVal,thFR,thNR,thFL,thNL,edtVal,f,f4,f6)
    %If the Main Menu is open, open the submenu determined by the peak
    %voltage value and do not add any characters to the string in the
    %textbox
    if num==1
        f.Visible='off';
        f4.Visible='on';
        set(f4, 'WindowState', 'maximized')
        f6.Visible='off';
        if pkVal > thFR
            opValue=7;
            pause(0.5)
            FKWV(f4)
            txt=edtVal;
        elseif pkVal > thNR
            opValue=6;
            pause(0.5)
            MHGB(f4)
            txt=edtVal;
        elseif pkVal < thFL
            opValue=5;
            pause(0.5)
            RSTN(f4);
            txt=edtVal; 
        elseif pkVal < thNL
            opValue=4;
            pause(0.5)
            LCPD(f4)
            txt=edtVal;
        end
    %If the AEIOUY menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==2
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thFR
            txt=edtVal+"O";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal > thNR
            txt=edtVal+"U";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thFL
            txt=edtVal+"E";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thNL
            txt=edtVal+"I";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the XJZQ menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==3
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thFR
            txt=edtVal+"Q";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal > thNR
            txt=edtVal+"Z";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thFL
            txt=edtVal+"X";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thNL
            txt=edtVal+"J";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the LCPD menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()    
    elseif num==4
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thNR
            txt=edtVal+"P";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thNL
            txt=edtVal+"C";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the RSTN menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==5
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thNR
            txt=edtVal+"S";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thNL
            txt=edtVal+"T";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the MGHB menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==6
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thNR
            txt=edtVal+"G";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thNL
            txt=edtVal+"H";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the FWKV menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
     elseif num==7
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thNR
            txt=edtVal+"K";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thNL
            txt=edtVal+"W";
            opValue=1;
            MainMenu(f,txt);
        end
    end
end

