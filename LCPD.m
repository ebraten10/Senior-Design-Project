%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the LCPD letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function LCPD(fig)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    clf(fig)
    
    l = uiimage(fig);
    c = uiimage(fig);
    p = uiimage(fig);
    d = uiimage(fig);
    
    %LCPD
    l.ImageSource = 'Letters/l.png';
    l.Position = [900,890,125,125];
    c.ImageSource = 'Letters/c.png';
    c.Position = [480,465,125,125];
    p.ImageSource = 'Letters/p.png';
    p.Position = [1300,465,125,125];
    d.ImageSource = 'Letters/d.png';
    d.Position = [900,-1,125,125];
end

