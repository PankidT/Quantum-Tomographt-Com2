clear;clc
%Determine ideal state
phi_ideal = pi/7;
theta_ideal = pi/2;

x_ideal = sin(theta_ideal)*cos(phi_ideal);
y_ideal = sin(theta_ideal)*sin(phi_ideal);
z_ideal = cos(theta_ideal);

%dit = direct inversion tomography
num_measure = 100000; %determine number of measurement per basis(XYZ)
prepare_err = true; %error of prepared state
if prepare_err
    [x_dit, y_dit, z_dit] = dit_err(phi_ideal,theta_ideal, num_measure);
else
    [x_dit, y_dit, z_dit] = dit(phi_ideal,theta_ideal, num_measure);
end

%Plot Bloch sphere
hold on
ax1 = plot3(x_ideal,y_ideal,z_ideal,'.','MarkerSize',20,'MarkerEdgeColor','green','MarkerFaceColor',[1 .6 .6]);
ax2 = plot3(x_dit,y_dit,z_dit,'.','MarkerSize',20,'MarkerEdgeColor','red','MarkerFaceColor',[1 .6 .6]);

[Xs, Ys, Zs] = sphere ;
mysphere = surf( Xs, Ys, Zs) ;
line([-1 1],[0 0],[0 0],'LineWidth',1,'Color',[0 0 0])
line([0 0],[-1 1],[0 0],'LineWidth',1,'Color',[0 0 0])
line([0 0],[0 0],[-1 1],'LineWidth',1,'Color',[0 0 0])
text(0,0.1,1.1,' z ','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
text(1.1,0,0,' x ','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
text(0,1.1,0,' y ','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
text(0,0,-1.1,'$\left| 1 \right>$','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
text(0,0,1.1,'$\left| 0 \right>$','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
%v = [x_dit y_dit z_dit];
v = [1 0.4 0.2];
[caz,cel] = view(v);
axis equal
shading interp
mysphere.FaceAlpha = 0.25;
xlabel('x', 'FontSize',16)
ylabel('y', 'FontSize',16)
zlabel('z', 'FontSize',16)
legend('Ideal state', 'Direct inversion tomography')
hold off



%direct inversion tomography 
function [x_dit, y_dit, z_dit] = dit(phi_ideal,theta_ideal, N)
    x_ideal = sin(theta_ideal)*cos(phi_ideal);
    y_ideal = sin(theta_ideal)*sin(phi_ideal);
    z_ideal = cos(theta_ideal);
    Nx_up = 0;
    Nx_down = 0;
    Ny_up = 0;
    Ny_down = 0;
    Nz_up = 0;
    Nz_down = 0;
    Px_up = (1+x_ideal)/2 ;
    Py_up = (1+y_ideal)/2;
    Pz_up = (1+z_ideal)/2;
    for n = 1:N
        if rand < Px_up
            Nx_up = Nx_up + 1;
        else 
            Nx_down = Nx_down + 1;
        end
        if rand < Py_up
             Ny_up = Ny_up + 1;
        else
             Ny_down = Ny_down + 1;
        end
        if rand < Pz_up
             Nz_up = Nz_up + 1;
        else
             Nz_down = Nz_down + 1;
        end
    end
    x_dit = (Nx_up-Nx_down)/(Nx_up+Nx_down);
    y_dit = (Ny_up-Ny_down)/(Ny_up+Ny_down);
    z_dit = (Nz_up-Nz_down)/(Nz_up+Nz_down);
end
function [x_dit, y_dit, z_dit] = dit_err(phi_ideal,theta_ideal, N)
    Nx_up = 0;
    Nx_down = 0;
    Ny_up = 0;
    Ny_down = 0;
    Nz_up = 0;
    Nz_down = 0;
    err = pi/3;
    for n = 1:N
        x_ideal = sin(theta_ideal + 2*rand*err-err)*cos(phi_ideal + 2*rand*err-err);
        y_ideal = sin(theta_ideal + 2*rand*err-err)*sin(phi_ideal + 2*rand*err-err);
        z_ideal = cos(theta_ideal + 2*rand*err-err);
        Px_up = (1+x_ideal)/2 ;
        Py_up = (1+y_ideal)/2;
        Pz_up = (1+z_ideal)/2;
        if rand < Px_up
            Nx_up = Nx_up + 1;
        else 
            Nx_down = Nx_down + 1;
        end
        
        if rand < Py_up
             Ny_up = Ny_up + 1;
        else
             Ny_down = Ny_down + 1;
        end
        
        if rand < Pz_up
             Nz_up = Nz_up + 1;
        else
             Nz_down = Nz_down + 1;
        end
    end
    x_dit = (Nx_up-Nx_down)/(Nx_up+Nx_down);
    y_dit = (Ny_up-Ny_down)/(Ny_up+Ny_down);
    z_dit = (Nz_up-Nz_down)/(Nz_up+Nz_down);
end