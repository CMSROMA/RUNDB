SELECT temp_meas_id FROM temperature WHERE TIMESTAMPDIFF(SECOND, temp_meas_time, '2014-04-28 18:00:40') < 2 and TIMESTAMPDIFF(SECOND, temp_meas_time, '2014-04-28 18:06:40') > -2;
