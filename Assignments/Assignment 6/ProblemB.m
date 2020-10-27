clc;
clear;
Epsilon = 8.854e-12;
rho_s = 2e-6;
numRsteps = 500;
numphiSteps = 500;
r_lower = 0;
r_upper = 0.2;
phi_lower = 0;
phi_upper = 2*pi;
dr = (r_upper - r_lower) / numRsteps;
dphi = (phi_upper - phi_lower) / numphiSteps;

P = [0,0,1];
E = [0,0,0];
r = r_lower + dr/2;
phi = phi_lower + dphi/2;

for j = 1: numphiSteps
    for i = 1: numRsteps
        Rs = [r*cos(phi),r*sin(phi),0];
        R = P-Rs;
        PMag = norm(R);
        E = E + ((rho_s*r*dr*dphi)/(4*Epsilon*pi*(PMag^3))) * R; 
        r = r + dr;
    end
    phi = phi + dphi;
    r = r_lower;
end
E
