% Code to sweep payload mass and battery for electric aircraft examples
% and plot results.
%
% Copyright 2017-2022 The MathWorks, Inc.

% Minimum range for aircraft for plot
min_range = 25;  % km

% Test set for battery capacity
battery_capacity_set = [100:20:200];
payload_set = [0:10:120];

if(~exist('battery_pdensity_set','var'))
    % If not defined, do not use parallel
    battery_pdensity_set = 200;
end

% Code can be used on different models
if (~exist('modelname','var'))
    modelname = 'ssc_airvtol_elec_battery';
end

open_system(modelname)

% Store simulation inputs
clear simInput
temp_run_num = 0;

for temp_bc_i = 1:length(battery_capacity_set)
    for temp_pay_i = 1:length(payload_set)
        temp_run_num = temp_run_num+1;
        simInput(temp_run_num) = Simulink.SimulationInput(modelname);
        simInput(temp_run_num) = simInput(temp_run_num).setVariable('battery_pdensity',battery_pdensity_set);
        simInput(temp_run_num) = simInput(temp_run_num).setVariable('battery_capacity',battery_capacity_set(temp_bc_i));
        simInput(temp_run_num) = simInput(temp_run_num).setVariable('payload_mass_workspace',payload_set(temp_pay_i));
    end
end

% Run simulation using Fast Restart
simOut = [];

if(~exist('doParallelSweep','var'))
    % If not defined, do not use parallel
    doParallelSweep = false;
end

if(~doParallelSweep)
    simOut = sim(simInput,'ShowProgress','off','UseFastRestart','on');
else
    timerVal = tic;
    simOut = parsim(simInput,'ShowSimulationManager','on',...
        'ShowProgress','on','UseFastRestart','on',...
        'AttachedFiles',{'ssc_airvtol_elec_default_params_battery.m'},...
        'SetupFcn',@()evalin('base','ssc_airvtol_elec_default_params_battery'));
    Elapsed_Time_Time_parallel  = toc(timerVal);
end
clear doParallelSweep

temp_run_num = 0;
for temp_bc_i = 1:length(battery_capacity_set)
    for temp_pay_i = 1:length(payload_set)
        temp_run_num = temp_run_num+1;
        temp_dist_payl_ele(temp_pay_i,temp_bc_i) = simOut(temp_run_num).Distance(end);
        temp_dura_payl_ele(temp_pay_i,temp_bc_i) = simOut(temp_run_num).tout(end);
    end
end

%% Plot simulation results
% Prepare figure windows
if ~exist('h8_ssc_airvtol_elec_battery', 'var') || ...
        ~isgraphics(h8_ssc_airvtol_elec_battery, 'figure')
    h8_ssc_airvtol_elec_battery = figure('Name', 'ssc_airvtol_elec');
end
figure(h8_ssc_airvtol_elec_battery)
clf(h8_ssc_airvtol_elec_battery)

% Plot results
[payGrid,battGrid] = meshgrid(payload_set,battery_capacity_set);
temp_s1_h =surf(battGrid,payGrid,temp_dist_payl_ele');
temp_s1_h.EdgeColor='none';
hold on
temp_s2_h =surf(battGrid([1 end]),payGrid([1 end]),min_range*ones(2));
set(temp_s2_h,'FaceColor',[1 1 1]*0.2,'FaceAlpha',0.8)
hold off
text(0.35,0.9,0.9,sprintf('%s < %d km','Range',min_range),...
    'Units','Normalized',...
    'HorizontalAlignment','center',...
    'Color','w','FontWeight','Bold','FontSize',12)

% Top view for overview of design space
view(0,90)
xlabel('Battery Capacity (A*hr)');
ylabel('Payload (kg)');
title('Sweep Battery Capacity, Payload')
clb_h = colorbar;
clb_h.Label.String = 'Flight Range (km)';
colormap(flipud(cool))

clear temp_s1_h temp_s2_h clb_h temp_annotation_str
clear simlog_handles
