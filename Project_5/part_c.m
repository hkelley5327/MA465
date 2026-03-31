% Part B
clear; clc;

% Parameters
C = 0.1;
s = 2;
B0_vec = [0.1, 1, 1.05];

t_end = 40;
n = 0:t_end;

figure;

for i = 1:length(B0_vec)
    
    B0 = B0_vec(i);
    
    % Compute A using Eq. (5.74)
    A = (2/B0) - sqrt((4/B0)*(C/s - 1 + 1/B0));
    
    % Compute B
    B = -(B0/4)*(A^2);
    
    % Initialize y
    y = zeros(1, length(n));
    
    % Initial conditions
    y(1) = 0.1;   % y_0
    y(2) = 0.2;   % y_1
    
    % Difference equation
    for k = 3:length(n)
        y(k) = A*y(k-1) + B*y(k-2) + C;
    end
    
    % Plot
    subplot(1,3,i)
    plot(n, y, 'LineWidth', 2)
    grid on
    
    title(['B_0 = ', num2str(B0)])
    xlabel('n')
    ylabel('y_n')
    
    ylim([0 3])
    xlim([0 40])
end
% ------------------------------------------------------------------------
% Part C
t_max = 50; % Number of time periods
t = 0:t_max;

% Define Parameters
alpha_B = 0.5; beta_B = 1; 
alpha_C = 0.6; beta_C = 2;
alpha_D = 0.8; beta_D = 4;

figure;

% --- Plot Region B (Linear Scale) ---
subplot(3,1,1);
plot(t, run_samuelson(alpha_B, beta_B, t_max), 'b', 'LineWidth', 1.5);
title('Region B: Damped Oscillations (\alpha=0.5, \beta=1)');
ylabel('Income (Y)');
grid on;

% --- Plot Region C (Linear Scale) ---
subplot(3,1,2);
plot(t, run_samuelson(alpha_C, beta_C, t_max), 'r', 'LineWidth', 1.5);
title('Region C: Explosive Oscillations (\alpha=0.6, \beta=2)');
ylabel('Income (Y)');
grid on;

% --- Plot Region D (Logarithmic Scale) ---
subplot(3,1,3);
% Use semilogy to make the y-axis powers of 10
semilogy(t, run_samuelson(alpha_D, beta_D, t_max), 'g', 'LineWidth', 1.5);
title('Region D: Monotonic Explosion (Log Scale: Powers of 10) (\alpha=0.8, \beta=4)');
ylabel('Income (Log Y)');
xlabel('Time (t)');
grid on;

% Difference Equation Function
function Y = run_samuelson(a, b, t_max)
    Y = zeros(1, t_max + 1);
    Y(1) = 1; % Setting Y_0 to 1 to avoid log(0) issues in Region D
    Y(2) = 2; 
    for t = 3:t_max+1
        Y(t) = a*(1+b)*Y(t-1) - a*b*Y(t-2) + 1;
    end
end

% ------------------------------------------------------------------------
% Part D
clc; clear; close all;

% Parameters
A = 4;        % Samuelson coefficient
B = 0;        % Samuelson coefficient
C = 0;        % Samuelson constant term
y0 = 1;       % Initial value for Samuelson
P0 = 1;       % Initial principal for compound interest
t_max = 20;   % Number of periods (longer time)
t = 0:t_max;

% Samuelson model solution (B=C=0)
y = y0 * A.^t;

% Compound interest solution with p = A-1
p = A - 1;            % Interest rate
P = P0 * (1 + p).^t;  % Compound interest

% Plotting (logarithmic y-scale)
figure;
semilogy(t, y, 'o-', 'LineWidth', 2, 'MarkerSize', 8);  % Samuelson
hold on;
semilogy(t, P, 's--', 'LineWidth', 2, 'MarkerSize', 8); % Compound interest

xlabel('Time period t');
ylabel('Value (log scale)');
title('Samuelson Model vs Compound Interest (Log Scale)');
legend('Samuelson y_t', 'Compound Interest P_t', 'Location', 'northwest');