%Variation 0
%f = 10^3
%alpha = 10^5
%Er = 1

%speed of light c in free space
c  = 299792458; %m/s
%relative permittivity of the medium epsilon_r
epsilon_r = 1;
%phase velocity vp
vp = c/(sqrt(epsilon_r));
%ampltiude A
A_pulse        = 5;

%Gaussian Pulse parameters
alpha          = 1e5;
t_0            = 1;

z_step_pulse   = (vp*1e-1)/sqrt(2*alpha);
z_start_pulse  = -(3*vp)/sqrt(2*alpha);
z_end_pulse    =  (3*vp)/sqrt(2*alpha);
z_window_pulse = z_start_pulse:z_step_pulse:z_end_pulse;
max_amplitude  = A_pulse;
t_step_pulse   = 1e-1*(1/sqrt(2*alpha));
t_window_pulse = t_0- 6/sqrt(2*alpha):t_step_pulse:t_0+6/sqrt(2*alpha);

%Sinusodial Wave parameters
freq           = 10e3;
lambda         = c/freq;
omega          = 2*pi*freq;
beta           = omega/vp;

sin_step_pulse  = lambda*1e-1;
sin_start_pulse = -3*lambda;
sin_end_pulse = 3*lambda;
sin_window_pulse = sin_start_pulse:sin_step_pulse:sin_end_pulse;
sin_max_amp = A_pulse;
sin_t_step_pulse = 1e-1/freq;
sin_t_window_pulse = -3/freq:sin_t_step_pulse:3/freq;

%guassian pulse
for T = t_window_pulse
    figure(1);
    amplitude1 = gaussian_pulse(A_pulse,alpha,t_0,z_window_pulse,T,vp); %amplitude of gaussian pulse travelling in +z
    amplitude2 = gaussian_pulse(A_pulse,alpha,t_0,z_window_pulse,T,-vp); %amplitude of guassian pulse travelling in -z
    
    subplot(3,1,1)
    plot(z_window_pulse,amplitude1)
    axis([z_start_pulse,z_end_pulse,0,max_amplitude])
    title("Gaussian pulse travelling in +z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    subplot(3,1,2)
    plot(z_window_pulse,amplitude2)
    axis([z_start_pulse,z_end_pulse,0,max_amplitude])
    title("Gaussian pulse travelling in -z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
     
    subplot(3,1,3)
    plot(z_window_pulse,amplitude1+amplitude2)
    axis([z_start_pulse,z_end_pulse,0,2*max_amplitude])
    title("Superposition of the above two pulses");
    xlabel("z(m)");
    ylabel("Amplitude")

    pause(1e-3);
end

%sinusodial wave
for T = sin_t_window_pulse
    figure(1);
    amplitude1 = sinusoidal_wave(A_pulse,omega,sin_window_pulse,T,beta); %amplitude of sinusodial wave travelling in +z
    amplitude2 = sinusoidal_wave(A_pulse,omega,sin_window_pulse,T,-beta); %amplitude of sinusodial wave travelling in -z
    
    subplot(3,1,1)
    plot(sin_window_pulse,amplitude1)
    axis([sin_start_pulse,sin_end_pulse,-max_amplitude,max_amplitude])
    title("Sinusodial wave travelling in +z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
    
    subplot(3,1,2)
    plot(sin_window_pulse,amplitude2)
    axis([sin_start_pulse,sin_end_pulse,-max_amplitude,max_amplitude])
    title("Sinusodial wave travelling in -z direction");
    xlabel("z(m)");
    ylabel("Amplitude")
     
    subplot(3,1,3)
    plot(sin_window_pulse,amplitude1+amplitude2)
    axis([sin_start_pulse,sin_end_pulse,-2*max_amplitude,2*max_amplitude])
    title("Superposition of the above two waves");
    xlabel("z(m)");
    ylabel("Amplitude")

    pause(1e-3);
end

function amplitude = gaussian_pulse(A,alpha,t_0,z,t,vp)
    argument       = -alpha*(t-(z/vp)-t_0).^2;
    amplitude      = A*exp(argument);
end

function amplitude = sinusoidal_wave(A,omega,z,t,beta)
    argument       = omega*t - beta*z;
    amplitude      = A*sin(argument);
end