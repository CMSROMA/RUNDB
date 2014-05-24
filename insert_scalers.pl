#!/usr/bin/perl 

# riccardo.paramatti@roma1.infn.it

$logDir = "/home/cmsdaq/BTF/log";
@listOfLogFiles = <$logDir/run_BTF_*log>;

#### preparing list of log files #######

foreach $logFile(@listOfLogFiles) {

    if($logFile =~ /^$logDir\/run_BTF_(\d+)_\d+\-\d+/) {
	$thisRunNumber = $1;

##### does this run exist in the DB ?  ######
	my $query = "\"SELECT * FROM run WHERE run_number = $thisRunNumber;\"";
	system("echo $query > myQuery.sql");
#	print"run number $1 $logFile\n ";

	if(`mysql -u root -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` == 0) {
	    print "WARNING: Run $thisRunNumber is missing in the DB\n";

	} else { ##### the run exists #####

##### is the scaler already in the DB ? ######
	    my $query = "\"SELECT * FROM scaler WHERE scaler_run_number = $thisRunNumber;\"";
	    system("echo $query > myQuery.sql");
	    if(`mysql -u root -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` == 0) {
		my $query = "\"INSERT INTO scaler VALUES(null, $thisRunNumber, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);\"";
		system("echo $query > myQuery.sql");
		print "DB WRITING: Filling scaler table with Run $thisRunNumber\n";
		#if(`mysql -u root -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` != 0) {
		#    print" Error in doing: $query\n"; exit;
		#}
	    }

##### reading log file #####
	    open(LOG,"$logFile");
	    while(<LOG>) {
		if($_ =~ /channel (\d+) has (\d+) counts/) {
		    $channel = $1;
		    $counts = $2;
		    if( ($channel >= 0) && ($channel < 16) && ($counts >= 0)) {
			my $query = "\"UPDATE scaler SET scaler$channel = $counts WHERE scaler_run_number = $thisRunNumber;\"";
			system("echo $query > myQuery.sql");
#			print "DB WRITING: Update scaler table - Run $thisRunNumber - Channel $channel = $counts\n";
			#if(`mysql -u root -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` != 0) {
			#    print" Error in doing: $query\n"; exit;
			#}
		    } else {
			print "error in file $logFile"; 
			exit;
		    }
		}
	    }
	    
	    close(LOG);
	}
    } else {
	print"error $logFile\n"; exit;
    }
}

exit;
