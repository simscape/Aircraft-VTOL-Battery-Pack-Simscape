%% Create Battery Pack 5p48s8p: 8 Subpacks with 5 Parallel Strings of 48 Cells
%
% The code below automates the creation of a battery pack with electrical
% and thermal connections.  It uses MATLAB commands from the Battery Pack
% Builder to define the pack architecture and create the Simscape blocks
% for use in simulation.
%
% * Fidelity: Grouped, 4-4-4
% * Thermal: No thermal connections
%
% Copyright 2022-2024 The MathWorks, Inc.

%% Import Simscape Battery Package

% Change to folder where this script exists
cd(fileparts(which(mfilename)));
import simscape.battery.builder.*

%% Define Cell

% Mass and geometry
battCell = Cell("Geometry",CylindricalGeometry);
battCell.Geometry.Radius = simscape.Value(21.55/2,'mm');
battCell.Geometry.Height = simscape.Value(70.15,'mm');
battCell.Mass            = simscape.Value(66.9,'g');

% No thermal connections - default
%
%

%% Define Parallel Assembly  

% Connect 5 cells in parallel 
pSet = ParallelAssembly(Cell = battCell, ...
    Rows = 5, NumParallelCells=5, Topology="Square");

% Reuse figure if it exists for battery chart
if ~exist('h1_5p', 'var') || ...
        ~isgraphics(h1_5p, 'figure')
    h1_5p = figure('Name', 'h1_5p');
end
figure(h1_5p); clf(h1_5p)

% Create battery chart
pSetChart = BatteryChart(Parent = h1_5p,...
    Battery=pSet, SimulationStrategyVisible = "On");
xlabel('X');ylabel('Y'); 
title('Battery Cells, 5 Parallel');

%% Define Module 

% Connect 12 parallel sets in series 
batt_5p12s_4g4g4 = Module(ParallelAssembly=pSet, ...
    NumSeriesAssemblies=12);


% Define grouping to control fidelity
batt_5p12s_4g4g4.SeriesGrouping   = [4,4,4]; % Even groups 
batt_5p12s_4g4g4.ParallelGrouping = [1,1,1]; % Same behavior for all cells at ends 

% Reuse figure if it exists for battery chart
if ~exist('h1_5p12s_4g4g4', 'var') || ...
        ~isgraphics(h1_5p12s_4g4g4, 'figure')
    h1_5p12s_4g4g4 = figure('Name', 'h1_5p12s_4g4g4');
end
figure(h1_5p12s_4g4g4); clf(h1_5p12s_4g4g4)

% Create chart
ModuleChart = BatteryChart(Parent = h1_5p12s_4g4g4,...
    Battery=batt_5p12s_4g4g4, SimulationStrategyVisible = "On");
xlabel('X');ylabel('Y'); 
title('Battery Cells, 5 Parallel, 12 Series');

%% Define Module Assembly 

% Connect 4 modules in series
batt_5p48s_4g4g4 = ModuleAssembly(...
    Module = repmat(batt_5p12s_4g4g4,1,4),...
    StackingAxis="X");




% Reuse figure if it exists for battery chart
if ~exist('h1_5p48s_4g4g4', 'var') || ...
        ~isgraphics(h1_5p48s_4g4g4, 'figure')
    h1_5p48s_4g4g4 = figure('Name', 'h1_5p48s_4g4g4');
end
figure(h1_5p48s_4g4g4); clf(h1_5p48s_4g4g4)

% Create chart
BatteryChart(Parent = h1_5p48s_4g4g4,...
    Battery = batt_5p48s_4g4g4, ...
    SimulationStrategyVisible = "On");
xlabel('X');ylabel('Y'); 
title('Battery Cells, 5 Parallel, 48 Series');

%% Define Pack 

% Connect 8 of the module assemblies in parallel
batt_5p48s8p_4g4g4 = Pack(...
    ModuleAssembly=repmat(batt_5p48s_4g4g4,1,8),...
    InterModuleAssemblyGap = simscape.Value(0.1,"m"),...
    CircuitConnection="Parallel",...
    StackingAxis="Y");



% Reuse figure if it exists for battery chart
if ~exist('h1_5p48s8p_4g4g4', 'var') || ...
        ~isgraphics(h1_5p48s8p_4g4g4, 'figure')
    h1_5p48s8p_4g4g4 = figure('Name', '5p48s8p_4g4g4');
end
figure(h1_5p48s8p_4g4g4); clf(h1_5p48s8p_4g4g4)

% Create chart
BatteryChart(Parent = h1_5p48s8p_4g4g4,...
    Battery = batt_5p48s8p_4g4g4, ...
    SimulationStrategyVisible = "On");
xlabel('X');ylabel('Y'); 
title('Battery Cells, 5 Parallel, 48 Series, 8 Parallel');

%% Generate Simscape model for use in Simulink
% If code does not already exist, generate code to produce Simscape block,
% Simulink library that assembles components into sub packs and packs,
% parameters for cell behavior, and parameters for initial conditions.
if(~exist('+pack_5p48s8p_4g4g4_Iso','dir'))
    buildBattery(batt_5p48s8p_4g4g4,...
        "LibraryName","pack_5p48s8p_4g4g4_Iso",...
        "MaskInitialTargets","VariableNames",...
        "MaskParameters","VariableNames")
end