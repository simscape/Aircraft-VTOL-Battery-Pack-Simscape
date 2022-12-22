prop_wt.f = simlog_ssc_propeller_speed_thrust.Force_Sensor.F.series.values('N');
prop_wt.t = simlog_ssc_propeller_speed_thrust.Torque_Sensor.t.series.values('N*m');

t_hold = interp1(prop_wt.f,prop_wt.t,9.81*210/8);
t_lift = interp1(prop_wt.f,prop_wt.t,(80*200/60)/8);
