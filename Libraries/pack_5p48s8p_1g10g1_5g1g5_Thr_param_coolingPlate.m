plate_5p48s_1g10g1_5g1g5_thr.Nodes      = batt_5p48s_1g10g1_5g1g5_thr.Module(1).ThermalNodes.Bottom.NumNodes*4;

if(isMATLABReleaseOlderThan("R2022b","release",2))
    % Bug in R2022b - must be calculated by hand
    wx_1x1  = batt_5p12s_1g10g1_5g1g5_thr.ThermalNodes.Dimensions(1,1);
    wy_1x1  = batt_5p12s_1g10g1_5g1g5_thr.ThermalNodes.Dimensions(1,1);
    wx_10x5 = 0.224666666666667;
    wy_10x5 = batt_5p12s_1g10g1_5g1g5_thr.ThermalNodes.Dimensions(1,2);

    dims_M1 = [...
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_10x5 wy_10x5
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1
        wx_1x1  wy_1x1];

    plate_5p48s_1g10g1_5g1g5_thr.Dimensions = repmat(dims_M1,4,1);

    %if(verLessThan('matlab','9.14'))
    % For stacking axis 'X' only, before R2022b update 3
    plate_5p48s_1g10g1_5g1g5_thr.Dimensions = fliplr(plate_5p48s_1g10g1_5g1g5_thr.Dimensions);
    crd_MO = [
        batt_5p48s_1g10g1_5g1g5_thr.Module(1).ThermalNodes.Bottom.Locations(1:5,:);
        0.055875000000000   0.134800000000000;
        batt_5p48s_1g10g1_5g1g5_thr.Module(1).ThermalNodes.Bottom.Locations(1:5,1) 0.258825000000000*ones(5,1)];

    plate_5p48s_1g10g1_5g1g5_thr.Coordinates = ...
        repmat(crd_MO,4,1)+ ...
        [repmat([0 0],11,1);
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(2).Position(1:2),11,1);
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(3).Position(1:2),11,1);
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(4).Position(1:2),11,1)];
else
    plate_5p48s_1g10g1_5g1g5_thr.Dimensions = repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(1).ThermalNodes.Bottom.Dimensions,4,1);
    plate_5p48s_1g10g1_5g1g5_thr.Coordinates = ...
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(1).ThermalNodes.Bottom.Locations,4,1)+ ...
        [repmat([0 0],11,1);
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(2).Position(1:2),11,1);
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(3).Position(1:2),11,1);
        repmat(batt_5p48s_1g10g1_5g1g5_thr.Module(4).Position(1:2),11,1)];

    % Issue still present in Update 3
    plate_5p48s_1g10g1_5g1g5_thr.Coordinates(39-11-11-11,2) = 0.134800;
    plate_5p48s_1g10g1_5g1g5_thr.Coordinates(39-11-11,2) = 0.134800;
    plate_5p48s_1g10g1_5g1g5_thr.Coordinates(39-11,2) = 0.134800;
    plate_5p48s_1g10g1_5g1g5_thr.Coordinates(39,2) = 0.134800;
end



%% Other parameters
plate_5p48s_1g10g1_5g1g5_thr.coolant_temp = 273.15+20; % K
plate_5p48s_1g10g1_5g1g5_thr.partitions_x = 4;
plate_5p48s_1g10g1_5g1g5_thr.partitions_y = 3;
plate_5p48s_1g10g1_5g1g5_thr.num_channels = 3;
plate_5p48s_1g10g1_5g1g5_thr.k_thermal    = 20;   % W/(K*m)
plate_5p48s_1g10g1_5g1g5_thr.cp           = 447;  % J/(K*kg)
plate_5p48s_1g10g1_5g1g5_thr.rho          = 2500; % kg/m^3
plate_5p48s_1g10g1_5g1g5_thr.thickness    = 2e-3; % m
plate_5p48s_1g10g1_5g1g5_thr.diameter_hyd = 0.005; % m
plate_5p48s_1g10g1_5g1g5_thr.diameter_dst = 0.005; % m
plate_5p48s_1g10g1_5g1g5_thr.pipe_rough   = 1.5e-05; % m
