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
%thU = threshold value for up movements
%thD = threshold value for down movements

%edtVal: is the current string that has been written by the user that will
%be displayed in the textbox

%f, f4, f6: are uifigures that house the letter menus
%f = Main Menu
%f4 = RSTN, LCPD, MHGB, FWKV
%f6 = AEIOUY, XJZQ
function [txt,opValue] = OpenVert(num,pkVal,thU,thD,edtVal,f,f4,f6)
    %If the Main Menu is open, open the submenu determined by the peak
    %voltage value and do not add any characters to the string in the
    %textbox
    if num==1
        f.Visible='off';
        f4.Visible='off';
        f6.Visible='on';
        set(f6, 'WindowState', 'maximized')
        if pkVal > thU
            opValue=2;
            pause(0.5)
            AEIOUY(f6);
            txt=edtVal;
        elseif pkVal < thD
            opValue=3;
            pause(0.5)
            XJZQ(f6);
            txt=edtVal;
        end
    %If the AEIOUY menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==2
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thU
            txt=edtVal+"A";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thD
            txt=edtVal+"Y";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the XJZQ menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==3
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thU
            txt=edtVal+" ";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thD
            txt=edtVal(1:end-1);
            opValue=1;
            MainMenu(f,txt);
        end
    %If the LCPD menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==4
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thU
            txt=edtVal+"L";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thD
            txt=edtVal+"D";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the RSTN menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==5
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thU
            txt=edtVal+"R";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thD
            txt=edtVal+"N";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the MGHB menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==6
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thU
            txt=edtVal+"M";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thD
            txt=edtVal+"B";
            opValue=1;
            MainMenu(f,txt);
        end
    %If the FWKV menu is open, open the Main Menu and display the
    %character classified by ThresholdAlgorithm()
    elseif num==7
        f.Visible='on';
        f4.Visible='off';
        f6.Visible='off';
        if pkVal > thU
            txt=edtVal+"F";
            opValue=1;
            MainMenu(f,txt);
        elseif pkVal < thD
            txt=edtVal+"V";
            opValue=1;
            MainMenu(f,txt);
        end
    end
end

