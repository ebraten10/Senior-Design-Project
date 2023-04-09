function TrainingGUI()
     f = uifigure;

    set(f, 'WindowState', 'maximized')
    
    %Regular images
    aeiouy = uiimage(f);
    rtsn = uiimage(f);
    lcpd = uiimage(f);
    mhgb = uiimage(f);
    fwkv = uiimage(f);
    xjzq = uiimage(f);
    red = uiimage(f);

    %Regular boxes
    aeiouy.ImageSource = 'Letters/aeiouy.png';
    aeiouy.Position = [900,930,125,125];
    
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

    red.ImageSource = 'Letters/reddot.png';
    red.Position = [900,465,125,125];

    %Green images
    aeiouyG = uiimage(f);
    rtsnG = uiimage(f);
    lcpdG = uiimage(f);
    mhgbG = uiimage(f);
    fwkvG = uiimage(f);
    xjzqG = uiimage(f);
    blue = uiimage(f);
    green = uiimage(f);
    
    %Green highlights
    aeiouyG.ImageSource = 'Letters/aeiouyGREEN.png';
    aeiouyG.Position = [900,930,125,125];
    
    rtsnG.ImageSource = 'Letters/rtsnGREEN.png';
    rtsnG.Position = [10,465,125,125];
    
    lcpdG.ImageSource = 'Letters/lcpdGREEN.png';
    lcpdG.Position = [480,465,125,125];
    
    mhgbG.ImageSource = 'Letters/mhgbGREEN.png';
    mhgbG.Position = [1300,465,125,125];
    
    fwkvG.ImageSource = 'Letters/fwkvGREEN.png';
    fwkvG.Position = [1790,465,125,125];
    
    xjzqG.ImageSource = 'Letters/xjzqGREEN.png';
    xjzqG.Position = [900,0,125,125];

    blue.ImageSource = 'Letters/bluedot.png';
    blue.Position = [900,465,125,125];

    green.ImageSource = 'Letters/greendot.png';
    green.Position = [900,465,125,125];

    NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
    pause(5)
    for i=1:5
%         pause(3)
%         green.Visible='on';
%     
        %Look at vowels
%         pause(0.5)
%         aeiouyG.Visible='on';
%         pause(0.75);
%         NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
        
% %         %Look at RTSN
        pause(4)
        green.Visible='on';
        pause(0.5)
        rtsnG.Visible='on';
        pause(0.75);
        NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
%     
% %         %Look at LCPD
%         pause(3)
%         green.Visible='on';
%         pause(0.5)
%         lcpdG.Visible='on';
%         pause(0.75);
%         NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
%     
% %         %Look at FWKV
        pause(4)
        green.Visible='on';
        pause(0.5)
        fwkvG.Visible='on';
        pause(0.75);
        NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
% %     
% %         %Look at MHGB
%         pause(3)
%         green.Visible='on';
%         pause(0.5)
%         mhgbG.Visible='on';
%         pause(0.75);
%         NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
%     
        %Look at XJZQ
%         pause(3)
%         green.Visible='on';
%         pause(0.5)
%         xjzqG.Visible='on';
%         pause(0.75);
%         NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
    
        %Blink
%         pause(3)
%         blue.Visible='on';
%         pause(0.5);
%         NotVisible(aeiouyG,rtsnG,lcpdG,mhgbG,fwkvG,xjzqG,blue,green);
    end  
end