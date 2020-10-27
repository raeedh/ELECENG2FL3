clc;
clear;
rho_1 = 4e-9;
epsilon0 = 8.8419e-12;
P=[0 0 0];
A=[5 0 0];
B=[0 5 0];
length = norm(B-A);
unitAB = (B-A) / length;
numSteps = 10000;
dLvector = (length / numSteps) * unitAB;
dL = norm(dLvector);

E = [0 0 0];
Rs = A + unitAB * dL / 2;

for count = 1: numSteps
   R = P - Rs;
   RMag = norm(R);
   E = E + ((dL * rho_1) / (4 * pi * epsilon0 * RMag^3) * R);
   Rs = Rs + dLvector;
end

E