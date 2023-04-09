%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the FKWV letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function FKWV(fig)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    clf(fig)
    
    f = uiimage(fig);
    w = uiimage(fig);
    k = uiimage(fig);
    v = uiimage(fig);
    
    %FWKV
    f.ImageSource = 'Letters/f.png';
    f.Position = [900,890,125,125];
    w.ImageSource = 'Letters/w.png';
    w.Position = [480,465,125,125];
    k.ImageSource = 'Letters/k.png';
    k.Position = [1300,465,125,125];
    v.ImageSource = 'Letters/v.png';
    v.Position = [900,-1,125,125];
end

