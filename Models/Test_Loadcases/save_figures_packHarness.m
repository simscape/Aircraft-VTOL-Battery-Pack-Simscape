mdl = 'test_loadcase_pack_harness';

%variant_list = {'Lumped_BCs','Lumped_Plate','Edge_Plate','Edge_Detail_Plate'};
variant_list = {'Lumped_BCs','Lumped_Plate'};

%% Setup
cd(fileparts(which('save_figures_packHarness.m')))
battdir = pwd;
[status, msg, msgID] = mkdir('Results');

%% Generate plots for each variant Loadcase
open_system(mdl);
for i = 1:length(variant_list)
    test_loadcase_pack_harness_setVariant(mdl,variant_list{i});
    sim(mdl)
    test_loadcase_pack_plot1degc
    vntFName = strrep(variant_list{i},' ','_');
    saveas(h1_test_loadcase_batt_thermal,[battdir filesep 'Results' filesep vntFName '_Pack_CellTempsTime.fig'])
    saveas(h2_test_loadcase_batt_thermal,[battdir filesep 'Results' filesep vntFName '_Pack_CellTempsFinal.fig'])
    close all
end