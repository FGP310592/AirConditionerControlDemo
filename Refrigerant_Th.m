function [h] = Refrigerant_Th(TSat,TSatVar,cpL,cpG,hLSat,hGSat,T)
if(T > TSat+TSatVar/2)
    h = hGSat+cpG*(T-(TSat+TSatVar/2));
elseif(T < TSat-TSatVar/2)
    h = hLSat+cpL*(T-(TSat-TSatVar/2));
else
    h = (hLSat+hGSat)/2;
end
end