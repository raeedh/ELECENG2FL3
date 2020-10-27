clc;
clear;
mu_0div4pi = (1*10^-7);
I = 2;
P=[0 1 1];
A=[0 0 1];
B=[0 0 -1];
length = norm(B-A);
unitAB = (B-A) / length;
numSteps = 10000;
dLvector = (length / numSteps) * unitAB;
dL = norm(dLvector);

B = [0 0 0];
Rs = A + unitAB * dL / 2;

for count = 1: numSteps
   R = P - Rs;
   RMag = norm(R);
   B = B + (cross(I*dLvector,R)/(RMag^3));
   Rs = Rs + dLvector;
end

norm(B)