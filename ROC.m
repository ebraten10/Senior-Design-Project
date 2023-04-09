%EOG-Based Communication System for Patients with Locked-in Sydrome
%Senior Design 2021-2022
%Author: Emma Braten

%This function was used to find the best threshold value for a given
%movement. It takes the TPR and FPR values from PublicROCperMovement() and
%outputs the best threshold value. You must have the 10 data files for each
%eye movement in the same path as this m file for the code to run.

function [TPR,FPR,best,AUC] = ROC(dir)
    numz=0:0.01:1;
    switch dir
        case "U"
            %Find the max voltage of an Up movement and the locations where
            %an actual Up movement occurred
            [thV,ACCV] = FindMinAndMax("U");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz
                %U has a 1 at indices of locations that correspond to a
                %true Up movement (first row in each cell) and predicted Up
                %movement (second row in each cell)
                U = cell(1,10);
                for s=1:10
                    rootpath = sprintf('DUB%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as Up
                    %movements (peaks with value from 0 to thV)
                    [~,lc0] = findpeaks(V_filtered,'MinPeakHeight',0);
                    [~,lcV0] = findpeaks(V_filtered,'MinPeakHeight',thV);
                    [ind0,~] = setdiff(lc0,lcV0);
                    Pos{1,s} = ind0;
                    U{1,s} = zeros(2,length(ind0));

                    %Find predicted peaks at the threshold thV*mult
                    [~,lc] = findpeaks(V_filtered,'MinPeakHeight',thV*mult);
                    [~,lcV] = findpeaks(V_filtered,'MinPeakHeight',thV);
                    [ind,~] = setdiff(lc,lcV);

                    %Save a 1 in U{1,s}(1,:) at indices corresponding to an
                    %actual Up movement
                    for ac=1:10
                        U{1,s}(1,find(ACCV{1,s}(ac,2)==Pos{1,s}')) = 1; %#ok<*FNDSB> 
                    end
                    
                    %Save a 1 in U{1,s}(2,:) at indices corresponding to a
                    %predicted Up movement
                    for u=1:length(ind)
                        U{1,s}(2,find(ind(u)==Pos{1,s})) = 1;
                    end
                end

                %Concatenate all cells in U
                Ufinal = cell2mat(U);

                %Find the tpr and fpr value for the threshold value
                %thV*mult and save to TPR and FPR
                [tpr,fpr] = roc(Ufinal(1,:),Ufinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thV);
            AUC = trapz(flip(FPR),flip(TPR));
        
            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Up ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)
        case "B"
            %Find the max voltage of an Blink movement and the locations where
            %an actual Blink movement occurred
            [thB,ACCB] = FindMinAndMax("B");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz

                %B has a 1 at indices of locations that correspond to a
                %true Blink movement (first row in each cell) and predicted
                %Blink movement (second row in each cell)
                B = cell(1,10);
                for s=1:10
                    rootpath = sprintf('DUB%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as
                    %Blink movements (peaks with value from 0 to thB)
                    [~,lc0] = findpeaks(V_filtered,'MinPeakHeight',0);
                    Pos{1,s} = lc0;
                    B{1,s} = zeros(2,length(lc0));

                    %Find predicted peaks at the threshold thB*mult
                    [~,lcB] = findpeaks(V_filtered,'MinPeakHeight',thB*mult);

                    %Save a 1 in B{1,s}(1,:) at indices corresponding to an
                    %actual Blink movement
                    for ac=1:10
                        B{1,s}(1,find(ACCB{1,s}(ac,2)==Pos{1,s}')) = 1;
                    end
                    
                    %Save a 1 in B{1,s}(2,:) at indices corresponding to an
                    %predicted Blink movement
                    for b=1:length(lcB)
                        B{1,s}(2,find(lcB(b)==Pos{1,s})) = 1;
                    end
                end
                
                %Concatenate all cells in B
                Bfinal = cell2mat(B);

                %Find the tpr and fpr value for the threshold value
                %thB*mult and save to TPR and FPR
                [tpr,fpr] = roc(Bfinal(1,:),Bfinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thB);
            AUC = trapz(flip(FPR),flip(TPR));

            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Blink ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)
            
        case "D"
            %Find the min voltage of an Down movement and the locations where
            %an actual Down movement occurred
            [thD,ACCD] = FindMinAndMax("D");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz

                %D has a 1 at indices of locations that correspond to a
                %true Down movement (first row in each cell) and predicted 
                %Down movement (second row in each cell)
                D = cell(1,10);
                for s=1:10
                    rootpath = sprintf('Down%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as
                    %Down movements (peaks with value from 0 to thD)
                    [~,lc0] = findpeaks(-V_filtered,'MinPeakHeight',0);
                    Pos{1,s} = lc0;
                    D{1,s} = zeros(2,length(lc0));

                    %Find predicted peaks at the threshold thD*mult
                    [~,lcD] = findpeaks(-V_filtered,'MinPeakHeight',thD*mult);

                    %Save a 1 in D{1,s}(1,:) at indices corresponding to an
                    %actual Down movement
                    for ac=1:10
                        D{1,s}(1,find(ACCD{1,s}(ac,2)==Pos{1,s}')) = 1;
                    end
                    
                    %Save a 1 in D{1,s}(2,:) at indices corresponding to an
                    %predicted Down movement
                    for dd=1:length(lcD)
                        D{1,s}(2,find(lcD(dd)==Pos{1,s})) = 1;
                    end
                end

                %Concatenate all cells in D
                Dfinal = cell2mat(D);

                %Find the tpr and fpr value for the threshold value
                %thD*mult and save to TPR and FPR
                [tpr,fpr] = roc(Dfinal(1,:),Dfinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thD);
            AUC = trapz(flip(FPR),flip(TPR));
            
            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Down ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)

        case "FR"
            %Find the max voltage of an Far Right movement and the locations where
            %an actual Far Right movement occurred
            [thFR,ACCFR] = FindMinAndMax("FR");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz

                %FR has a 1 at indices of locations that correspond to a
                %true Far Right movement (first row in each cell) and
                %predicted Far Right movement (second row in each cell)
                FR = cell(1,10);
                for s=1:10
                    rootpath = sprintf('Right%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as
                    %Far Right movements (peaks with value from 0 to thFR)
                    [~,lc0] = findpeaks(H_filtered,'MinPeakHeight',0);
                    Pos{1,s} = lc0;
                    FR{1,s} = zeros(2,length(lc0));

                    %Find predicted peaks at the threshold thFR*mult
                    [~,lcFR] = findpeaks(H_filtered,'MinPeakHeight',thFR*mult);

                    %Save a 1 in FR{1,s}(1,:) at indices corresponding to an
                    %actual Far Right movement
                    for ac=1:10
                        FR{1,s}(1,find(ACCFR{1,s}(ac,2)==Pos{1,s}')) = 1;
                    end
                    
                    %Save a 1 in FR{1,s}(2,:) at indices corresponding to an
                    %predicted Far Right movement
                    for fr=1:length(lcFR)
                        FR{1,s}(2,find(lcFR(fr)==Pos{1,s})) = 1;
                    end
                end

                %Concatenate all cells in FR
                FRfinal = cell2mat(FR);

                %Find the tpr and fpr value for the threshold value
                %thFR*mult and save to TPR and FPR
                [tpr,fpr] = roc(FRfinal(1,:),FRfinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thFR);
            AUC = trapz(flip(FPR),flip(TPR));

            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Far Right ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)
            
        case "NR"
            %Find the max voltage of an Near Right movement and the locations where
            %an actual Near Right movement occurred
            [thNR,ACCNR] = FindMinAndMax("NR");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz

                %NR has a 1 at indices of locations that correspond to a
                %true Near Right movement (first row in each cell) and
                %predicted Near Right movement (second row in each cell)
                NR = cell(1,10);
                for s=1:10
                    rootpath = sprintf('Right%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as
                    %Near Right movements (peaks with value from 0 to thNR)
                    [~,lc0] = findpeaks(H_filtered,'MinPeakHeight',0);
                    [~,lcH0] = findpeaks(H_filtered,'MinPeakHeight',thNR);
                    [ind0,~] = setdiff(lc0,lcH0);
                    Pos{1,s} = ind0;
                    NR{1,s} = zeros(2,length(ind0));

                    %Find predicted peaks at the threshold thNR*mult
                    [~,lc] = findpeaks(H_filtered,'MinPeakHeight',thNR*mult);
                    [~,lcH] = findpeaks(H_filtered,'MinPeakHeight',thNR);
                    [ind,~] = setdiff(lc,lcH);

                    %Save a 1 in NR{1,s}(1,:) at indices corresponding to an
                    %actual Near Right movement
                    for ac=1:10
                        NR{1,s}(1,find(ACCNR{1,s}(ac,2)==Pos{1,s}')) = 1;
                    end
                    
                    %Save a 1 in NR{1,s}(2,:) at indices corresponding to an
                    %predicted Near Right movement
                    for nr=1:length(ind)
                        NR{1,s}(2,find(ind(nr)==Pos{1,s})) = 1;
                    end
                end

                %Concatenate all cells in NR
                NRfinal = cell2mat(NR);

                %Find the tpr and fpr value for the threshold value
                %thNR*mult and save to TPR and FPR
                [tpr,fpr] = roc(NRfinal(1,:),NRfinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thNR);
            AUC = trapz(flip(FPR),flip(TPR));

            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Near Right ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)
            
        case "FL"
            %Find the min voltage of an Far Left movement and the locations where
            %an actual Far Left movement occurred
            [thFL,ACCFL] = FindMinAndMax("FL");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz

                %FL has a 1 at indices of locations that correspond to a
                %true Far Left movement (first row in each cell) and
                %predicted Far Left movement (second row in each cell)
                FL = cell(1,10);
                for s=1:10
                    rootpath = sprintf('Lefts%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as
                    %Far Left movements (peaks with value from 0 to thFL)
                    [~,lc0] = findpeaks(-H_filtered,'MinPeakHeight',0);
                    Pos{1,s} = lc0;
                    FL{1,s} = zeros(2,length(lc0));

                    %Find predicted peaks at the threshold thFL*mult
                    [~,lcFL] = findpeaks(-H_filtered,'MinPeakHeight',thFL*mult);

                    %Save a 1 in FL{1,s}(1,:) at indices corresponding to an
                    %actual Far Left movement
                    for ac=1:10
                        FL{1,s}(1,find(ACCFL{1,s}(ac,2)==Pos{1,s}')) = 1;
                    end
                    
                    %Save a 1 in FL{1,s}(2,:) at indices corresponding to an
                    %predicted Far Left movement
                    for fl=1:length(lcFL)
                        FL{1,s}(2,find(lcFL(fl)==Pos{1,s})) = 1;
                    end
                end

                %Concatenate all cells in FL
                FLfinal = cell2mat(FL);

                %Find the tpr and fpr value for the threshold value
                %thFL*mult and save to TPR and FPR
                [tpr,fpr] = roc(FLfinal(1,:),FLfinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thFL);
            AUC = trapz(flip(FPR),flip(TPR));

            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Far Left ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)
            
        case "NL"
            %Find the min voltage of an Near Left movement and the locations where
            %an actual Near Left movement occurred
            [thNL,ACCNL] = FindMinAndMax("NL");

            TPR = zeros(length(numz),1);
            FPR = zeros(length(numz),1);
            count=1;
            for mult=numz

                %NL has a 1 at indices of locations that correspond to a
                %true Near Left movement (first row in each cell) and
                %predicted Near Left movement (second row in each cell)
                NL = cell(1,10);
                for s=1:10
                    rootpath = sprintf('Lefts%d',s);
                    load(rootpath)

                    %Find all possible peaks that could be classified as
                    %Near Left movements (peaks with value from 0 to thNL)
                    [~,lc0] = findpeaks(-H_filtered,'MinPeakHeight',0);
                    [~,lcH0] = findpeaks(-H_filtered,'MinPeakHeight',thNL);
                    [ind0,~] = setdiff(lc0,lcH0);
                    Pos{1,s} = ind0;
                    NL{1,s} = zeros(2,length(ind0));

                    %Find predicted peaks at the threshold thNL*mult
                    [~,lc] = findpeaks(-H_filtered,'MinPeakHeight',thNL*mult);
                    [~,lcH] = findpeaks(-H_filtered,'MinPeakHeight',thNL);
                    [ind,~] = setdiff(lc,lcH);

                    %Save a 1 in NL{1,s}(1,:) at indices corresponding to an
                    %actual Near Left movement
                    for ac=1:10
                        NL{1,s}(1,find(ACCNL{1,s}(ac,2)==Pos{1,s}')) = 1;
                    end
                    
                    %Save a 1 in NL{1,s}(2,:) at indices corresponding to an
                    %predicted Near Left movement
                    for nl=1:length(ind)
                        NL{1,s}(2,find(ind(nl)==Pos{1,s})) = 1;
                    end
                end

                %Concatenate all cells in NL
                NLfinal = cell2mat(NL);

                %Find the tpr and fpr value for the threshold value
                %thNL*mult and save to TPR and FPR
                [tpr,fpr] = roc(NLfinal(1,:),NLfinal(2,:));
                TPR(count) = max(tpr);
                FPR(count) = max(fpr);
                count=count+1;
            end
            %Find the best threshold value and AUC score
            best = KneePoint(TPR,FPR,numz,thNL);
            AUC = trapz(flip(FPR),flip(TPR));

            %Plot the ROC curve
            plot(FPR,TPR,'LineWidth',2)
            title("Near Left ROC Curve")
            xlabel("False Positive Rate")
            ylabel("True Positive Rate")
            strAUC = sprintf("AUC = %f", AUC);
            strBest = sprintf("Best threshold = %fmV",best);
            annotation('textbox',[.4 .3 .1 .1],'String',strAUC,'FitBoxToText','on','FontSize',14)
            annotation('textbox',[.4 .15 .1 .1],'String',strBest,'FitBoxToText','on','FontSize',14)
    end
end