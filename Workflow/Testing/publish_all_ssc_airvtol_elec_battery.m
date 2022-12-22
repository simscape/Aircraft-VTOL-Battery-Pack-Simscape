warning('off','Simulink:Engine:MdlFileShadowedByFile');
warning('off','Simulink:Harness:WarnABoutNameShadowingOnActivation');

cd(curr_proj.RootFolder)
cd(['Models' filesep 'Test_Loadcases' filesep 'Overview'])

publish('test_loadcase_moduleAssy_harness.m','showCode',false)
publish('test_loadcase_pack_harness.m','showCode',false)

cd(curr_proj.RootFolder)
cd(['Models' filesep 'Test_Loadcases'])

save_figures_moduleAssyHarness
save_figures_packHarness

cd(curr_proj.RootFolder)
cd('Overview')
publish('ssc_airvtol_elec_battery.m','showCode',false)