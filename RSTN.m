%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the RSTN letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function RSTN(fig)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    clf(fig)
    
    r = uiimage(fig);
    s = uiimage(fig);
    t = uiimage(fig);
    n = uiimage(fig);
    
    r.ImageSource = 'Letters/r.png';
    r.Position = [900,890,125,125];
    s.ImageSource = 'Letters/s.png';
    s.Position = [1300,465,125,125];
    t.ImageSource = 'Letters/t.png';
    t.Position = [480,465,125,125];
    n.ImageSource = 'Letters/n.png';
    n.Position = [900,-1,125,125];
end

