clc;
clear;
close all;

eps = 8.854e-12;

r1 = 0.01;
r2 = 0.02;
rho_s = 3e-9;
rho_1 = rho_s*(2*pi*r1);

PlotXmin = -0.025;
PlotXmax = 0.025;
PlotYmin = -0.025;
PlotYmax = 0.025;

NumOfXPlotPoints = 40;
NumOfYPlotPoints = 40;

PlotStepX = (PlotXmax - PlotXmin) / (NumOfXPlotPoints-1);
PlotStepY = (PlotYmax - PlotYmin) / (NumOfYPlotPoints-1);

NumOfXPlotPoints2 = 200;
NumOfYPlotPoints2 = 200;

[X,Y] = meshgrid(PlotXmin:PlotStepX:PlotXmax,PlotYmin:PlotStepY:PlotYmax);

Fx = zeros(NumOfYPlotPoints,NumOfXPlotPoints);
Fy = zeros(NumOfYPlotPoints,NumOfXPlotPoints);
Fz = zeros(NumOfYPlotPoints,NumOfXPlotPoints);

PlotStepX2 = (PlotXmax - PlotXmin) / (NumOfXPlotPoints2-1);
PlotStepY2 = (PlotYmax - PlotYmin) / (NumOfYPlotPoints2-1);

[X2,Y2] = meshgrid(PlotXmin:PlotStepX2:PlotXmax,PlotYmin:PlotStepY2:PlotYmax);

V = zeros(NumOfXPlotPoints2,NumOfYPlotPoints2);

C = [0 0];
F = [0 0];

for j=1:NumOfYPlotPoints
    for i=1:NumOfXPlotPoints
        Xplot = X(j,i);
        Yplot = Y(j,i);
        
        p = [Xplot Yplot];
        R = p-C;
        Rmag = norm(R);
        if Rmag < r2 && Rmag > r1
            R_Hat = R/Rmag;
            E = R_Hat*rho_1/(2*pi*Rmag*eps);
            Fx(j,i) = E(1,1);
            Fy(j,i) = E(1,2);
        end
    end
end

for j=1:NumOfYPlotPoints2
    for i=1:NumOfXPlotPoints2
        Xplot2 = X2(j,i);
        Yplot2 = Y2(j,i);
        
        p = [Xplot2 Yplot2];
        R = p-C;
        Rmag = norm(R);
        if Rmag > r1 && Rmag < r2
            V(j,i) = rho_1/(2*pi*eps)*log(r2/Rmag);
        elseif Rmag <= r1
            V(j,i) = rho_1/(2*pi*eps)*log(r2/r1);
        end
    end
end

figure;

quiver(X,Y,Fx,Fy);

hold on;

[C,h] = contour(X2,Y2,V);
set(h,'ShowText','on','TextStep',get(h,'LevelStep'));
pbaspect([1 1 1])
xlabel('x(m)');
ylabel('y(m)');        