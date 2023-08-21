function [rhoG,rho] = General_pTxrho(RG,p,T,xL,xG,rhoL)
rhoG = p/RG/T;
rho = xL*rhoL+xG*rhoG;
end