% Transient indices calculation for faults
clear all;clc;
for ii = 1:16
    for jj = 1:7
        load(['Fault_results\sim_results_Case',num2str(ii),'_flt_',num2str(jj)])
        
        ind = find(sim_results.t_sim>2);
        
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
        trans_indices_flts.DGAI(ii,jj) = min([max(DGAI),3]);
    
        % 2 Dynamic Voltage Index
        trans_indices_flts.DVI(ii,jj) = min([max(max(abs(1-V)/0.1)),3]);

        % 4 Frequency Derivative Index
        FDI(1) = max(max(abs(rocof_SG1)));
        FDI(2) = max(max(abs(rocof_SG2)));
        trans_indices_flts.FDI(ii,jj) = min([max(FDI),3]);

        % 5 Maximum Frequency Deviation Index
        MFDI(1) = max(max(abs(50-f_SG1)));
        MFDI(2) = max(max(abs(50-f_SG2)));
        trans_indices_flts.MFDI(ii,jj) = min([max(MFDI),3]);

        % Converter Synchronization Index (CSI)
        CSI(1) = max(max(abs(50-f_VSC1)));
        CSI(2) = max(max(abs(50-f_VSC2)));
        CSI(3) = max(max(abs(50-f_VSC3)));
        CSI(4) = max(max(abs(50-f_VSC4)));
        trans_indices_flts.CSI(ii,jj) = min([max(CSI),3]);
       
        end
    end

    save('Trans_indices_flts','trans_indices_flts')
    