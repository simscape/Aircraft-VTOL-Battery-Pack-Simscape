mdl = 'test_loadcase_moduleAssy_harness';

variant_list = {'Lumped BCs','Lumped Plate','Detailled','Edge','Edge_Detail'};

%% Setup
cd(fileparts(which('save_figures_moduleAssyHarness.m')))
battdir = pwd;
[status, msg, msgID] = mkdir('Results');

%% Generate plots for each variant Loadcase
open_system(mdl);
for i = 1:length(variant_list)
    test_loadcase_moduleAssy_harness_setVariant(mdl,variant_list{i});
    sim(mdl)
    test_loadcase_moduleAssy_plot1degc
    vntFName = strrep(variant_list{i},' ','_');
    saveas(h1_test_loadcase_batt_thermal,[battdir filesep 'Results' filesep vntFName '_Module_CellTempsTime.fig'])
    saveas(h2_test_loadcase_batt_thermal,[battdir filesep 'Results' filesep vntFName '_Module_CellTempsFinal.fig'])
    if(ishandle(h3_test_loadcase_batt_thermal))
        saveas(h3_test_loadcase_batt_thermal,[battdir filesep 'Results' filesep vntFName '_Module_PlateTempsFinal.fig'])
    end
    close all
end