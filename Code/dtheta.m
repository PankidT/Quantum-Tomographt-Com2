clear;clc
x_dit = 0
y_dit = 0
z_dit = 0.9
%update weights
theta_initial = pi*rand ;
phi_initial = 2*pi*rand ;
alpha = 0.05;
phi = phi_initial;
theta = theta_initial;
N=1000
for i = 1:N
    theta = theta - alpha*dtheta1(x_dit,y_dit,z_dit,theta,phi);
    phi = phi - alpha*dphi(x_dit,y_dit,theta,phi);
    distance_square(i) = (x_dit-sin(theta)*cos(phi))^(2) + (y_dit-sin(theta)*sin(phi))^(2) + (z_dit-cos(theta))^(2);
end
plot(1:N, distance_square);

function d = devtheta(x,y,z,theta,phi)
    d = 2*(z*sin(theta) + (-y*sin(phi)-x*cos(phi))*cos(theta));
end

function d = devphi(x,y,theta,phi)
d = 2*sin(theta)*(x*sin(phi)-y*cos(phi));
end
