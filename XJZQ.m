%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the XJZQ letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function XJZQ(fig)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    clf(fig)

    j = uiimage(fig);
    q = uiimage(fig);
    x = uiimage(fig);
    z = uiimage(fig);
    sp = uiimage(fig);
    bk = uiimage(fig);
    
    j.ImageSource = 'Letters/j.png';
    j.Position = [480,465,125,125];
    q.ImageSource = 'Letters/q.png';
    q.Position = [1790,465,125,125];
    x.ImageSource = 'Letters/x.png';
    x.Position = [10,465,125,125];
    z.ImageSource = 'Letters/z.png';
    z.Position = [1300,465,125,125];
    sp.ImageSource = 'Letters/sp.png';
    sp.Position = [900,890,125,125];
    bk.ImageSource = 'Letters/bk.png';
    bk.Position = [900,-1,125,125];
end

