clear all
close all
clc
%% Definitions
% 1: evaporator
% 2: condenser
%% Settings
Settings.PlotFreq = 1; % [1]
%% Define constants
Constants.pi = 3.14; % [1]
Constants.R = 8.314472; % [J/kg/mol]
%% Fluids
% Fluids - Refrigerant
Fluids.Refrigerant.MW = 52e-3; % [kg/mol] - Molecular weight
Fluids.Refrigerant.RG = Constants.R/Fluids.Refrigerant.MW; % [kg/mol] - Gas constant
Fluids.Refrigerant.TSat(1) = 14+273.15; % [K] - Saturation temperature at ambient pressure
Fluids.Refrigerant.TSat(2) = 14+273.15; % [K] - Saturation temperature at evaporator pressure
Fluids.Refrigerant.TSat(3) = 42+273.15; % [K] - Saturation temperature at condenser pressure
Fluids.Refrigerant.TSatVar(1) = 0; % [K] - Saturation temperature variation at ambient pressure
Fluids.Refrigerant.TSatVar(2) = 0; % [K] - Saturation temperature variation at evaporator pressure
Fluids.Refrigerant.TSatVar(3) = 0; % [K] - Saturation temperature variation at condenser pressure
Fluids.Refrigerant.rhoL(1) = 1000; % [kg/m^3] - Liquid density at ambient pressure
Fluids.Refrigerant.rhoL(2) = 1000; % [kg/m^3] - Liquid density at evaporator pressure
Fluids.Refrigerant.rhoL(3) = 1000; % [kg/m^3] - Liquid density at condenser pressure
Fluids.Refrigerant.muL(1) = 1e-5; % [Pa*m] - Liquid dynamic viscosity at ambient pressure
Fluids.Refrigerant.muL(2) = 1e-5; % [Pa*m] - Liquid dynamic viscosity at evaporator pressure
Fluids.Refrigerant.muL(3) = 1e-5; % [Pa*m] - Liquid dynamic viscosity at condenser pressure
Fluids.Refrigerant.muG(1) = 1e-5; % [Pa*m] - Gas dynamic viscosity at ambient pressure
Fluids.Refrigerant.muG(2) = 1e-5; % [Pa*m] - Gas dynamic viscosity at evaporator pressure
Fluids.Refrigerant.muG(3) = 1e-5; % [Pa*m] - Gas dynamic viscosity at condenser pressure
Fluids.Refrigerant.lambdaL(1) = 0.125; % [W/m/K] - Liquid thermal conductivity at ambient pressure
Fluids.Refrigerant.lambdaL(2) = 0.125; % [W/m/K] - Liquid thermal conductivity at evaporator pressure
Fluids.Refrigerant.lambdaL(3) = 0.125; % [W/m/K] - Liquid thermal conductivity at condenser pressure
Fluids.Refrigerant.lambdaG(1) = 0.125; % [W/m/K] - Gas thermal conductivity at ambient pressure
Fluids.Refrigerant.lambdaG(2) = 0.125; % [W/m/K] - Gas thermal conductivity at evaporator pressure
Fluids.Refrigerant.lambdaG(3) = 0.125; % [W/m/K] - Gas thermal conductivity at condenser pressure
Fluids.Refrigerant.cpL(1) = 1088; % [J/kg/K] - Liquid constant pressure specific heat at ambient pressure
Fluids.Refrigerant.cpL(2) = 1088; % [J/kg/K] - Liquid constant pressure specific heat at evaporator pressure
Fluids.Refrigerant.cpL(3) = 1265; % [J/kg/K] - Liquid constant pressure specific heat at condenser pressure
Fluids.Refrigerant.cpG(1) = 2104; % [J/kg/K] - Gas specific heat at ambient pressure
Fluids.Refrigerant.cpG(2) = 2104; % [J/kg/K] - Gas specific heat at evaporator pressure
Fluids.Refrigerant.cpG(3) = 2000; % [J/kg/K] - Gas specific heat at condenser pressure
Fluids.Refrigerant.gammaG(1) = 1.4; % [1] - Gas specific heats ratio at ambient pressure
Fluids.Refrigerant.gammaG(2) = 1.4; % [1] - Gas specific heats ratio at evaporator pressure
Fluids.Refrigerant.gammaG(3) = 1.4; % [1] - Gas specific heats ratio at condenser pressure
Fluids.Refrigerant.hLSat(1) = 225010; % [J/kg] - Saturation liquid specific entalphy at ambient pressure
Fluids.Refrigerant.hLSat(2) = 225010; % [J/kg] - Saturation liquid specific entalphy at evaporator pressure
Fluids.Refrigerant.hLSat(3) = 279840; % [J/kg] - Saturation liquid specific entalphy at condenser pressure
Fluids.Refrigerant.hGSat(1) = 516900; % [J/kg] - Saturation gas specific entalphy at ambient pressure
Fluids.Refrigerant.hGSat(2) = 516900; % [J/kg] - Saturation gas specific entalphy at evaporator pressure
Fluids.Refrigerant.hGSat(3) = 511800; % [J/kg] - Saturation gas specific entalphy at condenser pressure
% Fluids - Air
Fluids.Air.MW = 28.97e-3; % [kg/mol] - Molecular weight
Fluids.Air.RG = Constants.R/Fluids.Air.MW; % [kg/mol] - Gas constant
Fluids.Air.muG = 2e-5; % [Pa*m] - Gas dynamic viscosity
Fluids.Air.lambdaG = 0.125; % [W/m/K] - Gas thermal conductivity
Fluids.Air.cpG = 1100; % [W/kg/K] - Gas constant pressure specific heat
Fluids.Air.gammaG = 1.33; % [1] - Gas specific heats ratio
% Fluids - Moisture
Fluids.Moisture.MW = 18.01528e-3; % [kg/mol] - Molecular weight
Fluids.Moisture.RG = Constants.R/Fluids.Moisture.MW; % [kg/mol] - Gas constant
Fluids.Moisture.muG = 2e-5; % [Pa*m] - Gas dynamic viscosity
Fluids.Moisture.lambdaG = 1100; % [W/m/K] - Gas thermal conductivity
Fluids.Moisture.cpG = 1100; % [W/kg/K] - Gas constant pressure specific heat
Fluids.Moisture.gammaG = 1100; % [1] - Gas specific heats ratio
%% Import input file
[FileInput] = ImportFileInput('AC dataset may15.xlsx');
%% Define AC
% General
AC.General.p(1) = 1*101325; % [Pa] - Ambient pressure
AC.General.p(2) = 14*101325; % [Pa] - Evaporator pressure
AC.General.p(3) = 28*101325; % [Pa] - Condenser pressure
% Compressor
AC.Compressor.omega0 = 0; % [rad/s]
AC.Compressor.nVarMax = 10; % [rpm]
AC.Compressor.V = 0.0000138; % [m^3]
AC.Compressor.J = 1e-2; % [kg/m^2]
AC.Compressor.B = 5e-3; % [Nm/rpm]
AC.Compressor.etaEl = 1; % [1]
AC.Compressor.etaVol = 1; % [1]
% Condenser fan
AC.CondenserFan.D = 20/100; % [m]
AC.CondenserFan.ATr = pi*(AC.CondenserFan.D^2)/4; % [m^2]
AC.CondenserFan.etaEl = 1; % [1]
% Condenser
AC.Condenser.Refrigerant.NumNodes = 50; % [1]
AC.Condenser.Refrigerant.NumPipes = 2; % [1]
AC.Condenser.Refrigerant.L = 10; % [m]
AC.Condenser.Refrigerant.D = 2/100; % [m]
AC.Condenser.Refrigerant.ATr = pi*(AC.Condenser.Refrigerant.D^2)/4; % [m^2]
AC.Condenser.Refrigerant.ALong = AC.Condenser.Refrigerant.L*pi*AC.Condenser.Refrigerant.D; % [m^2]
AC.Condenser.Refrigerant.kU = 1; % [1] - Fitting coefficient
AC.Condenser.AirMoisture.D = 20/100; % [m]
AC.Condenser.AirMoisture.ATr = pi*(AC.Condenser.AirMoisture.D^2)/4; % [m^2]
AC.Condenser.AirMoisture.kU = 1; % [1] - Fitting coefficient
% Evaporator fan
AC.EvaporatorFan.D = 20/100; % [m]
AC.EvaporatorFan.ATr = pi*(AC.EvaporatorFan.D^2)/4; % [m^2]
AC.EvaporatorFan.etaEl = 1; % [1]
% Evaporator
AC.Evaporator.Refrigerant.NumNodes = 50; % [1]
AC.Evaporator.Refrigerant.NumPipes = 1; % [1]
AC.Evaporator.Refrigerant.L = 10; % [m]
AC.Evaporator.Refrigerant.D = 2/100; % [m]
AC.Evaporator.Refrigerant.ATr = pi*(AC.Evaporator.Refrigerant.D^2)/4; % [m^2]
AC.Evaporator.Refrigerant.ALong = AC.Evaporator.Refrigerant.L*pi*AC.Evaporator.Refrigerant.D; % [m^2]
AC.Evaporator.Refrigerant.kU = 1; % [1] - Fitting coefficient
AC.Evaporator.AirMoisture.D = 10/100; % [m]
AC.Evaporator.AirMoisture.ATr = pi*(AC.Evaporator.AirMoisture.D^2)/4; % [m^2]
AC.Evaporator.AirMoisture.kU = 1; % [1]
% Controller
AC.Controller.Room.Input.Time = FileInput.Time; % [s]
AC.Controller.Room.Input.TCmd = FileInput.Controller.Room.TCmd; % [K]
AC.Controller.Compressor.P = 0.5; % [-]
AC.Controller.Compressor.I = 0.01; % [-]
AC.Controller.Compressor.CCmdMax = 10; % [Nm]
AC.Controller.Room.eTMax = AC.Controller.Compressor.CCmdMax/AC.Controller.Compressor.P; % [K]
AC.Controller.Room.IeTMax = AC.Controller.Compressor.CCmdMax/AC.Controller.Compressor.I; % [K*s]
%% Environment
Environment.Input.Time = FileInput.Time; % [s]
Environment.Input.p = 101325*ones(size(Environment.Input.Time)); % [Pa]
Environment.Input.T = FileInput.Environment.T; % [K]
Environment.Input.RH = 0.25*ones(size(Environment.Input.Time)); % [1]
Environment.Input.I = 50*ones(size(Environment.Input.Time)); % [W/m^2]
%% Room
Room.Input.Time = FileInput.Time; % [s]
Room.Input.NumOcc = FileInput.Room.NumOcc; % [1]
Room.Input.RVent = 0*ones(size(Environment.Input.Time)); % [1]
Room.qOcc = 10; % [W/NumOcc]
Room.ASec = 20; % [m^2]
Room.AW = 0; % [m^2]
Room.H = 2.7; % [m]
Room.ALat = sqrt(Room.ASec)*Room.H; % [m^2]
Room.V = Room.ASec*Room.H; % [m^3]
Room.UGl = 10; % [W/m^2/K]
%% Run
run('Run.m');
%% Plot
run('Plot.m');