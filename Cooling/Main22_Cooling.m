clear all
close all
clc
%% Settings
Settings.SaveData1dPeriod = 10; % [s]
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
%% AC
% General
AC.General.p(1) = 1*101325; % [Pa] - Ambient pressure
AC.General.p(2) = 14*101325; % [Pa] - Evaporator pressure
AC.General.p(3) = 28*101325; % [Pa] - Condenser pressure
AC.General.InitialConditions.kEnvironment = 1; % [-], 1: Environment 1, 2: Environment 2
% Compressor
AC.Compressor.omega0 = 0; % [rad/s]
AC.Compressor.nVarMax = 10; % [rpm]
AC.Compressor.V = 0.0000138; % [m^3]
AC.Compressor.J = 1e-2; % [kg/m^2]
AC.Compressor.B = 5e-3; % [Nm/rpm]
AC.Compressor.etaEl = 1; % [1]
AC.Compressor.etaVol = 1; % [1]
% Condenser 1 fan
AC.HXOut1Fan.D = 20/100; % [m]
AC.HXOut1Fan.ATr = pi*(AC.HXOut1Fan.D^2)/4; % [m^2]
AC.HXOut1Fan.etaEl = 1; % [1]
% Condenser 1
AC.HXOut1.Refrigerant.NumNodes = 25; % [1]
AC.HXOut1.Refrigerant.NumPipes = 1; % [1]
AC.HXOut1.Refrigerant.L = 5; % [m]
AC.HXOut1.Refrigerant.D = 2/100; % [m]
AC.HXOut1.Refrigerant.ATr = pi*(AC.HXOut1.Refrigerant.D^2)/4; % [m^2]
AC.HXOut1.Refrigerant.ALong = AC.HXOut1.Refrigerant.L*pi*AC.HXOut1.Refrigerant.D; % [m^2]
AC.HXOut1.Refrigerant.kU = 1; % [1] - Fitting coefficient
AC.HXOut1.AirMoisture.D = 20/100; % [m]
AC.HXOut1.AirMoisture.ATr = pi*(AC.HXOut1.AirMoisture.D^2)/4; % [m^2]
AC.HXOut1.AirMoisture.kU = 1; % [1] - Fitting coefficient
AC.HXOut1.phiLims_AirMoistureGSingleNode = true; % [-]
% Condenser 2 fan
AC.HXOut2Fan.D = 20/100; % [m]
AC.HXOut2Fan.ATr = pi*(AC.HXOut2Fan.D^2)/4; % [m^2]
AC.HXOut2Fan.etaEl = 1; % [1]
% Condenser 2
AC.HXOut2.FlagPresent = true; % [-]
AC.HXOut2.Refrigerant.NumNodes = 25; % [1]
AC.HXOut2.Refrigerant.NumPipes = 1; % [1]
AC.HXOut2.Refrigerant.L = 5; % [m]
AC.HXOut2.Refrigerant.D = 2/100; % [m]
AC.HXOut2.Refrigerant.ATr = pi*(AC.HXOut2.Refrigerant.D^2)/4; % [m^2]
AC.HXOut2.Refrigerant.ALong = AC.HXOut2.Refrigerant.L*pi*AC.HXOut2.Refrigerant.D; % [m^2]
AC.HXOut2.Refrigerant.kU = 1; % [1] - Fitting coefficient
AC.HXOut2.AirMoisture.D = 20/100; % [m]
AC.HXOut2.AirMoisture.ATr = pi*(AC.HXOut2.AirMoisture.D^2)/4; % [m^2]
AC.HXOut2.AirMoisture.kU = 1; % [1] - Fitting coefficient
AC.HXOut2.phiLims_AirMoistureGSingleNode = true; % [-]
% Evaporator 1 fan
AC.HXIn1Fan.D = 20/100; % [m]
AC.HXIn1Fan.ATr = pi*(AC.HXIn1Fan.D^2)/4; % [m^2]
AC.HXIn1Fan.etaEl = 1; % [1]
% Evaporator 1
AC.HXIn1.Refrigerant.NumNodes = 25; % [1]
AC.HXIn1.Refrigerant.NumPipes = 1; % [1]
AC.HXIn1.Refrigerant.L = 5; % [m]
AC.HXIn1.Refrigerant.D = 2/100; % [m]
AC.HXIn1.Refrigerant.ATr = pi*(AC.HXIn1.Refrigerant.D^2)/4; % [m^2]
AC.HXIn1.Refrigerant.ALong = AC.HXIn1.Refrigerant.L*pi*AC.HXIn1.Refrigerant.D; % [m^2]
AC.HXIn1.Refrigerant.kU = 1; % [1] - Fitting coefficient
AC.HXIn1.AirMoisture.D = 10/100; % [m]
AC.HXIn1.AirMoisture.ATr = pi*(AC.HXIn1.AirMoisture.D^2)/4; % [m^2]
AC.HXIn1.AirMoisture.kU = 1; % [1]
AC.HXIn1.phiLims_AirMoistureGSingleNode = true; % [-]
% Evaporator 2 fan
AC.HXIn2Fan.D = 20/100; % [m]
AC.HXIn2Fan.ATr = pi*(AC.HXIn2Fan.D^2)/4; % [m^2]
AC.HXIn2Fan.etaEl = 1; % [1]
% Evaporator 2
AC.HXIn2.FlagPresent = true; % [-]
AC.HXIn2.Refrigerant.NumNodes = 25; % [1]
AC.HXIn2.Refrigerant.NumPipes = 1; % [1]
AC.HXIn2.Refrigerant.L = 5; % [m]
AC.HXIn2.Refrigerant.D = 2/100; % [m]
AC.HXIn2.Refrigerant.ATr = pi*(AC.HXIn2.Refrigerant.D^2)/4; % [m^2]
AC.HXIn2.Refrigerant.ALong = AC.HXIn2.Refrigerant.L*pi*AC.HXIn2.Refrigerant.D; % [m^2]
AC.HXIn2.Refrigerant.kU = 1; % [1] - Fitting coefficient
AC.HXIn2.AirMoisture.D = 10/100; % [m]
AC.HXIn2.AirMoisture.ATr = pi*(AC.HXIn2.AirMoisture.D^2)/4; % [m^2]
AC.HXIn2.AirMoisture.kU = 1; % [1]
AC.HXIn2.phiLims_AirMoistureGSingleNode = true; % [-]
% Controller
AC.Controller.Room.Input.Time = [0,10,10.1,20,10000]*60; % [s]
AC.Controller.Room.Input.TCmd = [28,28,24,24,24]+273.15; % [K]
AC.Controller.Compressor.P = 10; % [-]
AC.Controller.Compressor.I = 0.015; % [-]
AC.Controller.Compressor.CCmdMax = 10; % [Nm]
AC.Controller.Room.eTMax = AC.Controller.Compressor.CCmdMax/AC.Controller.Compressor.P; % [K]
AC.Controller.Room.IeTMax = AC.Controller.Compressor.CCmdMax/AC.Controller.Compressor.I; % [K*s]
if(AC.HXOut2.FlagPresent == false)
    AC.Controller.HXOut1Fan.KGCmd = 50; % [1]
    AC.Controller.HXOut2Fan.KGCmd = 50; % [1]
else
    AC.Controller.HXOut1Fan.KGCmd = 30; % [1]
    AC.Controller.HXOut2Fan.KGCmd = 30; % [1]
end
if(AC.HXIn2.FlagPresent == false)
    AC.Controller.HXIn1Fan.KGCmd = 50; % [1]
    AC.Controller.HXIn2Fan.KGCmd = 50; % [1]
else
    AC.Controller.HXIn1Fan.KGCmd = 30; % [1]
    AC.Controller.HXIn2Fan.KGCmd = 30; % [1]
end
%% Environments
% Envionment 1
Environment1.Input.Time = [0,10000]; % [s]
Environment1.Input.p = [1,1]*101325; % [Pa]
Environment1.Input.T = [1,1]*(38+273.15); % [K]
Environment1.Input.RH = [1,1]*0.25; % [1]
Environment1.Input.I = [1,1]*50; % [W/m^2]
% Envionment 2
Environment2.Input.Time = [0,10000]; % [s]
Environment2.Input.p = [1,1]*101325; % [Pa]
Environment2.Input.T = [1,1]*(20+273.15); % [K]
Environment2.Input.RH = [1,1]*0.25; % [1]
Environment2.Input.I = [1,1]*50; % [W/m^2]
%% Room
Room.Input.InitialConditions.kEnvironment = 1; % [-], 1: Environment 1, 2: Environment 2
Room.Input.Time = [0,10000]; % [s]
Room.Input.NumOcc = [1,1]; % [1]
Room.Input.RVent1 = [0,0]; % [1]
Room.Input.RVent2 = [0,0]; % [1]
Room.qOcc = 10; % [W/NumOcc]
Room.ASec = 20; % [m^2]
Room.AW1 = 0; % [m^2]
Room.AW2 = 0; % [m^2]
Room.H = 2.7; % [m]
Room.AGl1 = sqrt(Room.ASec)*Room.H/2+Room.ASec; % [m^2]
Room.AGl2 = sqrt(Room.ASec)*Room.H/2+Room.ASec; % [m^2]
Room.V = Room.ASec*Room.H; % [m^3]
Room.UGl1 = 3; % [W/m^2/K]
Room.UGl2 = 3; % [W/m^2/K]
%% Simulation
Simulation.TimeVar = 10; % [s]
Simulation.TimeEnd = 30*60; % [s]
%% Run
run('Run.m');
%% Plot
run('Plot.m');