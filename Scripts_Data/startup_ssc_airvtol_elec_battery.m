curr_proj = simulinkproject;

ssc_airvtol_elec_default_params

%% Create Array of Nodes Connector
h = dir('**/*arrayOfThermalNodesConnector.sscp');
cd(h(1).folder)
ssc_build
cd(curr_proj.RootFolder)

%% Create Battery Objects
CreatePack_5p48s8p_4g4g4_Iso
CreatePack_5p48s8p_1g10g1_Iso

CreatePack_5p48s8p_Thr
CreatePack_5p48s8p_4g4g4_Thr
CreatePack_5p48s8p_1g10g1_Thr
CreatePack_5p48s8p_1g10g1_5g1g5_Thr
CreatePack_5p48s8p_Detailed_Thr

close all
cd(curr_proj.RootFolder)

%% Load cell and pack parameters
Batt_Cell_Parameters_MCell
pack_5p48s8p_Thr_param_coolingPlate
pack_5p48s8p_4g4g4_Thr_param_coolingPlate
pack_5p48s8p_1g10g1_Thr_param_coolingPlate
pack_5p48s8p_1g10g1_5g1g5_Thr_param_coolingPlate
pack_5p48s8p_detailled_Thr_param_coolingPlate

targets_5p48s8p_thr              = pack_5p48s8p_Thr_targets;
targets_5p48s8p_4g4g4_thr        = pack_5p48s8p_4g4g4_Thr_targets;
targets_5p48s8p_1g10g1_thr       = pack_5p48s8p_1g10g1_Thr_targets;
targets_5p48s8p_1g10g1_5g1g5_thr = pack_5p48s8p_1g10g1_5g1g5_Thr_targets;
targets_5p48s8p_1g10g1_iso       = pack_5p48s8p_1g10g1_Iso_targets;
targets_5p48s8p_4g4g4_iso        = pack_5p48s8p_4g4g4_Iso_targets;
targets_5p48s8p_detailled_thr    = pack_5p48s8p_detailled_Thr_targets;

ssc_airvtol_elec_default_params_battery

cd(curr_proj.RootFolder)

ssc_airvtol_elec_battery
web('ssc_airvtol_elec_battery.html')