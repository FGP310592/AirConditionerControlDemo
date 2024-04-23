function [pSat] = AirMoisture_TpSat(T)
pSat = exp(-5800.2206/T+1.3914993-0.04860239*T+0.41764768e-4*(T^2)-0.14452093e-7*(T^3)+6.5459673*log(T));
end