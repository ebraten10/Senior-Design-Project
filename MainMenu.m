%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to create the Main Menu letter menu to be used with
%the thresolding algorithm. You must have the folder Letters in the same
%path as this m file for the code to run.

function MainMenu(fig,edtVal)
    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    fig.Visible='on';

    
    edt = uieditfield(fig, 'text');
    set(edt,'FontSize',35)
    aeiouy = uiimage(fig);
    rtsn = uiimage(fig);
    lcpd = uiimage(fig);
    mhgb = uiimage(fig);
    fwkv = uiimage(fig);
    xjzq = uiimage(fig);

    
    edt.Position = [800,500,320,75];
    edt.Value = edtVal;
    aeiouy.ImageSource = 'Letters/aeiouy.png';
    aeiouy.Position = [900,890,125,125];
    rtsn.ImageSource = 'Letters/rtsn.png';
    rtsn.Position = [10,465,125,125];
    lcpd.ImageSource = 'Letters/lcpd.png';
    lcpd.Position = [480,465,125,125];
    mhgb.ImageSource = 'Letters/mhgb.png';
    mhgb.Position = [1300,465,125,125];
    fwkv.ImageSource = 'Letters/fwkv.png';
    fwkv.Position = [1790,465,125,125];
    xjzq.ImageSource = 'Letters/xjzq.png';
    xjzq.Position = [900,-1,125,125];
end
