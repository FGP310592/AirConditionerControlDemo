function [T] = Refrigerant_hT(TSat,TSatVar,cpL,cpG,hLSat,hGSat,h)
if(h > hGSat)
    T = (TSat+TSatVar/2)+(h-hGSat)/cpG;
elseif(h < hLSat)
    T = (TSat-TSatVar/2)+(h-hLSat)/cpL;
else
    T = (TSat+TSatVar/2)+(h-hLSat)/(hGSat-hLSat)*TSatVar;
end
end