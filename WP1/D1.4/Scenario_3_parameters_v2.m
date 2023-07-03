%%%%%%%%-------------- System parameters-------------%%%%%%%%%
Ts = 50e-6;                             % Simulation time step
dec = 10;        % decimation before exporting to workspace
fg = 50;        % Power frequency (Hz)
Sb = 100e6;     % System base power (VA)
Vmv = 22e3;     % Nominal MV (LL-RMS)
Vhv = 220e3;    % Nominal HV (LL-RMS)
Ihv = Sb/(Vhv*sqrt(3));
Ihvpk = Ihv*sqrt(2);

%% Define Phasor or EMT simulation
sim = 'EMT'; % Simulation mode = 'EMT' or 'Phasor'
prjname = 'Scenario_3_v2';

if strcmp(sim,'EMT')
    Ts = 5e-6;                             % Simulation time step
    tonvsc = 0.1e-3; % Time instant to connect the VSCs
    set_param([prjname '/powergui'],'SimulationMode','Discrete')
    set_param([prjname '/Measurements EMT'],'commented','off');
    set_param([prjname '/Measurements Phasor'],'commented','on'); 
    set_param([prjname '/G1/VSC v2'],'vscmod','EMT Average');
    set_param([prjname '/G4/VSC v2'],'vscmod','EMT Average');
    set_param([prjname '/G6/VSC v2'],'vscmod','EMT Average');
    set_param([prjname '/G7/VSC v2'],'vscmod','EMT Average');
    set_param([prjname '/HVDC/VSC1 v2'],'vscmod','EMT Average')
    set_param([prjname '/HVDC/VSC2 v2'],'vscmod','EMT Average')
    set_param([prjname '/G9/VSC v2'],'vscmod','EMT Average');
    set_param([prjname '/G10/VSC v2'],'vscmod','EMT Average');
    set_param([prjname '/G12/VSC v2'],'vscmod','EMT Average');
    
    disp('Simulating in EMT')
    
elseif strcmp(sim,'Phasor')
    Ts = 100e-6;                             % Simulation time step
    set_param([prjname '/powergui'],'SimulationMode','Discrete phasor')
    set_param([prjname '/Measurements EMT'],'commented','on')
    set_param([prjname '/Measurements Phasor'],'commented','off') 
    set_param([prjname '/G1/VSC v2'],'vscmod','Phasor I-ref');
    set_param([prjname '/G4/VSC v2'],'vscmod','Phasor I-ref');
    set_param([prjname '/G6/VSC v2'],'vscmod','Phasor I-ref');
    set_param([prjname '/G7/VSC v2'],'vscmod','Phasor I-ref');
    set_param([prjname '/HVDC/VSC1 v2'],'vscmod','Phasor I-ref')
    set_param([prjname '/HVDC/VSC2 v2'],'vscmod','Phasor I-ref')
    set_param([prjname '/G9/VSC v2'],'vscmod','Phasor I-ref');
    set_param([prjname '/G10/VSC v2'],'vscmod','Phasor I-ref');
    set_param([prjname '/G12/VSC v2'],'vscmod','Phasor I-ref');

    disp('Simulating in Phasor')
end

%% Sources

% Nominal values (W)
S1non = 1000e6;
S2non = 3000e6;
S3non = 1000e6;
S4non = 2000e6;
S5non = 2000e6;
S6non = 3000e6;
S7non = 4000e6;
S8non = 2000e6;
S9non = 1500e6;
S10non = 500e6;
S12non = 250e6;

% Actual power being generated with respect to the nominal (p.u) 
G1gen = 0.65;  
G2gen = 0.40;  
G3gen = 0.60;   
G4gen = 0.65;  
G5gen = 0.705; %0.50;   
G6gen = 0.45;   
G7gen = 0.40;  
G8gen = 0.65;   
G9gen = 0.90;
G10gen = 0.90;
G12gen = 0.85;
%% Transformers
Xtpu = 0.10;             % Transformer reactance p.u
Rtpu = Xtpu/40;

%% VSCs
% VSC 1
ksw1 = 27;                           % Switching ratio (number of times the AC frequency)
wsw1 = ksw1*2*pi*fg;           % Converter angular switching-frequency 
wc1 = wsw1/10;                    % current-loop bandwidth
wpq1 = wc1/10;                     % power-loop bandwidth
wdc1 = wc1/10;                     % DC voltage loop banddiwth

w_pll = 2*pi*80;
k_droop_f = 5;
k_droop_v = 2;
Iovc = 1.2;
%% Loads
% System base Load
St = (S1non*G1gen + S2non*G2gen + S3non*G3gen + S4non*G4gen + S5non*G5gen + S6non*G6gen + S7non*G7gen + S8non*G8gen + S9non*G9gen + S10non*G10gen + S12non*G12gen); % Total power generated (VA)
St1 = S2non*G2gen + S3non*G3gen+ S5non*G5gen;
St2 = (S1non*G1gen  + S4non*G4gen + S6non*G6gen + S7non*G7gen + S8non*G8gen + S9non*G9gen + S10non*G10gen + S12non*G12gen); % Total power generated (VA)

Sr = 13e9; %Total load power (VA)
PF = 0.98; % Power factor
Pr = Sr*PF; % Base active power (W)
Qr = sqrt(Sr^2 - Pr^2); % Base reactive power (Var)

% Individual loads demands (p.u)
L1dem = 0.10;
L3dem = 0.20;
L5dem = 0.10;
L6dem = 0.10;
L7dem = 0.20;
L9dem = 0.10;
L10dem = 0.04;
L12dem = 0.02;
L13dem = 0.01;
%% Conductors
% Hawk ACSR with Cigré TB 575 Tower configuration and earth wire.

r1_zeb = 0.06862;   % ohm/km
r0_zeb = 0.39362;   % ohm/km
l1_zeb = 0.00128;    % H/km
l0_zeb = 0.00368;    % H/km
c1_zeb = 9.15905e-09;    %F/km
c0_zeb = 6.57988e-09;    % F/km

r1_hawk = 0.12087;   % ohm/km
r0_hawk = 0.44587;   % ohm/km
l1_hawk = 0.00133;    % H/km
l0_hawk = 0.00373;    % H/km
c1_hawk = 8.76156e-09;    %F/km
c0_hawk = 6.37282e-09;    % F/km

r1= r1_zeb;
r0= r0_zeb;
l1= l1_zeb; 
l0= l0_zeb;
c1= c1_zeb;
c0= c0_zeb;