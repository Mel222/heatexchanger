%% Inputs

L = 0.35; %lengthof pipes m, less than 0.3
NoT = 13; %number of tubes

A_tubes = NoT*pi*(di^2)/4;
A_shell = 0.25*pi*Dsh^2;


%% Calculations

mh = 0.52; % guess at mass flow rate
q = mh/rho; % volumetric flow rate

%Find velocity 

V_tube = q/A_tubes; %TODO check rho
Re_tube = rho*V_tube*di/mu; %TODO check mu

%Pressure drop along tubes
f_factor = (1.82*log10(Re_tube) - 1.64)^(-2);
dp_tube = f_factor*(L/di)*0.5*rho*(V_tube^2);

%entrance/exit pressure drop - using infinite Re, turbulent flow assumption
sigma = A_tubes/A_shell;
Kc = 0.4 - 0.4*sigma;
Ke = (1 - sigma)^2;

dp_ends = 0.5*rho*(V_tube^2)*(Kc+Ke);

%nozzle pressure drop - assume loss of all dynamic pressure
V_nozzle = q/(0.25*pi*dnozzle^2);
dp_nozzle = rho*V_nozzle^2;

dp_hot = dp_tube + dp_ends + dp_nozzle
