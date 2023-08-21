function [xL,xG] = Refrigerant_hx(hLSat,hGSat,h)
if(h < hLSat)
    xL = 1;
    xG = 0;
elseif(h > hGSat)
    xL = 0;
    xG = 1;
else
    xG = (h-hLSat)/(hGSat-hLSat);
    xL = 1-xG;
end
end