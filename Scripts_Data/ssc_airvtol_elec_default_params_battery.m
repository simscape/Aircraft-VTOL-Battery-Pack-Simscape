% Default parameters for electric aircraft examples with battery system
%
% Copyright 2022-2024 The MathWorks, Inc.

% Default parameters
cooling_system.pump_max_flow   = 0.6*0+0.5;  % kg/s
cooling_system.on_rate         = 0.01; % kg/s/s
cooling_system.coolant_temp    = [23+273.15 26+273.15]; % K

vtol_motor.trqSpd.trq = [ 0.9 0.8 0.7 0 ]*500*propeller_num; % N*m
vtol_motor.trqSpd.w   = [ 0 3.75e+3 7.5e+3 8e+3 ]; % RPM
vtol_motor.Tc         = 0.02;  % sec
vtol_motor.eff        = 95;    % Percent
vtol_motor.trq4eff    = 400*propeller_num; % N*m
vtol_motor.w4eff      = 3.75e+3; % rpm
vtol_motor.loss_iron  = 0;     % W
vtol_motor.loss_fixed = 0;     % W
vtol_motor.Rext       = 0;     % Ohm
vtol_motor.J          = 0;     % kg*m^2
vtol_motor.b          = 1e-5;  % N*m/(rad/s)
vtol_motor.w0         = 0;     % RPM
