clear;clc

% value that come from measurement from Job work.
x = 2.296200e-01;
y = 3.970800e-01;
z = 8.277400e-01;

rho = rho_cart(x, y, z);
theta = find_theta(y, x);
phi = find_phi(x, y, z);
%phi = phi*(180/pi);
%theta = theta*(180/pi);

rho_sp = rho_sphere(theta, phi);
fidel = fidelity(rho, rho_sp);

% --------- print result ---------------
fprintf('rho from measurement is')
rho
fprintf('rho on bloch sphere is')
rho_sp
fprintf('theta and phi are')
theta = theta*(180/pi)
phi = phi*(180/pi)
fprintf('fidelity between measurement and on bloch is')
fidel


% ---------- function ----------------%

function [y] = rho_cart(x, y, z)
    i_mat = [1 0; 0 1];
    x_mat = [0 1; 1 0];     % Paulimatrix
    y_mat = [0 -i; i 0];
    z_mat = [1 0; 0 -1];
    y = 0.5*(i_mat + x_mat*x + y_mat*y + z_mat*z);
end

function [y] = rho_sphere(theta, phi)
    dum1 = cos(theta/2)^2;
    dum2 = exp(-i*phi)*cos(theta/2)*sin(theta/2);
    dum3 = exp(i*phi)*cos(theta/2)*sin(theta/2);
    dum4 = sin(theta/2)^2;
    y = [dum1 dum2; dum3 dum4];
end

%function [theta] = find_theta(rho)
%    theta = 2*acos(acos(rho(1, 1)));
%end
function [theta] = find_theta(y, x)
    theta = atan(y/x);
end

%function [phi] = find_phi(theta, rho)
%    phi = -log(imag(rho(2, 1))*sec(theta/2)*csc(theta/2));
%end
function [phi] = find_phi(x, y, z)
    phi = atan(sqrt(x^2 + y^2)/z);
end

function [y] = fidelity(rho1, rho2)
    fidel = sqrtm(sqrtm(rho1)*rho2*sqrtm(rho1));
    y = fidel(1, 1) + fidel(2, 2);
end