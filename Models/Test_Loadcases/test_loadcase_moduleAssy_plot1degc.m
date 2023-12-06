% Code to plot simulation results from test_loadcase_moduleAssy_harness
%% Plot Description:
%

% Copyright 2022-2023 The MathWorks, Inc.

% Find active variant
fnames = fieldnames(simlog_test_loadcase_module.ModuleAssembly1);
variantListModule = setdiff(fnames,{'id','savable','exportable'});
if(length(variantListModule)>1)
    error('Cannot detect active variant');
else
    variantNameModule = char(variantListModule);
end

%% Group temperatures vs. time
% Reuse figure if it exists, else create new figure
if ~exist('h1_test_loadcase_batt_thermal', 'var') || ...
        ~isgraphics(h1_test_loadcase_batt_thermal, 'figure')
    h1_test_loadcase_batt_thermal = figure('Name', 'h1_test_loadcase_batt_thermal');
end
figure(h1_test_loadcase_batt_thermal)
clf(h1_test_loadcase_batt_thermal)

simlog_t = simlog_test_loadcase_module.ERef_Battery.V.v.series.time;

% Get fieldnames for modules
fnms=fieldnames(simlog_test_loadcase_module.ModuleAssembly1.(variantNameModule));
indModules = find(contains(fnms,'Module'));
moduleNms = sort(fnms(indModules));
tempLims = [0 0];

% Get temperature results for each module
modT = [];
for mo_i = 1:length(moduleNms)
    modT = [modT simlog_test_loadcase_module.ModuleAssembly1.(variantNameModule).(moduleNms{mo_i}).temperatureCellModel.series.values('degC')];
end

% Plot results
plot(simlog_t,modT,'LineWidth',2)
ylabel('degC')
xlabel('Time (s)')
moduleTFinal= modT(end,:);
title('Cell Temperatures vs. Time');

%% Final temperatures per cell group
% Reuse figure if it exists, else create new figure
if ~exist('h2_test_loadcase_batt_thermal', 'var') || ...
        ~isgraphics(h2_test_loadcase_batt_thermal, 'figure')
    h2_test_loadcase_batt_thermal = figure('Name', 'h2_test_loadcase_batt_thermal');
end
figure(h2_test_loadcase_batt_thermal)
clf(h2_test_loadcase_batt_thermal)

colormap(parula)

% Get locations and dimensions of groups from plate data
switch(variantNameModule)
    case 'Lumped'
        CPDATA = plate_5p48s_thr;
    case 'Edge'
        CPDATA = plate_5p48s_1g10g1_thr;
    case 'Edge_Detail'
        CPDATA = plate_5p48s_1g10g1_5g1g5_thr;
    case 'Detailled'
        CPDATA = plate_5p48s_detailled_thr;
end

tCellFinal = moduleTFinal;
color_lim = [min(moduleTFinal,[],'all'),max(moduleTFinal,[],'all')];
LimBxPts = [0 0];

%EXTRA
%tCellFinal = [...
%    reshape(cm(:,1:5)',1,[])... 
%    reshape(cm(:,6:10)',1,[])...
%    reshape(cm(:,11:15)',1,[])...
%    reshape(cm(:,16:20)',1,[])...
%    ];
%moduleTFinal = tCellFinal;
%EXTRA

% Clear variables that store plot and annotation information
xpatch = [];ypatch = [];cpatch = [];
text_x = [];text_y = [];text_str = [];

% Loop over groups within module assembly
for g_i = 1:size(CPDATA.Coordinates,1)
    hold on

    % Plot along -y instead of +y to match battery chart
    cp = CPDATA.Coordinates(g_i,:).*[1 -1];

    % May be valid for R2022b only, swapping x and y
    %di = fliplr(CPDATA.Dimensions(g_i,:));
    di = CPDATA.Dimensions(g_i,:);
    % Create box perimeter for group
    boxPts = repmat(cp,5,1)+[1 1;1 -1;-1 -1;-1 1;1 1].*repmat(di,5,1)*0.5;
    plot(boxPts(:,1),boxPts(:,2),'k','HandleVisibility','off')

    % Create patch data for group
    xpatch(:,g_i) = boxPts(1:end-1,1);
    ypatch(:,g_i) = boxPts(1:end-1,2);
    cpatch(g_i)   = tCellFinal(g_i);
    %cpatch(g_i)   = (tCellFinal(g_i)-color_lim(1))/(color_lim(2)-color_lim(1));

    % Store text location at center of patch
    text_x(g_i)   = cp(1);
    text_y(g_i)   = cp(2);

    % Only label patch if it is large enough
    if(di(1)>0.03)
        text_str{g_i} = sprintf('%3.2f',tCellFinal(g_i));
    else
        text_str{g_i} = [];
    end

    % Save axes limits
    LimBxPts(1) = max([LimBxPts(1);boxPts(:,1)]);
    LimBxPts(2) = min([LimBxPts(2);boxPts(:,2)]);
end

% Create and annotate all patches
pt_h = patch(xpatch,ypatch,cpatch');
tx_h = text(text_x,text_y,text_str,'HorizontalAlign','center','VerticalAlign','middle');
hold off

clim = color_lim;
%clim([0 1]);

box on

% Adjust limits to include box edges
set(gca,'XLim',[0 LimBxPts(1)])
set(gca,'YLim',[LimBxPts(2) -LimBxPts(2)*0.0025])

title(['Cell Final Temperatures. ' ... 
    sprintf('Max: %3.2f°C, Max Delta %3.2f°C',max(moduleTFinal,[],'all'),...
    max(moduleTFinal,[],'all')-min(moduleTFinal,[],'all'))]);

cb = colorbar;
cb.Label.String = 'degC';

%% Plate Temperatures
fnames = fieldnames(simlog_test_loadcase_module.Cooling_Plate);
variantListPlate = setdiff(fnames,{'id','savable','exportable'});
if(length(variantListPlate)>1)
    error('Cannot detect active variant');
else
    variantNamePlate = char(variantListPlate);
end

if(contains(variantNamePlate,'Plate'))
    % Reuse figure if it exists, else create new figure
    if ~exist('h3_test_loadcase_batt_thermal', 'var') || ...
            ~isgraphics(h3_test_loadcase_batt_thermal, 'figure')
        h3_test_loadcase_batt_thermal = figure('Name', 'h3_test_loadcase_batt_thermal');
    end
    figure(h3_test_loadcase_batt_thermal)
    clf(h3_test_loadcase_batt_thermal)

    T_plate = simlog_test_loadcase_module.Cooling_Plate.(variantNamePlate).Cooling_Plate.Plate_1.plotPlateT.series.values('degC');

    T_plate_final = T_plate(end,:);
    T_plate_final_mat = reshape(T_plate_final,CPDATA.partitions_x,[])';
    T_fluidIn     = simlog_test_loadcase_module.Cooling_Plate.(variantNamePlate).Cooling_Plate.Plate_1.fluid_in.T.series.values('degC');
    T_fluidOut    = simlog_test_loadcase_module.Cooling_Plate.(variantNamePlate).Cooling_Plate.Plate_1.fluid_out.T.series.values('degC');
    TdeltaFluid   = abs(T_fluidOut(end)- T_fluidIn(end));

    heatmap(T_plate_final_mat,'colormap',parula);
    %clim([min([ambTemp coolTemp]),max([ambTemp coolTemp])]-273.15);
    title(['Final Temperatures, Plate Partitions Fluid Delta: ' sprintf('%3.2f°C',TdeltaFluid)]);
end