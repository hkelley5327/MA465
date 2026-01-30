% Temperature vs Year (Table 1.7)

t = (1850:2008)';

Temp = [
-0.402; -0.315; -0.345; -0.368; -0.321; -0.291; -0.438; -0.491; -0.529; -0.424;
-0.378; -0.568; -0.616; -0.386; -0.434; -0.295; -0.287; -0.336; -0.16; -0.264;
-0.257; -0.265; -0.262; -0.296; -0.412; -0.328; -0.33; 0.015; 0.031; -0.222;
-0.21; -0.229; -0.211; -0.242; -0.325; -0.34; -0.261; -0.33; -0.249; -0.15;
-0.378; -0.332; -0.381; -0.453; -0.391; -0.313; -0.15; -0.185; -0.386; -0.235;
-0.142; -0.257; -0.384; -0.477; -0.501; -0.321; -0.281; -0.446; -0.529; -0.564;
-0.559; -0.566; -0.476; -0.463; -0.322; -0.225; -0.461; -0.538; -0.354; -0.387;
-0.323; -0.287; -0.374; -0.335; -0.364; -0.279; -0.184; -0.253; -0.24; -0.372;
-0.173; -0.141; -0.177; -0.349; -0.199; -0.203; -0.161; -0.046; -0.028; 0.008;
0.013; 0.066; -0.055; -0.038; 0.087; -0.03; -0.221; -0.202; -0.245; -0.23;
-0.339; -0.172; -0.088; -0.055; -0.23; -0.291; -0.326; -0.089; -0.023; -0.114;
-0.137; -0.044; -0.033; -0.047; -0.315; -0.219; -0.157; -0.151; -0.129; -0.004;
-0.072; -0.178; -0.054; 0.06; -0.226; -0.134; -0.229; 0.059; -0.049; 0.056;
0.102; 0.13; 0.008; 0.187; -0.011; -0.018; 0.022; 0.167; 0.163; 0.096;
0.248; 0.197; 0.055; 0.102; 0.163; 0.276; 0.123; 0.355; 0.515; 0.262;
0.238; 0.4; 0.455; 0.457; 0.432; 0.479; 0.422; 0.404; 0.296
];

% Linear Best-Fit
p = polyfit(t, Temp, 1);
Temp_fit = polyval(p, t);

% Linear Fit Equation
eqn = sprintf('Linear Fit: T = %.4f t %+ .4f', p(1), p(2));

% Correlation Coefficient
cov_matrix_temp = cov(t, Temp);        % 2x2 covariance matrix
r_temp = cov_matrix_temp(1,2) / sqrt(cov_matrix_temp(1,1) * cov_matrix_temp(2,2));

% Plot Temperature
figure
set(gcf,'Color','k')
ax = gca;
set(ax,'Color','k','XColor','w','YColor','w')

plot(t, Temp, 'o', ...
    'Color', [0.3 0.9 1], ...
    'MarkerFaceColor', [0.3 0.9 1], ...
    'MarkerSize', 4, ...
    'DisplayName', 'Measured Data')
hold on
plot(t, Temp_fit, '-', ...
    'LineWidth', 2.5, ...
    'Color', [1 0.6 0], ...
    'DisplayName', eqn)

xlabel('Year','Color','w')
ylabel('Temperature Change','Color','w')
legend('TextColor','w','Location','northwest')
grid on
set(gca,'GridColor',[0.5 0.5 0.5])

% CO2 vs Year (Table 1.8)
t2 = (1959:2007)';

CO2 = [
315.98; 316.91; 317.64; 318.45; 318.99; 319.62; 320.04; 321.38; 322.16; 323.04;
324.62; 325.68; 326.32; 327.45; 329.68; 330.17; 331.08; 332.05; 333.78; 335.41;
336.78; 338.68; 340.11; 341.22; 342.84; 344.41; 345.87; 347.19; 348.98; 351.45;
352.90; 354.16; 355.48; 356.27; 356.95; 358.64; 360.62; 362.36; 363.47; 366.50;
368.14; 369.40; 371.07; 373.17; 375.78; 377.52; 379.76; 381.85; 383.71
];

% Linear and Quadratic Fits
p_lin = polyfit(t2, CO2, 1);
CO2_lin = polyval(p_lin, t2);

p_quad = polyfit(t2, CO2, 2);
CO2_quad = polyval(p_quad, t2);

% Equations
eqn_lin  = sprintf('Linear Fit: CO_2 = %.4f t %+ .2f', p_lin(1), p_lin(2));
eqn_quad = sprintf('Quadratic Fit: CO_2 = %.6f t^2 %+ .4f t %+ .2f', ...
                   p_quad(1), p_quad(2), p_quad(3));

% Correlation Coefficient
cov_matrix_CO2 = cov(t2, CO2);         % 2x2 covariance matrix
r_CO2 = cov_matrix_CO2(1,2) / sqrt(cov_matrix_CO2(1,1) * cov_matrix_CO2(2,2));

% Plot CO2
figure
set(gcf,'Color','k')
ax = gca;
set(ax,'Color','k','XColor','w','YColor','w')

plot(t2, CO2, 'o', ...
    'Color', [0.3 0.9 1], ...
    'MarkerFaceColor', [0.3 0.9 1], ...
    'MarkerSize', 4, ...
    'DisplayName', 'Measured CO_2')
hold on
plot(t2, CO2_lin, '-', ...
    'LineWidth', 2.5, ...
    'Color', [1 0.6 0], ...
    'DisplayName', eqn_lin)
plot(t2, CO2_quad, '--', ...
    'LineWidth', 1.2, ...
    'Color', [0.7 0.6 1], ...
    'DisplayName', eqn_quad)

xlabel('Year','Color','w')
ylabel('CO_2 Concentration (ppm)','Color','w')
legend('TextColor','w','Location','northwest')
grid on
set(gca,'GridColor',[0.5 0.5 0.5])

% Correlation Coefficients Table
corr_fig = figure('Color','k','Name','Correlation Coefficients');

t_fig = uitable('Data', [r_temp; r_CO2], ...
                'RowName', {'Temperature','CO_2'}, ...
                'ColumnName', {'Correlation r'}, ...
                'ColumnWidth',{150}, ...
                'Units','normalized', ...
                'Position',[0 0 1 1]);

t_fig.BackgroundColor = [0.1 0.1 0.1; 0.2 0.2 0.2];  % alternating dark gray rows
t_fig.ForegroundColor = [1 1 1];                     % white text
t_fig.FontSize = 14;
