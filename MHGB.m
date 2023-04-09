%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the MHGB letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function MHGB(fig)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    clf(fig)

    m = uiimage(fig);
    h = uiimage(fig);
    g = uiimage(fig);
    b = uiimage(fig);
    
    m.ImageSource = 'Letters/m.png';
    m.Position = [900,890,125,125];
    h.ImageSource = 'Letters/h.png';
    h.Position = [480,465,125,125];
    g.ImageSource = 'Letters/g.png';
    g.Position = [1300,465,125,125];
    b.ImageSource = 'Letters/b.png';
    b.Position = [900,-1,125,125];
end

