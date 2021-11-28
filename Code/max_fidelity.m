% clear;clc
% r_dit = 1;
% phi_dit = pi/7;
% theta_dit = 0;
% 
% x_dit = r_dit*sin(theta_dit)*cos(phi_dit);
% y_dit = r_dit*sin(theta_dit)*sin(phi_dit);
% z_dit = r_dit*cos(theta_dit);

[x_mfd,y_mfd,z_mfd] = mfd(x_dit, y_dit, z_dit);

function [x_mfd,y_mfd,z_mfd] = mfd(x_dit, y_dit, z_dit)
    
    i_mat = [1 0; 0 1];
    x_mat = [0 1; 1 0];
    y_mat = [0 -1i; 1i 0];
    z_mat = [1 0; 0 -1];
    rho_cart = 0.5*(i_mat + x_mat*x_dit + y_mat*y_dit + z_mat*z_dit);
    
    theta_dit = atan2(y_dit,x_dit);
    phi_dit = acos(z_dit/sqrt(x_dit^2+y_dit^2+z_dit^2));
    theta_dum = linspace(0, 180, 181);
    phi_dum = linspace(0, 360, 361);
    
    index_theta=0;
    index_phi=0;
    for iter_theta = 0:180 
        index_theta = index_theta + 1;
        temp_theta = iter_theta*(pi/180);
        for iter_phi = 0:360 
            index_phi = index_phi + 1;
            temp_phi = iter_phi*(pi/180);
            
            dum1 = cos(temp_theta/2)^2;
            dum2 = exp(-1i*temp_phi)*cos(temp_theta/2)*sin(temp_theta/2);
            dum3 = exp(1i*temp_phi)*cos(temp_theta/2)*sin(temp_theta/2);
            dum4 = sin(temp_theta/2)^2;
            rho_sp = [dum1 dum2; dum3 dum4];
            
            fidelity = sqrtm(sqrtm(rho_cart)*rho_sp*sqrtm(rho_cart));
            fidelity = fidelity(1,1)+fidelity(2,2);
            
            fidel(index_theta, index_phi) = fidelity;
        end
        index_phi=0;
    end
    
    max_fidelity = max(max(real(fidel)));
    [X, Y] = meshgrid(phi_dum, theta_dum);
    Z = real(fidel);
    surf(X, Y, Z, 'FaceAlpha', 1.0, 'EdgeColor', 'none')
    hold on
    idx_h = Z==max_fidelity ;
    h = plot3(X(idx_h),Y(idx_h),Z(idx_h),'.r','markersize', 15);
    a = plot3(theta_dit*180/pi,phi_dit*180/pi,1,'.b','markersize', 15);
    legend(h, 'Maximum Fidelity')
    xlabel('Phi');
    ylabel('Theta');
    zlabel('Fidelity');
    title('Fidelity in each point of bloch sphere');
    colorbar
    theta_mfd = Y(idx_h)*pi/180
    phi_mfd = X(idx_h)*pi/180
    x_mfd = sin(theta_mfd)*cos(phi_mfd);
    y_mfd = sin(theta_mfd)*sin(phi_mfd);
    z_mfd = cos(theta_mfd);
end