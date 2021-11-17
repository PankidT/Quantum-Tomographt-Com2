
clear;clc
theta = 0; 
phi = 0;
real_state = rho_cart(0, 0, 1);
fidelity_collect = [];
theta_collect = {};
phi_collect = {}

for theta_loop = 1:180
    theta = theta+1;
    for phi_loop = 1:360
        phi = phi+1;
        fidelity_collect = [fidelity_collect, fidelity(real_state, rho_sphere(theta*(pi/180), phi*(pi/180)))];
        theta_collect = [theta_collect, theta];
        phi_collect = [phi_collect, phi];
    end
end

function [y] = rho_cart(x, y, z)
    i_mat = [1 0; 0 1];
    x_mat = [0 1; 1 0];     % Paulimatrix
    y_mat = [0 -i; i 0];
    z_mat = [1 0; 0 -1];
    y = 0.5*(i_mat + x_mat*x + y_mat*y + z_mat*z);
end

function [y] = rho_sphere(theta, phi)
    mat_11 = cos(theta/2)^2;
    mat_12 = exp(-i*phi)*cos(theta/2)*sin(theta/2);
    mat_21 = exp(i*phi)*cos(theta/2)*sin(theta/2);
    mat_22 = sin(theta/2)^2;
    y = [mat_11 mat_12; mat_21 mat_22];
end

function [y] = fidelity(rho1, rho2)
    fidel = sqrtm(sqrtm(rho1)*rho2*sqrtm(rho1));
    y = fidel(1, 1) + fidel(2, 2);
end