clc;
clear;
close all;

% VARIATION 00: K = 50, Rin = 0.5, Rout = 2.25

% PART 1

K = 50;
I = 5;
R_in = 0.5e-2;  
R_out = 2.25e-2;
R_av = 0.5*(R_in+R_out);
a = (R_out-R_in)/2;
NumbOfSegs = 4000;
X_plot_points = 20;
Y_plot_points = 20;
extent = R_out + 0.1*R_out;
X_min = -extent;
X_max = extent;
Y_min = -extent;
Y_max = extent;
[X_data,Y_data] = meshgrid(linspace(X_min,X_max,X_plot_points+1),linspace(Y_min,Y_max,Y_plot_points+1));
z_plot = 0;
H_x = zeros(Y_plot_points+1,X_plot_points+1);
H_y = zeros(Y_plot_points+1,X_plot_points+1);

% PART 2
for j=1:(X_plot_points+1)
    for i=1:(Y_plot_points+1)
        X_current = X_data(i,j);
        Y_current = Y_data(i,j);
        R_obs = [X_current Y_current z_plot];
        
% PART 3
        for n=1:NumbOfSegs-1
            alpha_n = ((2*pi*K)*(n-1))/NumbOfSegs;
            phi_n = 2*pi*(n-1)/NumbOfSegs;
            r_n = R_av + a*cos(alpha_n);
            X_s = r_n*cos(phi_n);
            Y_s = r_n*sin(phi_n);
            Z_s = -a*sin(alpha_n);
            
            alpha_n_plus = ((2*pi*K)*(n))/NumbOfSegs;
            phi_n_plus = 2*pi*(n)/NumbOfSegs;
            r_n_plus = R_av + a*cos(alpha_n_plus);
            X_e = r_n_plus*cos(phi_n);
            Y_e = r_n_plus*sin(phi_n);
            Z_e = -a*sin(alpha_n_plus);
            
% PART 4
            delta_l = [(X_e-X_s) (Y_e-Y_s) (Z_e-Z_s)];
            R_center = 0.5*[(X_s+X_e) (Y_s+Y_e) (Z_s+Z_e)];
            R = R_obs - R_center;
            mag_R = norm(R);
            unit_R = R/mag_R;
            dH = (I/(4*pi*(mag_R^2)))*cross(delta_l,unit_R);
            H_x(i,j) = H_x(i,j) + dH(1,1);
            H_y(i,j) = H_y(i,j) + dH(1,2);
        end
    end
end

quiver(X_data,Y_data,H_x,H_y);
axis equal;
axis([-4e-2 4e-2 -4e-2 4e-2]);
xlabel('x(m)');
ylabel('y(m)');
grid on;