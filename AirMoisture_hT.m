function [T] = AirMoisture_Th(cp,h)
T = 273.15+h/cp; % [K]
end