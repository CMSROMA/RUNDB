CREATE DATABASE rundb_mcp;
USE rundb_mcp;



CREATE TABLE run_type
(
	run_type_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	run_type_description VARCHAR(500) COMMENT 'pedestal, cosmics, Na source, Sr source, beam',
	ped_frequency INT
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO run_type VALUES(null, 'beam', null);
INSERT INTO run_type VALUES(null, 'pedestal 10 Hz', 10);
INSERT INTO run_type VALUES(null, 'pedestal 70 Hz', 70);
INSERT INTO run_type VALUES(null, 'pedestal 100 Hz', 100);
INSERT INTO run_type VALUES(null, 'pedestal 1000 Hz', 1000);
INSERT INTO run_type VALUES(null, 'pedestal 10000 Hz', 10000);
INSERT INTO run_type VALUES(null, 'LED', null);
INSERT INTO run_type VALUES(null, 'cosmics', null);
INSERT INTO run_type VALUES(null, 'Na source', null);
INSERT INTO run_type VALUES(null, 'Sr source', null);




CREATE TABLE beam_configuration
(
	beam_conf_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	beam_particle VARCHAR(100) COMMENT 'electron, positron, photon',
	beam_energy DECIMAL(7,2) COMMENT 'energy in MeV',
	beam_intensity FLOAT,
	beam_horizontal_width FLOAT COMMENT 'in mm',
	beam_vertical_width FLOAT COMMENT 'in mm',
	beam_horizontal_tilt FLOAT COMMENT 'in degree',
	beam_vertical_tilt FLOAT COMMENT 'in degree'
) ENGINE = INNODB AUTO_INCREMENT = 1;




CREATE TABLE daq_configuration
(
	daq_conf_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	daq_type_description VARCHAR(500),
	daq_user_gate1_ns INT,
	daq_user_gate2_ns INT
) ENGINE = INNODB AUTO_INCREMENT = 1;





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
 



CREATE TABLE element
(
	element_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	description VARCHAR(200)
) ENGINE = INNODB AUTO_INCREMENT = 1;

INSERT INTO element VALUES(null, 'MCP_MIB1');
INSERT INTO element VALUES(null, 'MCP_MIB2');
INSERT INTO element VALUES(null, 'MCP_MIB3');
INSERT INTO element VALUES(null, 'MCP_Roma1');
INSERT INTO element VALUES(null, 'MCP_Roma2');
INSERT INTO element VALUES(null, 'MCP_Planacon');
INSERT INTO element VALUES(null, 'Cu_Absorber_1X0');
INSERT INTO element VALUES(null, 'Cu_Absorber_2X0');
INSERT INTO element VALUES(null, 'Cu_Absorber_4X0');
INSERT INTO element VALUES(null, 'Cu_Absorber_8X0');
INSERT INTO element VALUES(null, 'Plexiglass_1');
INSERT INTO element VALUES(null, 'Plexiglass_2');
INSERT INTO element VALUES(null, 'Plexiglass_3');
INSERT INTO element VALUES(null, 'Plexiglass_4');
INSERT INTO element VALUES(null, 'Plexiglass_5');
INSERT INTO element VALUES(null, 'Plexiglass_6');
INSERT INTO element VALUES(null, 'Plexiglass_7');
INSERT INTO element VALUES(null, 'Plexiglass_8');
INSERT INTO element VALUES(null, 'Plexiglass_9');
INSERT INTO element VALUES(null, 'Plexiglass_10');




CREATE TABLE element_configuration
(
	pos_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	pos_run_number INT,
	element_id INT,
	element_position INT COMMENT 'position in mm',
	element_HV FLOAT,
	element_photocathode_status INT,
	INDEX element_key (element_id),
  	FOREIGN KEY (element_id) REFERENCES element(element_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
	INDEX run_number_key (pos_run_number),
  	FOREIGN KEY (pos_run_number) REFERENCES run(run_number) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = INNODB AUTO_INCREMENT = 1;




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




GRANT ALL PRIVILEGES ON rundb_mcp.* to cmsdaq@localhost;
FLUSH PRIVILEGES;
