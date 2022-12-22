%% Battery Module Assembly Test Harness
%
% This example models a testrig for a battery module assembly, one of eight
% sub-packs in electric aircraft battery pack.  It enables rapid
% exploration of the design of the battery and cooling system.
%
% In this model, a load case for the battery is defined as the current
% drawn from the battery over time.  The current draw is based on the
% current measured during a mission in the main model.
% 
% The battery model can be configured to varying levels of granularity.
% All cells in a module can be treated as if they have the same thermal
% conditions, or we can increase the number of cells with unique
% conditions, such as treating the cells on the edge of the module
% assembly uniquely as they have a larger surface area exposed to ambient
% via the pack housing.
%
% The cooling plate can also be modeled at vary levels of fidelity and
% granularity. The most abstract model simply defines the plate as a
% boundary condition, specifying the temperature gradient across the
% module. The cooling plate can also be modeled as fluid flow through
% channels, and the number of thermal elements in the plate can be
% increased to capture the temperature gradient within the plate in more
% detail.
%
% Copyright 2022 The MathWorks, Inc.

%% Model
%
% In this model, a load case for the battery is defined as the current
% drawn from the battery over time.  The current draw is based on the
% current measured during a mission in the main model.

open_system('test_loadcase_moduleAssy_harness')

set_param(find_system('test_loadcase_moduleAssy_harness','MatchFilter',@Simulink.match.allVariants,'FindAll', 'on','type','annotation','Tag','ModelFeatures'),'Interpreter','off')

%% Module Assembly Options
%
% The battery model can be configured to varying levels of granularity.
% All cells in a module can be treated as if they have the same thermal
% conditions, or we can increase the number of cells with unique
% conditions, such as treating the cells on the edge of the module
% assembly uniquely as they have a larger surface area exposed to ambient
% via the pack housing.
%
% <matlab:open_system('test_loadcase_moduleAssy_harness');open_system('test_loadcase_moduleAssy_harness/ModuleAssembly1','force');Open Subsystem>

set_param('test_loadcase_moduleAssy_harness/ModuleAssembly1','LinkStatus','none')
open_system('test_loadcase_moduleAssy_harness/ModuleAssembly1','force')

%% Module Assembly
%
% The battery module assembly consists of four modules, each with a single
% thermal connection to ambient and an array of independent thermal
% connections to the cooling plate.  The arrays of thermal connections to
% the cooling plate are assembled into a single array which is then
% connected to the cooling plate.
%
% <matlab:open_system('test_loadcase_moduleAssy_harness');open_system('test_loadcase_moduleAssy_harness/ModuleAssembly1/Lumped','force');Open Subsystem>

set_param('test_loadcase_moduleAssy_harness/ModuleAssembly1/Lumped','LinkStatus','none')
open_system('test_loadcase_moduleAssy_harness/ModuleAssembly1/Lumped','force')

%% Cooling Plate Options
%
% The cooling plate can be modeled at vary levels of fidelity and
% granularity. The most abstract model simply defines the plate as a
% boundary condition, specifying the temperature gradient across the
% module. The cooling plate can also be modeled as fluid flow through
% channels, and the number of thermal elements in the plate can be
% increased to capture the temperature gradient within the plate in more
% detail.
%
% <matlab:open_system('test_loadcase_moduleAssy_harness');open_system('test_loadcase_moduleAssy_harness/Cooling%20Plate','force');Open Subsystem>

set_param('test_loadcase_moduleAssy_harness/Cooling Plate','LinkStatus','none')
open_system('test_loadcase_moduleAssy_harness/Cooling Plate','force')


%% Simulation Results: Lumped Module Assembly, Boundary Conditions
%
% The plots below show the results of a test using the lumped module
% assembly which assumes all cells in a module are exposed to the same
% thermal conditions. The thermal plate is modeled as a fixed temperature
% gradient along the flow path using Ideal Temperature Sources.  If the
% maximum cell temperature is below the limit (for example, 45°C) and the
% maximum temperature difference between cells is below a limit (for
% example, 5°C), then a requirement temperature difference for the fluid
% entering and exiting the cooling plate has been identified.

test_loadcase_moduleAssy_harness_setVariant('test_loadcase_moduleAssy_harness','Lumped BCs')
sim('test_loadcase_moduleAssy_harness')
test_loadcase_moduleAssy_plot1degc

%% Simulation Results: Lumped Module Assembly, Cooling Plate
%
% The plots below show the results of a test using the lumped module
% assembly cooled with fluid flow through a cooling plate.  Parameters of
% the cooling system can be adjusted until the cell temperatures are within
% the required range.

set_param('test_loadcase_moduleAssy_harness/Cooling Plate/Lumped Plate/Pump','LinkStatus','none')
open_system('test_loadcase_moduleAssy_harness/Cooling Plate/Lumped Plate/Pump','force')

set_param('test_loadcase_moduleAssy_harness/Cooling Plate/Lumped Plate/Cooling Plate','LinkStatus','none')
open_system('test_loadcase_moduleAssy_harness/Cooling Plate/Lumped Plate/Cooling Plate','force')

test_loadcase_moduleAssy_harness_setVariant('test_loadcase_moduleAssy_harness','Lumped Plate')
sim('test_loadcase_moduleAssy_harness')
test_loadcase_moduleAssy_plot1degc

%% Simulation Results: Edge Module Assembly, Cooling Plate
%
% The plots below show the results of a test using the edge module assembly
% cooled with fluid flow through a cooling plate.  Cells at the edges of
% the module assembly are modeled as a separate group with thermal
% conditions different than the interior cells. Parameters of the cooling
% system can be adjusted until the cell temperatures are within the
% required range.

test_loadcase_moduleAssy_harness_setVariant('test_loadcase_moduleAssy_harness','Edge')
sim('test_loadcase_moduleAssy_harness')
test_loadcase_moduleAssy_plot1degc

%% Simulation Results: Edge Detail Module Assembly, Cooling Plate
%
% The plots below show the results of a test using the edge module assembly
% cooled with fluid flow through a cooling plate.  Cells at the edges of
% the module assembly are modeled with unique thermal conditions for each
% cell at the edge, and conditions different than the interior cells.
% Parameters of the cooling system can be adjusted until the cell
% temperatures are within the required range.

test_loadcase_moduleAssy_harness_setVariant('test_loadcase_moduleAssy_harness','Edge_Detail')
sim('test_loadcase_moduleAssy_harness')
test_loadcase_moduleAssy_plot1degc

%% Simulation Results: Detailled Module Assembly, Cooling Plate
%
% The plots below show the results of a test using the detailled module
% assembly cooled with fluid flow through a cooling plate.  All cells in
% the module assembly are modeled with unique thermal conditions.
% Parameters of the cooling system can be adjusted until the cell
% temperatures are within the required range.

test_loadcase_moduleAssy_harness_setVariant('test_loadcase_moduleAssy_harness','Detailled')
sim('test_loadcase_moduleAssy_harness')
test_loadcase_moduleAssy_plot1degc
%%
close all
bdclose all