% A Matlab program to simulate random walks of m particles.
% The program displays: 
% (1) the spatial distribution of m particles after n steps of random walks
% (2) trajectories of the first three walkers
% (3) the mean squared displacement as a function of number of steps 

clear;

%% Define parameters 
rng('shuffle'); % seeds the random number generator based on the current time
n = 10^3;       % Number of steps
m = 10^4;       % Number of particles
x = zeros(m, n+1);  % Variable for recording positions of m particles at each time step

%% Main loop
for j = 1:m
    for k = 1:n
        r = rand(1);
        
        if r < 0.5         % steps to the right
            x(j,k+1) = x(j,k) + 1;
            
        elseif r < 1       % steps to the left
            x(j,k+1) = x(j,k) - 1;
    
        end
    end
end


%% Calculate MSD
MSD = mean(x.^2);


%% Create a figure showing the spatial distribution of particles
figure(1); clf;
histogram(x(:,n),31)  % Number of bins = 31
xlabel('Displacement (\delta)');
ylabel('Number of particles');
title(['Spatial distribution of ' num2str(m) ' particles after ' num2str(n) ' steps'])

%% Show trajectories of the first three walkers
figure(2); clf;
plot((0:n),x(1,:),(0:n),x(2,:),(0:n),x(3,:));
xlabel('Number of steps');
ylabel('Displacement (\delta)');
title('Trajectories');
legend('Walker 1','Walker 2','Walker 3');

%% Show MSD
figure(3); clf;
plot((0:n),MSD);
xlabel('Number of steps');
ylabel('MSD (\delta^2)');
title('MSD');

printf('test')
