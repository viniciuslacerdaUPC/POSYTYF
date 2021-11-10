%%%%%%%%-------------- System parameters-------------%%%%%%%%%
Ts = 100e-6;                             % Simulation time step
dec = 10;        % decimation before exporting to workspace
fg = 50;        % Power frequency (Hz)
Sb = 100e6;     % System base power (VA)
Vmv = 22e3;     % Nominal MV (LL-RMS)
Vhv = 220e3;    % Nominal HV (LL-RMS)
Ihv = Sb/(Vhv*sqrt(3));
Ihvpk = Ihv*sqrt(2);
%% Sources
tonvsc = 0.01; % Time instant to connect the VSCs

% Nominal values (W)
S1non = 400e6;
S2non = 300e6;
S3non = 200e6;
S4snon = 200e6;
S5non = 500e6;
S6non = 400e6;
S6snon = 200e6;
S7non = 200e6;

% "Instantaneous generation (p.u)"
G1gen = 0.1245;   %    (400 MW nominal)
G2gen = 0.30;   % WF (300 MW nominal)
G3gen = 0.20;   % PV (200 MW nominal)
G4sgen = 0.2078;  % ST (200 MW nominal)
G5gen = 0.20;   % WF (300 MW nominal)
G6gen = 0.2078;   % PV (400 MW nominal)
G6sgen = 0.20;  % ST (200 MW nominal)
G7gen = 0.518;   % SG (200 MW nominal)

%% Transformers
Xtpu = 0.15;             % Transformer reactance p.u
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
Sr = 579e6; % Base apparent power (VA)
PF = 0.95; % Power factor
Pr = Sr*PF; % Base active power (W)
Qr = sqrt(Sr^2 - Pr^2); % Base reactive power (Var)

% Individual loads demands (p.u)
L3dem = 0.10;
L4dem = 0.30;
L5dem = 0.35;
L6dem = 0.15;
L7dem = 0.10;

%% Conductors
% Zebra ACSR with Cigré TB 575 Tower configuration and earth wire.
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

r1 = r1_hawk;
r0= r0_hawk;
l1= l1_hawk; 
l0= l0_hawk;
c1= c1_hawk;
c0= c0_hawk;