plate_5p48s_1g10g1_thr.Nodes      = batt_5p48s_1g10g1_thr.Module(1).ThermalNodes.Bottom.NumNodes*4;
plate_5p48s_1g10g1_thr.Dimensions = repmat(batt_5p48s_1g10g1_thr.Module(1).ThermalNodes.Bottom.Dimensions,4,1);

%if(verLessThan('matlab','9.14'))
    if(isMATLABReleaseOlderThan("R2022b","release",2))
    % For stacking axis 'X' only, before R2022b update 3
    plate_5p48s_1g10g1_thr.Dimensions = fliplr(plate_5p48s_1g10g1_thr.Dimensions);
end

plate_5p48s_1g10g1_thr.Coordinates = ...
    repmat(batt_5p48s_1g10g1_thr.Module(1).ThermalNodes.Bottom.Locations,4,1)+ ...
    [repmat([0 0],3,1);
    repmat(batt_5p48s_1g10g1_thr.Module(2).Position(1:2),3,1);
    repmat(batt_5p48s_1g10g1_thr.Module(3).Position(1:2),3,1);
    repmat(batt_5p48s_1g10g1_thr.Module(4).Position(1:2),3,1)];

%% Other parameters
plate_5p48s_1g10g1_thr.coolant_temp = 273.15+20; % K
plate_5p48s_1g10g1_thr.partitions_x = 4;
plate_5p48s_1g10g1_thr.partitions_y = 3;
plate_5p48s_1g10g1_thr.num_channels = 3;
plate_5p48s_1g10g1_thr.k_thermal    = 20;   % W/(K*m)
plate_5p48s_1g10g1_thr.cp           = 447;  % J/(K*kg)
plate_5p48s_1g10g1_thr.rho          = 2500; % kg/m^3
plate_5p48s_1g10g1_thr.thickness    = 2e-3; % m
plate_5p48s_1g10g1_thr.diameter_hyd = 0.005; % m
plate_5p48s_1g10g1_thr.diameter_dst = 0.005; % m
plate_5p48s_1g10g1_thr.pipe_rough   = 1.5e-05; % m
