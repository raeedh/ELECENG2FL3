% PART B - VARIATION 00
% R' = 262.5 ohms/m
% L' = 167 nH/m
% G' = 57 mS/m
% C' = 67 pF/m

Rprime = 262.5; % ohms/m
Lprime = 167*1e-9; %H/m
Gprime = 57*1e-3; %S/m
Cprime = 67*1e-12; %F/m

%% freq
freq_start_pulse = 100*1e6;
freq_end_pulse = 10*1e9;
freq_step_pulse = 10*1e6;
freq = freq_start_pulse:freq_step_pulse:freq_end_pulse;
omega = 2*pi*freq;

%% calculations
gamma = j*omega.*sqrt((Lprime-j.*(Rprime./omega)).*(Cprime-j.*(Gprime./omega))); %complex propagation constant
alpha = real(gamma);
beta = imag(gamma);
v_p = omega./beta; %phase velocity
lambda = (2*pi)./beta; %wavelength
Z_0 = sqrt((Rprime+(j*Lprime.*omega))./(Gprime + (j*Cprime.*omega)));
real_Z_0 = real(Z_0);
imag_Z_0 = imag(Z_0);

%% plots
figure(1);

% if this line causes an issue in older versions, you can remove it
% it just resizes the figure window to be maximized when its opened
set(gcf,'WindowState','maximized');

subplot(2,3,1)
plot(freq,alpha)
title("Alpha vs Frequency");
xlabel("Frequency (Hz)");
ylabel("Attenuation constant (m^-1)");

subplot(2,3,4)
plot(freq,beta)
title("Beta vs Frequency");
xlabel("Frequency (Hz)");
ylabel("Phase constant (m^-1)");

subplot(2,3,2)
plot(freq,v_p)
title("Phase velocity vs Frequency");
xlabel("Frequency (Hz)");
ylabel("Phase velocity (rad/m)");

subplot(2,3,5)
plot(freq,lambda)
title("Wavelength vs Frequency");
xlabel("Frequency (Hz)");
ylabel("Wavelength (m)");

subplot(2,3,3)
plot(freq,real_Z_0)
title("Re(Z_0) vs Frequency");
xlabel("Frequency (Hz)");
ylabel("Real part of Z_0 (ohms)");

subplot(2,3,6)
plot(freq,imag_Z_0)
title("Im(Z_0) vs Frequency");
xlabel("Frequency (Hz)");
ylabel("Imginary part of Z_0 (ohms)");