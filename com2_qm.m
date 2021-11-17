clear;clc
phi_ideal = pi/3;
theta_ideal = pi/6;
x_ideal = sin(theta_ideal)*cos(phi_ideal);
y_ideal = sin(theta_ideal)*sin(phi_ideal);
z_ideal = cos(theta_ideal);
%dit = direct inversion tomography
[x_dit, y_dit, z_dit] = dit(phi_ideal,theta_ideal);
%md = minimum distance
[x_md, y_md, z_md] = minimumdistance(x_dit,y_dit,z_dit);
hold on
ax1 = plot3(x_dit,y_dit,z_dit,'o','MarkerSize',5,'MarkerEdgeColor','red','MarkerFaceColor',[1 .6 .6]);
line([x_md x_dit],[y_md y_dit],[z_md z_dit],'Color',[1 0 0])
ax2 = plot3(x_md,y_md,z_md,'o','MarkerSize',5,'MarkerEdgeColor','blue','MarkerFaceColor',[1 .6 .6]);
[Xs, Ys, Zs] = sphere ;
mysphere = surf( Xs, Ys, Zs) ;
line([-1 1],[0 0],[0 0],'LineWidth',1,'Color',[0 0 0])
line([0 0],[-1 1],[0 0],'LineWidth',1,'Color',[0 0 0])
line([0 0],[0 0],[-1 1],'LineWidth',1,'Color',[0 0 0])
text(0,0,1.1,' z ','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
text(1.1,0,0,' x ','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
text(0,1.1,0,' y ','Interpreter','latex','FontSize',20,'HorizontalAlignment','Center')
v = [x_dit y_dit z_dit];
[caz,cel] = view(v);
axis equal
shading interp
mysphere.FaceAlpha = 0.25;
xlabel('x', 'FontSize',16)
ylabel('y', 'FontSize',16)
zlabel('z', 'FontSize',16)

hold off
% legend(ax1,ax2,{'predicted point'},{'surface point at minimum distance'})
legend('predicted point','','surface point at minimum distance')
fprintf(" x predict is %d\n y predict is %d\n z predict is %d\n",x_dit,y_dit,z_dit)
fprintf(" Real x is %d\n Real y is %d\n Real z is %d\n",x_ideal,y_ideal,z_ideal)


%direct inversion tomography 
function [x_dit, y_dit, z_dit] = dit(phi_ideal,theta_ideal)
x_ideal = sin(theta_ideal)*cos(phi_ideal);
y_ideal = sin(theta_ideal)*sin(phi_ideal);
z_ideal = cos(theta_ideal);
N = 30; %จำนวนรอบที่วัด xyz
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


%minimum distance 
function [x_md, y_md, z_md] = minimumdistance(x_dit,y_dit,z_dit)
r=sqrt(x_dit^2+y_dit^2+z_dit^2);
phi_md=atan2(y_dit,x_dit);
theta_md=acos(z_dit/r);
x_md =sin(theta_md)*cos(phi_md);
y_md =sin(theta_md)*sin(phi_md);
z_md =cos(theta_md);
end
