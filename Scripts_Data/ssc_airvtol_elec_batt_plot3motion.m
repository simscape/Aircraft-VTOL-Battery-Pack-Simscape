% Code to plot simulation results from ssc_airvtol_elec
%% Plot Description:
%
% The plots below show the trajectory of the VTOL during a single mission.
%
% Copyright 2022 The MathWorks, Inc.

% Generate simulation results if they don't exist
%if ~exist('simlog_ssc_airvtol_elec', 'var')
%    sim('ssc_airvtol_elec')
%end

% Reuse figure if it exists, else create new figure
if ~exist('h3_ssc_airvtol_batt', 'var') || ...
        ~isgraphics(h3_ssc_airvtol_batt, 'figure')
    h3_ssc_airvtol_batt = figure('Name', 'Motion of VTOL');
end
figure(h3_ssc_airvtol_batt)
clf(h3_ssc_airvtol_batt)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Get simulation results
simlog_t = simlog_ssc_airvtol_elec.ERef_Battery.V.v.series.time;
% Get battery information
vtol_dist_km  = logsout_ssc_airvtol_elec.get('distance_km');
vtol_altitude = logsout_ssc_airvtol_elec.get('Altitude');
vtol_airspeed = logsout_ssc_airvtol_elec.get('Airspeed');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(vtol_altitude.Values.Time/60,squeeze(vtol_altitude.Values.Data), 'LineWidth', 1)
hold off
grid on
title('Altitude (m)')
ylabel('Altitude (m)')

simlog_handles(2) = subplot(2, 1, 2);
plot(vtol_airspeed.Values.Time/60, vtol_airspeed.Values.Data, 'LineWidth', 1)
grid on
title('Airspeed')
ylabel('Speed (m/s)')
text(0.98,1.01,['Flight Range: ' sprintf('%3.2f',vtol_dist_km.Values.Data(end)) ' km'],...
    'Units','Normalized','HorizontalAlignment','right',...
    'VerticalAlignment','bottom','Color',[0.4 0.4 0.4]);


linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles simlog_batterycurrent temp_colororder
clear simlog_batterycharge simlog_batteryvoltage 
clear simlog_motor simlog_load simlog_generator 
clear simlog_lamp simlog_heater simlog_avionics
