CREATE DATABASE rundb_v1;
USE rundb_v1;



CREATE TABLE run_type
(
	run_type_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	run_type_description VARCHAR(500) COMMENT 'pedestal, cosmics, Na source, Sr source, beam',
	ped_frequency INT
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO run_type VALUES(null, 'beam', null);
INSERT INTO run_type VALUES(null, 'pedestal 10 Hz', 10);
INSERT INTO run_type VALUES(null, 'pedestal 100 Hz', 100);
INSERT INTO run_type VALUES(null, 'pedestal 1000 Hz', 1000);
INSERT INTO run_type VALUES(null, 'pedestal 10000 Hz', 10000);
INSERT INTO run_type VALUES(null, 'cosmics', null);
INSERT INTO run_type VALUES(null, 'Na source', null);
INSERT INTO run_type VALUES(null, 'Sr source', null);




CREATE TABLE beam_configuration
(
	beam_conf_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	beam_particle VARCHAR(100) COMMENT 'electron, positron, photon',
	beam_energy FLOAT COMMENT 'energy in MeV',
	beam_intensity FLOAT,
	beam_horizontal_width FLOAT COMMENT 'in mm',
	beam_vertical_width FLOAT COMMENT 'in mm',
	beam_horizontal_tilt FLOAT COMMENT 'in degree',
	beam_vertical_tilt FLOAT COMMENT 'in degree'
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO beam_configuration VALUES(null, 'electron', 400., 1., 10.5, 7.2, 0.5, 0.1);


CREATE TABLE daq_configuration
(
	daq_conf_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	daq_type_description VARCHAR(500),
	daq_user_gate1_ns INT,
	daq_user_gate2_ns INT
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO daq_configuration VALUES(null, 'adc792_disc814_io262_scaler560_tdc1290', 400, 1000);
INSERT INTO daq_configuration VALUES(null, 'adc265_disc814_io262_scaler560', 400, 1000);




CREATE TABLE run
(
	run_number INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	run_nevents INT,
	run_ntrigs INT,
	run_type_id INT NOT NULL,
	run_beam_id INT,
	table_horizontal_position FLOAT COMMENT 'position in mm',
	table_vertical_position FLOAT COMMENT 'position in mm',
	run_start_user_comment VARCHAR(500),
	run_end_user_comment VARCHAR(500),
	run_starttime DATETIME,
	run_endtime DATETIME,
	run_exit_code INT COMMENT '0 = run ended according to run_nevents, 1 = run stopped by the operator, 2 = other',
	run_daq_id INT NOT NULL,
	INDEX run_type_key (run_type_id),
  	FOREIGN KEY (run_type_id) REFERENCES run_type(run_type_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX run_beam_key (run_beam_id),
  	FOREIGN KEY (run_beam_id) REFERENCES beam_configuration(beam_conf_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX run_daq_key (run_daq_id),
  	FOREIGN KEY (run_daq_id) REFERENCES daq_configuration(daq_conf_id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = INNODB AUTO_INCREMENT = 1;


INSERT INTO run VALUES(null, 100000, null, 2, 1, 10.5, 7.2, 'temperature scan; T = 18.7 C', null, '2014-04-01 10:30:00', null, null, 1);
UPDATE run SET run_endtime = '2014-04-01 10:30:00', run_exit_code = 0, run_ntrigs = 99999 where run_number = 1;



CREATE TABLE scaler
(
	scaler_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	scaler_run_number INT NOT NULL,
	scaler0 INT,
	scaler1 INT,	
	scaler2 INT,
	scaler3 INT,
	scaler4 INT,
	scaler5 INT,
	scaler6 INT,
	scaler7 INT,
	scaler8 INT,
	scaler9 INT,
	scaler10 INT,
	scaler11 INT,
	scaler12 INT,
	scaler13 INT,
	scaler14 INT,
	scaler15 INT,
	INDEX run_number_key (scaler_run_number),
  	FOREIGN KEY (scaler_run_number) REFERENCES run(run_number) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = INNODB AUTO_INCREMENT = 1;
 
INSERT INTO scaler VALUES(null, 1, 1500, 3000, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);



CREATE TABLE temperature
(
	temp_meas_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	temp_meas_time DATETIME,
        temp_sensor_1 FLOAT,
	hum_sensor_1 FLOAT,
	dew_sensor_1 FLOAT,
        temp_sensor_2 FLOAT,
        temp_sensor_3 FLOAT
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO temperature VALUES(null, '2014-04-01 10:30:01', 18.4, 50.0, 13.5, 17.5, 17.6);
INSERT INTO temperature VALUES(null, '2014-04-01 10:30:11', null, null, null, 17.6, null);
INSERT INTO temperature VALUES(null, '2014-04-01 10:30:21', 18.3, 65.5, 14.0, null, null);
INSERT INTO temperature VALUES(null, '2014-04-01 10:31:00', null, null, null, null, null);
UPDATE temperature SET temp_sensor_3 = 18.0 WHERE temp_meas_id = 4;





CREATE TABLE lauda
(
	lauda_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	lauda_time DATETIME,
	lauda_status INT,
        lauda_temp_set FLOAT,
        lauda_temp_mon FLOAT
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO lauda VALUES(null, '2014-04-01 10:30:01', 1, 18., 18.1);

