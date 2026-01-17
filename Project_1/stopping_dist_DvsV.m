% Original data
V_mph = [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]; % mph
D_ft  = [27 44 63 85 109 135 164 195 229 265 303 344 387 433 481 531 584 639 696]; % feet

% Convert to SI units
V = V_mph * 0.44704;  % velocity in m/s
D = D_ft * 0.3048;    % distance in meters

%% --- Figure 1: D vs V with linear best fit ---
figure(1)
scatter(V, D, 70, 'filled')
hold on
p1 = polyfit(V, D, 1);       % Linear fit
Vfine = linspace(min(V), max(V), 200);
Dfit = polyval(p1, Vfine);
plot(Vfine, Dfit, 'LineWidth', 2)
xlabel('Velocity V (m/s)')
ylabel('Stopping Distance D (m)')
title('D vs V with Linear Best Fit')
grid on
legend('Data', sprintf('Best Fit: D = %.3f V + %.3f', p1(1), p1(2)), 'Location','northwest')

%% --- Figure 2: Relative error of D vs V fit ---
Dmodel1 = polyval(p1, V);
rel_error1 = abs((Dmodel1 - D) ./ D) * 100;
figure(2)
plot(V, rel_error1, 'o-', 'LineWidth', 2, 'MarkerFaceColor','b')
yline(0,'--')
xlabel('Velocity V (m/s)')
ylabel('Relative Error (%)')
title('Relative Error of Linear Fit for D vs V')
grid on

%% --- Figure 3: D/v vs V with linear best fit ---
D_over_v = D ./ V;
figure(3)
scatter(V, D_over_v, 70, 'filled')
hold on
p2 = polyfit(V, D_over_v, 1);  % Linear fit
D_over_v_fit = polyval(p2, Vfine);
plot(Vfine, D_over_v_fit, 'LineWidth', 2)
xlabel('Velocity V (m/s)')
ylabel('Stopping Distance per Velocity D/V (s)')
title('D/V vs V with Linear Best Fit')
grid on
legend('Data', sprintf('Best Fit: D/V = %.4f V + %.4f', p2(1), p2(2)), 'Location','northwest')

%% --- Figure 4: Relative error of D/v vs V fit ---
Dmodel2 = polyval(p2, V);
rel_error2 = abs((Dmodel2 - D_over_v) ./ D_over_v) * 100;
figure(4)
plot(V, rel_error2, 'o-', 'LineWidth', 2, 'MarkerFaceColor','r')
yline(0,'--')
xlabel('Velocity V (m/s)')
ylabel('Relative Error (%)')
title('Relative Error of Linear Fit for D/V vs V')
grid on
