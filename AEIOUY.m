%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the AEIOUY letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function AEIOUY(fig)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    clf(fig)

    a = uiimage(fig);
    e = uiimage(fig);
    i = uiimage(fig);
    o = uiimage(fig);
    u = uiimage(fig);
    y = uiimage(fig);
    
    %AEIOUY
    a.ImageSource = 'Letters/a.png';
    a.Position = [900,890,125,125];
    e.ImageSource = 'Letters/e.png';
    e.Position = [10,465,125,125];
    i.ImageSource = 'Letters/i.png';
    i.Position = [480,465,125,125];
    o.ImageSource = 'Letters/o.png';
    o.Position = [1300,465,125,125];
    u.ImageSource = 'Letters/u.png';
    u.Position = [1790,465,125,125];
    y.ImageSource = 'Letters/y.png';
    y.Position = [900,-1,125,125];
end

