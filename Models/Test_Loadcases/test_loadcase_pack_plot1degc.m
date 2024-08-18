% Code to plot simulation results from test_loadcase_pack_harness
%% Plot Description:
%

% Copyright 2022-2024 The MathWorks, Inc.

% Find active variant
fnames = fieldnames(simlog_test_loadcase_pack.Pack);
variantListPack = setdiff(fnames,{'id','savable','exportable'});
if(length(variantListPack)>1)
    error('Cannot detect active variant');
else
    variantNamePack = char(variantListPack);
end

%% Group temperatures vs. time
% Reuse figure if it exists, else create new figure
if ~exist('h1_test_loadcase_batt_thermal', 'var') || ...
        ~isgraphics(h1_test_loadcase_batt_thermal, 'figure')
    h1_test_loadcase_batt_thermal = figure('Name', 'h1_test_loadcase_batt_thermal');
end
figure(h1_test_loadcase_batt_thermal)
clf(h1_test_loadcase_batt_thermal)

simlog_t = simlog_test_loadcase_pack.Electrical_Reference.V.v.series.time;

% Get fieldnames for sub-packs
fnms=fieldnames(simlog_test_loadcase_pack.Pack.(variantNamePack));
indSubPacks = find(contains(fnms,'ModuleAssembly'));
subPkNms = sort(fnms(indSubPacks));
packTFinal = [];
tempLims = [0 0];

% Map MA assembly to subplot index
subplot_seq = [1 3 5 7 8 6 4 2];

for sp_i = 1:length(subPkNms)
    fnms=fieldnames(simlog_test_loadcase_pack.Pack.(variantNamePack).(subPkNms{sp_i}));
    indModules = find(contains(fnms,'Module'));
    modNms = sort(fnms(indModules));
    subT = [];
    for mo_i = 1:length(modNms)
        subT = [subT simlog_test_loadcase_pack.Pack.(variantNamePack).(subPkNms{sp_i}).(modNms{mo_i}).temperatureCell.series.values('degC')];
    end
    ah(sp_i) = subplot(4,2,subplot_seq(sp_i));
    plot(simlog_t,subT)
    
    % Place title on plot to save space
    text(0.1,0.9,subPkNms{sp_i},'Units','Normalized')

    % Only label axes on bottom and left edges of figure
    if(rem(subplot_seq(sp_i),2)==1)
        ylabel('degC')
    else
        set(gca,'YTick', []);
    end
    if(subplot_seq(sp_i)>=7)
        xlabel('Time (s)')
    else
        set(gca,'XTick',[])
    end

    % Extract final temperatures to a matrix for next plot
    % Each sub pack is a row in the matrix
    packTFinal(sp_i,:) = subT(end,:);
end
linkaxes(ah,'xy')

%% Final temperatures per cell group
% Reuse figure if it exists, else create new figure
if ~exist('h2_test_loadcase_batt_thermal', 'var') || ...
        ~isgraphics(h2_test_loadcase_batt_thermal, 'figure')
    h2_test_loadcase_batt_thermal = figure('Name', 'h2_test_loadcase_batt_thermal');
end 
figure(h2_test_loadcase_batt_thermal)
clf(h2_test_loadcase_batt_thermal)

colormap(parula)

% Map MA assembly to subplot index
subplot_seq = [1 3 5 7 8 6 4 2];

% Get locations and dimensions of groups from plate data
switch(variantNamePack)
    case {'Lumped_Plate','Lumped_BCs'}
        CPDATA = plate_5p48s_thr;
    case 'Edge_Plate'
        CPDATA = plate_5p48s_1g10g1_thr;
    case 'Edge_Detail_Plate'
        CPDATA = plate_5p48s_1g10g1_5g1g5_thr;
    case 'Detailled_Plate'
        CPDATA = plate_5p48s_detailled_thr;
end

color_lim = [min(packTFinal,[],'all'),max(packTFinal,[],'all')];
LimBxPts = [0 0];

% Loop over subpacks
for sp_i = 1:size(packTFinal,1)

    % Create subplot per sub pack
    ahF(sp_i) = subplot(4,2,subplot_seq(sp_i));

    % Extract final group temperatures for this subpack
    tCellFinal = packTFinal(sp_i,:);

    % Clear variables that store plot and annotation information
    xpatch = [];ypatch = [];cpatch = [];
    text_x = [];text_y = [];text_str = [];
    
    % Loop over groups within subpack
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
        cpatch(g_i)   = (tCellFinal(g_i)-color_lim(1))/(color_lim(2)-color_lim(1));

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
    pt_h = patch(xpatch,ypatch,cpatch');
    text(text_x,text_y,text_str,'HorizontalAlign','center','VerticalAlign','middle')
    hold off
    box on
    set(gca,'XLim',[0 LimBxPts(1)])
    set(gca,'YLim',[LimBxPts(2) -LimBxPts(2)*0.0025])

    if(rem(subplot_seq(sp_i),2)==1)
        ylabel('m')
    else
        set(gca,'YTick', []);
    end
    if(subplot_seq(sp_i)>=7)
        xlabel('m')
    else
        set(gca,'XTick',[])
    end

    title(['TFinal, ' subPkNms{sp_i}])
    %text(0.1,0.9,['TFinal, ' subPkNms{sp_i}],'Units','Normalized')
end
