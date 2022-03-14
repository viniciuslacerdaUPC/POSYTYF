% Plot indices in a matrix figure
clear all;close all; clc;

indices_matrix = zeros(8+5*13,16);

% Load small-signal indices
load('Small_signal_indices')
for ii = 1:length(SS_indices)
    indices_matrix(1,ii) = max(SS_indices(ii).DI_SG);
    indices_matrix(2,ii) = max(SS_indices(ii).DI_VSC);
    indices_matrix(3,ii) = max(SS_indices(ii).InI_SG);
    indices_matrix(4,ii) = max(SS_indices(ii).InI_VSC);
    indices_matrix(5,ii) = max(SS_indices(ii).InI_SG_VSC);
    indices_matrix(6,ii) = max(SS_indices(ii).RInI_SG);
    indices_matrix(7,ii) = max(SS_indices(ii).RInI_VSC);
    indices_matrix(8,ii) = max(SS_indices(ii).RInI_SG_VSC);
end
clear SS_indices

% Load transient indices for disconnections
load('Trans_indices_disc')
for ii = 1:16
    for jj = 1:6
        indices_matrix(9+(jj-1)*5,ii) = trans_indices_disc.DGAI(ii,jj);
        indices_matrix(10+(jj-1)*5,ii) = trans_indices_disc.DVI(ii,jj);
        indices_matrix(11+(jj-1)*5,ii) = trans_indices_disc.FDI(ii,jj);
        indices_matrix(12+(jj-1)*5,ii) = trans_indices_disc.FDI(ii,jj);
        indices_matrix(13+(jj-1)*5,ii) = trans_indices_disc.FDI(ii,jj);
    end
end
clear trans_indices_disc

% Load transient indices for faults
load('Trans_indices_flts')
for ii = 1:16
    for jj = 1:7
        indices_matrix(39+(jj-1)*5,ii) = trans_indices_flts.DGAI(ii,jj);
        indices_matrix(40+(jj-1)*5,ii) = trans_indices_flts.DVI(ii,jj);
        indices_matrix(41+(jj-1)*5,ii) = trans_indices_flts.FDI(ii,jj);
        indices_matrix(42+(jj-1)*5,ii) = trans_indices_flts.FDI(ii,jj);
        indices_matrix(43+(jj-1)*5,ii) = trans_indices_flts.FDI(ii,jj);
    end
end
clear trans_indices_flts

% Plot transient indices in a matrix format
f = figure('Name',['Indices']);
f.Position=[400 50 500 900];

jet = jet;
colormap((jet(length(jet)*0.5:length(jet),:))) 
                       
imagesc(indices_matrix)
set(gca, 'XAxisLocation', 'top') 
xticks(1:16) 
xlabel('Case')
yticks(0.5:73.5)

yticklabels([])
hold on
for ii = [8.5,8.5+5:5:12*5+8.5]
    plot([0.5 16.5],[ii ii],'color','k');
end

%plot grid
%vertical lines
for ii = 0.5:16.5
    plot([ii ii],[0.5 73.5],'Color',[223 223 223]/255)
end
%horizontal lines
for ii = 0.5:73.5
    plot([0.5 16.5],[ii ii],'Color',[223 223 223]/255)
end

%horizontal lines
for ii = [8.5,8.5+5*[1:12]]
    plot([0.5 16.5],[ii ii],'Color','k')
end


