% SIR MODEL SIMULATIONS

% Fixed parameters
N    = 1000;
beta = 1;        % day^-1
y0   = 100;      % initial infections

% Initial conditions
S0 = N - y0;
I0 = y0;
R0 = 0;
Y0 = [S0; I0; R0];

% Time span (days)
tspan = [0 30];

% Recovery rates
mu_values = [0.5, 1.1, 0.1];

% Loop over cases
for k = 1:length(mu_values)

    mu = mu_values(k);

    % Extend time span for slow recovery case
    if mu == 0.1
        tspan = [0 80];   % allow plateau to appear
    else
        tspan = [0 30];
    end

    % Solve ODE system
    [t, Y] = ode45(@(t,Y) model(t, Y, beta, mu, N), tspan, Y0);

    S = Y(:,1);
    I = Y(:,2);
    R = Y(:,3);

    % Plot results
    figure;
    plot(t, S, 'b', 'LineWidth', 2); hold on;
    plot(t, I, 'r', 'LineWidth', 2);
    plot(t, R, 'g', 'LineWidth', 2);
    grid on;

    xlabel('Time (days)');
    ylabel('Number of individuals');
    legend('Susceptible', 'Infected', 'Recovered');

    title(sprintf('SIR Model Simulation (\\mu = %.1f day^{-1})', mu));
end

% SIR model function
function dYdt = model(t, Y, beta, mu, N)
    S = Y(1);
    I = Y(2);
    R = Y(3);

    dSdt = -beta * S * I / N;
    dIdt =  beta * S * I / N - mu * I;
    dRdt =  mu * I;

    dYdt = [dSdt; dIdt; dRdt];
end
