%% Battery parameters

%% ModuleType1
% ModuleType1.SOC_vec = [0, .1, .25, .5, .75, .9, 1]; % Vector of state-of-charge values, SOC
% ModuleType1.T_vec = [278, 293, 313]; % Vector of temperatures, T, K
% ModuleType1.V0_vec = [3.5057, 3.566, 3.6337, 3.7127, 3.9259, 4.0777, 4.1928]; % Open-circuit voltage, V0(SOC), V
% ModuleType1.V0_mat = [3.49, 3.5, 3.51; 3.55, 3.57, 3.56; 3.62, 3.63, 3.64; 3.71, 3.71, 3.72; 3.91, 3.93, 3.94; 4.07, 4.08, 4.08; 4.19, 4.19, 4.19]; % Open-circuit voltage, V0(SOC,T), V
% ModuleType1.V_range = [0, inf]; % Terminal voltage operating range [Min Max], V
% ModuleType1.R0_vec = [.0085, .0085, .0087, .0082, .0083, .0085, .0085]; % Terminal resistance, R0(SOC), Ohm
% ModuleType1.R0_mat = [.0117, .0085, .009; .011, .0085, .009; .0114, .0087, .0092; .0107, .0082, .0088; .0107, .0083, .0091; .0113, .0085, .0089; .0116, .0085, .0089]; % Terminal resistance, R0(SOC,T), Ohm
% ModuleType1.AH = 27; % Cell capacity, AH, A*hr

load('batteryTableBased.mat')
ModuleType1.SOC_vecCell = batteryTableBased.parameters.SOC_vec.value;
ModuleType1.T_vecCell   = batteryTableBased.parameters.T_vec.value+273.15; 
ModuleType1.V0_vecCell  = batteryTableBased.parameters.V0_vec.value;
ModuleType1.V0_matCell  = batteryTableBased.parameters.V0_mat.value;
ModuleType1.V_rangeCell = batteryTableBased.parameters.V_range.value;
ModuleType1.R0_vecCell  = batteryTableBased.parameters.R0_vec.value;
ModuleType1.R0_matCell  = batteryTableBased.parameters.R0_mat.value;
ModuleType1.AHCell      = batteryTableBased.parameters.AH.value;

ModuleType1.thermal_massCell = 100; % Thermal mass, J/K
ModuleType1.CoolantResistance = 1.2*5; % Cell level coolant thermal path resistance, K/W
ModuleType1.AmbientResistance = 25*5; % Cell level ambient thermal path resistance, K/W

%% ParallelAssemblyType1
%ParallelAssemblyType1.SOC_vec = [0, .1, .25, .5, .75, .9, 1]; % Vector of state-of-charge values, SOC
%ParallelAssemblyType1.T_vec = [278, 293, 313]; % Vector of temperatures, T, K
%ParallelAssemblyType1.V0_vec = [3.5057, 3.566, 3.6337, 3.7127, 3.9259, 4.0777, 4.1928]; % Open-circuit voltage, V0(SOC), V
%ParallelAssemblyType1.V0_mat = [3.49, 3.5, 3.51; 3.55, 3.57, 3.56; 3.62, 3.63, 3.64; 3.71, 3.71, 3.72; 3.91, 3.93, 3.94; 4.07, 4.08, 4.08; 4.19, 4.19, 4.19]; % Open-circuit voltage, V0(SOC,T), V
%ParallelAssemblyType1.V_range = [0, inf]; % Terminal voltage operating range [Min Max], V
%ParallelAssemblyType1.R0_vec = [.0085, .0085, .0087, .0082, .0083, .0085, .0085]; % Terminal resistance, R0(SOC), Ohm
%ParallelAssemblyType1.R0_mat = [.0117, .0085, .009; .011, .0085, .009; .0114, .0087, .0092; .0107, .0082, .0088; .0107, .0083, .0091; .0113, .0085, .0089; .0116, .0085, .0089]; % Terminal resistance, R0(SOC,T), Ohm
%ParallelAssemblyType1.AH = 27; % Cell capacity, AH, A*hr

ParallelAssemblyType1.SOC_vec = batteryTableBased.parameters.SOC_vec.value;
ParallelAssemblyType1.T_vec   = batteryTableBased.parameters.T_vec.value+273.15; 
ParallelAssemblyType1.V0_vec  = batteryTableBased.parameters.V0_vec.value;
ParallelAssemblyType1.V0_mat  = batteryTableBased.parameters.V0_mat.value;
ParallelAssemblyType1.V_range = batteryTableBased.parameters.V_range.value;
ParallelAssemblyType1.R0_vec  = batteryTableBased.parameters.R0_vec.value;
ParallelAssemblyType1.R0_mat  = batteryTableBased.parameters.R0_mat.value;
ParallelAssemblyType1.AH      = batteryTableBased.parameters.AH.value;

ParallelAssemblyType1.thermal_mass = 100; % Thermal mass, J/K
ParallelAssemblyType1.CoolantResistance = 1.2*5; % Cell level coolant thermal path resistance, K/W
ParallelAssemblyType1.AmbientResistance = 25*5; % Cell level ambient thermal path resistance, K/W

ModuleType1_det.Module1 = ModuleType1;
edge_factor   = 0.3; 
MatAmbM1 = ...
    [edge_factor*ones(12,1) repmat([edge_factor; 1*ones(10,1);edge_factor],1,4)]*ModuleType1.AmbientResistance;

ModuleType1_det.Module1.AmbientResistance = reshape(MatAmbM1',[],1)';

ModuleType1_det.Module2 = ModuleType1;
MatAmbM2 = ...
    [repmat([edge_factor; 1*ones(10,1);edge_factor],1,5)]*ModuleType1.AmbientResistance;
ModuleType1_det.Module2.AmbientResistance = reshape(MatAmbM2',[],1)';

ModuleType1_det.Module3 = ModuleType1_det.Module2;

ModuleType1_det.Module4 = ModuleType1;
MatAmbM4 = fliplr(MatAmbM1);
ModuleType1_det.Module4.AmbientResistance = reshape(MatAmbM4',[],1)';
