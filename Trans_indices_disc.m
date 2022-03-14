% Transient indices calculation for disconnections
clear all;clc;
for ii = 1:16
    for jj = 1:6
        name_disc = {'SG1','SG2','VSC1','VSC2','VSC3','VSC4'};
        load(['Disconnection_results\sim_results_Case',num2str(ii),'_disc_',num2str(name_disc{jj})])
        
        ind = find(sim_results.t_sim>0);
        
        delta_SG1 = sim_results.dtheta_SG1(ind);
        delta_SG2 = sim_results.dtheta_SG2(ind);

        Vbus1 = sim_results.Vbus1_sim(ind);
        Vbus2 = sim_results.Vbus2_sim(ind);
        Vbus3 = sim_results.Vbus3_sim(ind);
        Vbus4 = sim_results.Vbus4_sim(ind);
        Vbus5 = sim_results.Vbus5_sim(ind);
        Vbus6 = sim_results.Vbus6_sim(ind);
        Vbus7 = sim_results.Vbus7_sim(ind);
        V = [Vbus1,Vbus2,Vbus3,Vbus4,Vbus5,Vbus6,Vbus7];

        rocof_SG1 = sim_results.ROCOF_500_SG1(ind);
        rocof_SG2 = sim_results.ROCOF_500_SG2(ind);

        f_SG1 = sim_results.f_SG1_sim(ind);
        f_SG2 = sim_results.f_SG2_sim(ind);
        f_VSC1 = sim_results.f_VSC1_sim(ind);
        f_VSC2 = sim_results.f_VSC2_sim(ind);
        f_VSC3 = sim_results.f_VSC3_sim(ind);
        f_VSC4 = sim_results.f_VSC4_sim(ind);

        % 1 Dynamic Generator Angle Index (GAI)
        delta_adm = 90;%/180*pi; %120 degrees
        DGAI(1) = max(delta_SG1/delta_adm);
        DGAI(2) = max(delta_SG2/delta_adm);
        if jj == 1
            trans_indices_disc.DGAI(ii,jj) = min([max(DGAI(2)),3]);
        elseif jj ==2
            trans_indices_disc.DGAI(ii,jj) = min([max(DGAI(1)),3]);
        else
            trans_indices_disc.DGAI(ii,jj) = min([max(DGAI),3]);
        end

        % 2 Dynamic Voltage Index
        trans_indices_disc.DVI(ii,jj) = min([max(max(abs(1-V)/0.1)),3]);

        % 4 Frequency Derivative Index
        FDI(1) = max(max(abs(rocof_SG1)));
        FDI(2) = max(max(abs(rocof_SG2)));
        if jj == 1
            trans_indices_disc.FDI(ii,jj) = min([max(FDI(2)),3]);
        elseif jj ==2
            trans_indices_disc.FDI(ii,jj) = min([max(FDI(1)),3]);
        else
            trans_indices_disc.FDI(ii,jj) = min([max(FDI),3]);
        end
        

        % 5 Maximum Frequency Deviation Index
        MFDI(1) = max(max(abs(50-f_SG1)));
        MFDI(2) = max(max(abs(50-f_SG2)));
        if jj == 1
            trans_indices_disc.MFDI(ii,jj) = min([max(MFDI(2)),3]);
        elseif jj ==2
            trans_indices_disc.MFDI(ii,jj) = min([max(MFDI(1)),3]);
        else
            trans_indices_disc.MFDI(ii,jj) = min([max(MFDI),3]);
        end

        % Converter Synchronization Index (CSI)
        CSI(1) = max(max(abs(50-f_VSC1)));
        CSI(2) = max(max(abs(50-f_VSC2)));
        CSI(3) = max(max(abs(50-f_VSC3)));
        CSI(4) = max(max(abs(50-f_VSC4)));
        if jj == 3
            trans_indices_disc.CSI(ii,jj) = min([max(CSI(2:4)),3]);
        elseif jj ==4
            trans_indices_disc.CSI(ii,jj) = min([max(CSI([1,3:4])),3]);
        elseif jj ==5
            trans_indices_disc.CSI(ii,jj) = min([max(CSI([1:2,4])),3]);
        elseif jj ==6
            trans_indices_disc.CSI(ii,jj) = min([max(CSI([1:3])),3]);
        else
            trans_indices_disc.CSI(ii,jj) = min([max(CSI),3]);
        end
       
        end
    end

    save('Trans_indices_disc','trans_indices_disc')
    