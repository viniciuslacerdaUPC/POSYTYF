% Calculation of small-signal indices
clear all;clc;
load('Small_signal_results')

for ii = 1:16 
    %---------------------------------------------------
    % Identify poles which correspond to SGs and VSCs
    %---------------------------------------------------
    states = results_SS(ii).states;
    x_SG1 = [];
    x_SG2 = [];
    x_VSC1 = [];
    x_VSC2 = [];
    x_VSC3 = [];
    x_VSC4 = [];

    %Identify state to each element
    for jj = 1:length(states)
        if states{jj}(1:3)=='SG1'
           x_SG1 = [x_SG1,jj];
        elseif states{jj}(1:3)=='SG2'
           x_SG2 = [x_SG2,jj];
        elseif states{jj}(1:4)=='VSC1'
           x_VSC1 = [x_VSC1,jj];
        elseif states{jj}(1:4)=='VSC2'
           x_VSC2 = [x_VSC2,jj];
        elseif states{jj}(1:4)=='VSC3'
           x_VSC3 = [x_VSC3,jj];
        elseif states{jj}(1:4)=='VSC4'
           x_VSC4 = [x_VSC4,jj];
        end
    end

    %Identify poles (Partifipaction factor >0.3)
    PF_min = 0.3;
    nPF = results_SS(ii).nPF;
    [aux,ii_SG1] = find(nPF(x_SG1,:)>PF_min);
    ii_SG1 = unique(ii_SG1);
    [aux,ii_SG2] = find(nPF(x_SG2,:)>PF_min);
    ii_SG2 = unique(ii_SG2);
    [aux,ii_VSC1] = find(nPF(x_VSC1,:)>PF_min);
    ii_VSC1 = unique(ii_VSC1);
    [aux,ii_VSC2] = find(nPF(x_VSC2,:)>PF_min);
    ii_VSC2 = unique(ii_VSC2);
    [aux,ii_VSC3] = find(nPF(x_VSC3,:)>PF_min);
    ii_VSC3 = unique(ii_VSC3);
    [aux,ii_VSC4] = find(nPF(x_VSC4,:)>PF_min);
    ii_VSC4 = unique(ii_VSC4);
    clear aux
    
    
    % 1 damping_ratio Index
    damping_ratio = results_SS(ii).damping_ratio;
    DI = 1-min(damping_ratio);
    
    DI_SG(1) = 1-min(damping_ratio(ii_SG1));
    DI_SG(2) = 1-min(damping_ratio(ii_SG2));
   
    DI_VSC(1) = 1-min(damping_ratio(ii_VSC1));
    DI_VSC(2) = 1-min(damping_ratio(ii_VSC2));
    DI_VSC(3) = 1-min(damping_ratio(ii_VSC3));
    DI_VSC(4) = 1-min(damping_ratio(ii_VSC4));
    
    % Interaction indices
    for kk = 1:length(damping_ratio)
        PF_VSC1_max = max(nPF(x_VSC1,kk));
        PF_VSC2_max = max(nPF(x_VSC2,kk));
        PF_VSC3_max = max(nPF(x_VSC3,kk));
        PF_VSC4_max = max(nPF(x_VSC4,kk));       
        PF_VSC_max = maxk([PF_VSC1_max,PF_VSC2_max,PF_VSC3_max,PF_VSC4_max],2);
        
        PF_SG1_max = max(nPF(x_SG1,kk));
        PF_SG2_max = max(nPF(x_SG2,kk));
        PF_SG_max = maxk([PF_SG1_max,PF_SG2_max],2);
        
        % 2 Interaction Index
        InI_VSC_aux(kk) = sqrt(PF_VSC_max(1)*PF_VSC_max(2));
        InI_SG_aux(kk) = sqrt(PF_SG_max(1)*PF_SG_max(2)); 
        InI_SG_VSC_aux(kk) = sqrt(PF_VSC_max(1)*PF_SG_max(1)); 
        
        % 3 Risky Interaction Index
        RInI_VSC_aux(kk) = sqrt(PF_VSC_max(1)*PF_VSC_max(2))*(1-damping_ratio(kk))^2;
        RInI_SG_aux(kk) = sqrt(PF_SG_max(1)*PF_SG_max(2))*(1-damping_ratio(kk))^2;
        RInI_SG_VSC_aux(kk) = sqrt(PF_VSC_max(1)*PF_SG_max(1))*(1-damping_ratio(kk))^2;
    end
    
    [InI_VSC, InI_VSC_ind] = max(InI_VSC_aux);
    [InI_SG, InI_SG_ind] = max(InI_SG_aux);
    [InI_SG_VSC, InI_SG_VSC_ind] = max(InI_SG_VSC_aux);
    
    [RInI_VSC, RInI_VSC_ind] = max(RInI_VSC_aux);
    [RInI_SG, RInI_SG_ind] = max(RInI_SG_aux);
    [RInI_SG_VSC, RInI_SG_VSC_ind] = max(RInI_SG_VSC_aux);

    % Save results in SS_indices structure
    SS_indices(ii).DI_SG=DI_SG;
    SS_indices(ii).DI_VSC=DI_VSC;
    SS_indices(ii).InI_SG=InI_SG;
    SS_indices(ii).InI_VSC=InI_VSC;
    SS_indices(ii).InI_SG_VSC=InI_SG_VSC;
    SS_indices(ii).RInI_SG=RInI_SG;
    SS_indices(ii).RInI_VSC=RInI_VSC;
    SS_indices(ii).RInI_SG_VSC=RInI_SG_VSC;
end

save('Small_Signal_indices','SS_indices')