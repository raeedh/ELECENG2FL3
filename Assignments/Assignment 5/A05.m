%#ok<*IJCL>
% Z0 = 50 ohms
% l = 0.2136 m
% Rs = 50 ohms
% Ls = 1 nH
% Cs = 1.8 pF

Z0 = 50; % ohms
l = 0.2136; % m
Rs = 50; % ohms 
Ls = 1e-9; % H
Cs = 1.8e-12; % F
freq = 1e9:5e6:5e9; % Hz
omega = 2*pi*freq; 
c = 299792458; % m/s 

%% a
Zl = Rs + j*omega*Ls + (1./(j*omega*Cs));

%% b
alpha = 0; % attenuation constant is 0 in loss-free TL
beta = omega./c;
Zin = Z0*((Zl+j*Z0.*tan(beta.*l))./(Z0+j*Zl.*tan(beta.*l)));

%% c
Gamma = (Zl-Z0)./(Zl+Z0);

%% d
SWR = (1+abs(Gamma))./(1-abs(Gamma));

%% plots
Rin = real(Zin);
Xin = imag(Zin);


figure(1);
%set(gcf,'WindowState','maximized'); 

subplot(3,1,1)
plot(freq,Rin);
title("R_{in} vs Frequency");
xlabel("Frequency (Hz)");
ylabel("R_{in} (\Omega)");

subplot(3,1,2)
plot(freq,Xin);
title("X_{in} vs Frequency");
xlabel("Frequency (Hz)");
ylabel("X_{in} (\Omega)");

subplot(3,1,3)
plot(freq,SWR);
title("SWR vs Frequency");
xlabel("Frequency (Hz)");
ylabel("SWR");