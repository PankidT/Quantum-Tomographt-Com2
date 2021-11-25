clear;clc
x = 2.296200e-01;
y = 3.970800e-01;
z = 8.277400e-01;

[theta, phi, fidelity] = mfd(x, y, z)

function [theta, phi, max_fidelity] = mfd(x, y, z)
    
    i_mat = [1 0; 0 1];
    x_mat = [0 1; 1 0];
    y_mat = [0 -1i; 1i 0];
    z_mat = [1 0; 0 -1];
    rho_cart = 0.5*(i_mat + x_mat*x + y_mat*y + z_mat*z);
    
    theta = atan(y/x);
    phi = atan(sqrt(x^2 + y^2)/z);
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
    for row=1:181
        for col=1:361
            if real(fidel(row,col)) == max_fidelity
                theta = row-1;
                phi = col-1;
            end
        end
    end
    
    [X, Y] = meshgrid(phi_dum, theta_dum);
    Z = real(fidel);
    surf(X, Y, Z, 'FaceAlpha', 1.0, 'EdgeColor', 'none')
    hold on
    idx_h = Z==max_fidelity ;
    h = plot3(X(idx_h),Y(idx_h),Z(idx_h),'.r','markersize', 15);
    legend(h, 'Maximum Fidelity')
    xlabel('Phi');
    ylabel('Theta');
    zlabel('Fidelity');
    title('Fidelity in each point of bloch sphere')
    colorbar
    
end
