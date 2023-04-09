%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function is used to highlight the letter classified by
%ThresholdAlgorithm(). It takes in several inputs and outputs the name of
%the image that is highlighted. You must have the folder Letters in the 
%same path as this m file for the code to run.

%Inputs:
%VorH: is 1 if the classified eye movement is a vertical movement, or 0 is
%the classified eye movement is a horizontal movement

%current: is the name of the PNG image file of the image that is currently
%highlighted

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

%f, f4, f6: are uifigures that house the letter menus
%f = Main Menu
%f4 = RSTN, LCPD, MHGB, FWKV
%f6 = AEIOUY, XJZQ

function [outputim] = Highlight(VorH,current,num,pkVal,thFR,thNR,thFL,thNL,thU,thD,f,f4,f6)
    %Unhighlight the currently highlighted letter
    current.Visible='off';

    %If the Main Menu is open, highlight on figure f
    if num==1
        fig=f;

    %If AEIOUY or XJZQ are open, highlight on figure f6
    elseif num==2 || num==3
        fig=f6;

    %If RSTN, LCPD, MHGB or FWKV are open, highlight on figure f4
    else
        fig=f4;
    end

    %fig must be a uifigure object
    set(fig, 'WindowState', 'maximized')
    aeiouyG = uiimage(fig);
    xjzqG = uiimage(fig);
    aG = uiimage(fig);
    yG = uiimage(fig);
    spG = uiimage(fig);
    bkG = uiimage(fig);
    rG = uiimage(fig);
    nG = uiimage(fig);
    lG = uiimage(fig);
    dG = uiimage(fig);
    mG = uiimage(fig);
    bG = uiimage(fig);
    fG = uiimage(fig);
    vG = uiimage(fig);
    %Horz Images
    rtsnG = uiimage(fig);
    lcpdG = uiimage(fig);
    mhgbG = uiimage(fig);
    fwkvG = uiimage(fig);
    wG = uiimage(fig);
    kG = uiimage(fig);
    cG = uiimage(fig);
    pG = uiimage(fig);
    eG = uiimage(fig);
    iG = uiimage(fig);
    oG = uiimage(fig);
    uG = uiimage(fig);
    jG = uiimage(fig);
    qG = uiimage(fig);
    zG = uiimage(fig);
    hG = uiimage(fig);
    gG = uiimage(fig);
    sG = uiimage(fig);
    tG = uiimage(fig);
    xG = uiimage(fig);
    
    
    %U
    UPosition = [900,890,125,125];
    aeiouyG.ImageSource = 'Letters/aeiouyGREEN.png';
    aeiouyG.Position = UPosition;
    aG.ImageSource = 'Letters/aGREEN.png';
    aG.Position = UPosition;
    spG.ImageSource = 'Letters/spGREEN.png';
    spG.Position = UPosition;
    rG.ImageSource = 'Letters/rGREEN.png';
    rG.Position = UPosition;
    lG.ImageSource = 'Letters/lGREEN.png';
    lG.Position = UPosition;
    mG.ImageSource = 'Letters/mGREEN.png';
    mG.Position = UPosition;
    fG.ImageSource = 'Letters/fGREEN.png';
    fG.Position = UPosition;
    %D
    DPosition = [900,-1,125,125];
    xjzqG.ImageSource = 'Letters/xjzqGREEN.png';
    xjzqG.Position = DPosition;
    yG.ImageSource = 'Letters/yGREEN.png';
    yG.Position = DPosition;
    bkG.ImageSource = 'Letters/bkGREEN.png';
    bkG.Position = DPosition;
    nG.ImageSource = 'Letters/nGREEN.png';
    nG.Position = DPosition;
    dG.ImageSource = 'Letters/dGREEN.png';
    dG.Position = DPosition;
    bG.ImageSource = 'Letters/bGREEN.png';
    bG.Position = DPosition;
    vG.ImageSource = 'Letters/vGREEN.png';
    vG.Position = DPosition;
    %FR
    FRPosition = [1790,465,125,125];
    fwkvG.ImageSource = 'Letters/fwkvGREEN.png';
    fwkvG.Position = FRPosition;
    qG.ImageSource = 'Letters/qGREEN.png';
    qG.Position = FRPosition;
    uG.ImageSource = 'Letters/uGREEN.png';
    uG.Position = FRPosition;
    %NR
    NRPosition = [1300,465,125,125];
    mhgbG.ImageSource = 'Letters/mhgbGREEN.png';
    mhgbG.Position = NRPosition;
    oG.ImageSource = 'Letters/oGREEN.png';
    oG.Position = NRPosition;
    zG.ImageSource = 'Letters/zGREEN.png';
    zG.Position = NRPosition;
    sG.ImageSource = 'Letters/sGREEN.png';
    sG.Position = NRPosition;
    pG.ImageSource = 'Letters/pGREEN.png';
    pG.Position = NRPosition;
    gG.ImageSource = 'Letters/gGREEN.png';
    gG.Position = NRPosition;
    kG.ImageSource = 'Letters/kGREEN.png';
    kG.Position = NRPosition;
    %FL
    FLPosition = [10,465,125,125];
    rtsnG.ImageSource = 'Letters/rtsnGREEN.png';
    rtsnG.Position = FLPosition;
    eG.ImageSource = 'Letters/eGREEN.png';
    eG.Position = FLPosition;
    xG.ImageSource = 'Letters/xGREEN.png';
    xG.Position = FLPosition;
    %NL
    NLPosition = [480,465,125,125];
    lcpdG.ImageSource = 'Letters/lcpdGREEN.png';
    lcpdG.Position = NLPosition;
    iG.ImageSource = 'Letters/iGREEN.png';
    iG.Position = NLPosition;
    jG.ImageSource = 'Letters/jGREEN.png';
    jG.Position = NLPosition;
    tG.ImageSource = 'Letters/tGREEN.png';
    tG.Position = NLPosition;
    hG.ImageSource = 'Letters/hGREEN.png';
    hG.Position = NLPosition;
    cG.ImageSource = 'Letters/cGREEN.png';
    cG.Position = NLPosition;
    wG.ImageSource = 'Letters/wGREEN.png';
    wG.Position = NLPosition;
    
    %Do not show any of the highlighted images that were just created
    ims = [aeiouyG,xjzqG,aG,yG,bkG,spG,lG,dG,rG,nG,mG,bG,fG,vG,fwkvG,qG,uG,mhgbG,oG,zG,sG,pG,gG,kG,rtsnG,eG,xG,lcpdG,iG,jG,tG,hG,cG,wG];
    arrayfun(@NotVisible,ims)
    
    %If it is a horizontal movement, show the highlighted image
    %corresponding to the currently open menu
    if VorH==0
        if num==1
            if pkVal > thFR
                fwkvG.Visible='on';
                outputim=fwkvG;
            elseif pkVal > thNR
                mhgbG.Visible='on';
                outputim=mhgbG;
            elseif pkVal < thFL
                rtsnG.Visible='on';
                outputim=rtsnG;
            elseif pkVal < thNL
                lcpdG.Visible='on';
                outputim=lcpdG;
            end
        elseif num==2
            if pkVal > thFR
                oG.Visible='on';
                outputim=uG;
            elseif pkVal > thNR
                uG.Visible='on';
                outputim=oG;
            elseif pkVal < thFL
                eG.Visible='on';
                outputim=eG;
            elseif pkVal < thNL
                iG.Visible='on';
                outputim=iG;
            end
        elseif num==3
            if pkVal > thFR
                qG.Visible='on';
                outputim=qG;
            elseif pkVal > thNR
                jG.Visible='on';
                outputim=jG;
            elseif pkVal < thFL
                xG.Visible='on';
                outputim=iG;
            elseif pkVal < thNL
                zG.Visible='on';
                outputim=zG;
            end
        elseif num==4
            if pkVal > thNR
                pG.Visible='on';
                outputim=zG;
            elseif pkVal < thNL
                cG.Visible='on';
                outputim=cG;
            end
        elseif num==5
            if pkVal > thNR
                sG.Visible='on';
                outputim=sG;
            elseif pkVal < thNL
                tG.Visible='on';
                outputim=tG;
            end
        elseif num==6
            if pkVal > thNR
                gG.Visible='on';
                outputim=gG;
            elseif pkVal < thNL
                hG.Visible='on';
                outputim=hG;
            end
         elseif num==7
            if pkVal > thNR
                kG.Visible='on';
                outputim=kG;
            elseif pkVal < thNL
                wG.Visible='on';
                outputim=wG;
            end
        end
    
    %If it is a vertical movement, show the highlighted image
    %corresponding to the currently open menu
    elseif VorH==1
        if num==1
            if pkVal > thU
                aeiouyG.Visible='on';
                outputim=aeiouyG;
            elseif pkVal < thD
                xjzqG.Visible='on';
                outputim=xjzqG;
            end
        elseif num==2
            if pkVal > thU
                aG.Visible='on';
                outputim=aG;
            elseif pkVal < thD
                yG.Visible='on';
                outputim=yG;
            end
        elseif num==3
            if pkVal > thU
                spG.Visible='on';
                outputim=spG;
            elseif pkVal < thD
                bkG.Visible='on';
                outputim=bkG;
            end
        elseif num==4
            if pkVal > thU
                lG.Visible='on';
                outputim=lG;
            elseif pkVal < thD
                dG.Visible='on';
                outputim=dG;
            end      
        elseif num==5
            if pkVal > thU
                rG.Visible='on';
                outputim=rG;
            elseif pkVal < thD
                nG.Visible='on';
                outputim=nG;
            end
        elseif num==6
            if pkVal > thU
                mG.Visible='on';
                outputim=mG;
            elseif pkVal < thD
                bG.Visible='on';
                outputim=bG;
            end
         elseif num==7
            if pkVal > thU
                fG.Visible='on';
                outputim=fG;
            elseif pkVal < thD
                vG.Visible='on';
                outputim=vG;
            end
        end
    end
end

