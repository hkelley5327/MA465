% temperature_regression_project.m

clear
clc
close all

%% Temperature Data

t = (1850:2008)';
t0 = t - 1850; % shift year for numerical stability

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

%% (a) Linear and Quadratic Fits for RAW DATA

p_linear_raw = polyfit(t0,Temp,1);
p_quad_raw = polyfit(t0,Temp,2);

%% (b) Bin Data (n = 10)

bin_size = 10;
N = length(Temp);
num_bins = ceil(N/bin_size);

t_bin = zeros(num_bins,1);
Temp_bin = zeros(num_bins,1);
sigma_bin = zeros(num_bins,1);

for i = 1:num_bins
    
    start_index = (i-1)*bin_size + 1;
    end_index = min(i*bin_size,N);
    
    idx = start_index:end_index;
    
    t_bin(i) = mean(t(idx));
    Temp_bin(i) = mean(Temp(idx));
    sigma_bin(i) = std(Temp(idx));
    
end

t0_bin = t_bin - 1850;

%% Fits for BINNED DATA

p_linear_bin = polyfit(t0_bin,Temp_bin,1);
p_quad_bin = polyfit(t0_bin,Temp_bin,2);

%% Smooth curves for plotting

tfit = linspace(min(t),max(t),400);
tfit0 = tfit - 1850;

linear_raw_fit = polyval(p_linear_raw,tfit0);
quad_raw_fit = polyval(p_quad_raw,tfit0);

linear_bin_fit = polyval(p_linear_bin,tfit0);
quad_bin_fit = polyval(p_quad_bin,tfit0);

%% Chi-Square Calculation (Binned)

linear_bin_vals = polyval(p_linear_bin,t0_bin);
quad_bin_vals = polyval(p_quad_bin,t0_bin);

chi2_linear = sum(((Temp_bin - linear_bin_vals).^2) ./ (sigma_bin.^2));
chi2_quad = sum(((Temp_bin - quad_bin_vals).^2) ./ (sigma_bin.^2));

disp('Chi-square Linear:')
disp(chi2_linear)

disp('Chi-square Quadratic:')
disp(chi2_quad)

%% Delta Chi-Square Test

delta_chi2 = chi2_linear - chi2_quad;
chi2_crit = 6.63;

disp('Delta Chi-square:')
disp(delta_chi2)

if delta_chi2 > chi2_crit
    disp('Quadratic model is necessary at 99% confidence')
else
    disp('Linear model is sufficient')
end

%% Plot Everything

figure
hold on

scatter(t,Temp,12,[0.75 0.75 0.75],'filled')
errorbar(t_bin,Temp_bin,sigma_bin,'mo','MarkerFaceColor','k')

plot(tfit,linear_raw_fit,'b','LineWidth',2)
plot(tfit,quad_raw_fit,'g','LineWidth',2)

plot(tfit,linear_bin_fit,'c--','LineWidth',2)
plot(tfit,quad_bin_fit,'r--','LineWidth',2)

xlabel('Year')
ylabel('Temperature Anomaly')
title('Temperature Regression Analysis')

lin_raw_eq  = sprintf('Linear (Raw): y = %.4fx + %.4f', p_linear_raw(1), p_linear_raw(2));

quad_raw_eq = sprintf('Quadratic (Raw): y = %.6fx^2 + %.4fx + %.4f', ...
                      p_quad_raw(1), p_quad_raw(2), p_quad_raw(3));

lin_bin_eq  = sprintf('Linear (Binned): y = %.4fx + %.4f', ...
                      p_linear_bin(1), p_linear_bin(2));

quad_bin_eq = sprintf('Quadratic (Binned): y = %.6fx^2 + %.4fx + %.4f', ...
                      p_quad_bin(1), p_quad_bin(2), p_quad_bin(3));

legend('Raw Data','Binned Data',...
       lin_raw_eq, quad_raw_eq,...
       lin_bin_eq, quad_bin_eq,...
       'Location','northwest')

grid on