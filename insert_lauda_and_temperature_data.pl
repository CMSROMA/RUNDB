#!/usr/bin/perl 

# riccardo.paramatti@roma1.infn.it

####### LAUDA ########

# print"\nReading Lauda File\n\n";
# $laudaFileName = "lauda_monitor_BTF_CeF3.log";

# open(LOG,"$laudaFileName");
# while(<LOG>) {
#     if($_ =~ /(\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d) TBATH=0(\d\d\.\d\d)/) {
# #	print"$1 $2 $3\n";
# 	$myDay = $1;
# 	$myTime = $2;
# 	$myTemp = $3;
# 	if(($myDay gt '2014-04-27')&&($myDay lt '2014-05-06')) {
	    
# ##### is this temperature already in the DB ? ######
# 	    my $query = "\"SELECT * FROM lauda WHERE lauda_time = \'$myDay $myTime\';\"";
# 	    system("echo $query > myQuery.sql");
# 	    if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` == 0) {
		
# 		my $query = "\"INSERT INTO lauda VALUES(null, \'$myDay $myTime\', null, 18.00, $myTemp);\"";
# 		system("echo $query > myQuery.sql");
# 		if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` != 0) {
# 		    print" Error in doing: $query\n"; exit;
# 		}
# 	    }

# 	}
#     } elsif($_ =~ /(\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d) STAT=0/) {
#     } else {	print "wrong format in Lauda file: line $_"; 
#     }
# }

####### TEMPERATURE SENSORS ########
# FIXME usa lo stesso tempo in un intervallo di 2 secondi

print"\nReading Temperature File\n\n";
$tempSensorFileName = "temperatures_BTF_CeF3.log";

open(LOG,"$tempSensorFileName");
while(<LOG>) {
    if($_ =~ /(\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d) SENS1 T=(.+) H=(.+) D=(.+)/) {
	$myDay = $1;
	$myTime = $2;
	$myTemp = $3;
	$myHum = $4;
	$myDew = $5;
 	if(($myDay gt '2014-04-27')&&($myDay lt '2014-05-06')) {

##### is this temperature already in the DB ? ######
	    my $query = "\"SELECT * FROM temperature WHERE temp_meas_time = \'$myDay $myTime\';\"";
	    system("echo $query > myQuery.sql");
	    if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` == 0) {
		my $query = "\"INSERT INTO temperature VALUES(null, \'$myDay $myTime\', $myTemp, $myHum, $myDew, null, null);\"";
		system("echo $query > myQuery.sql");
		print "DB WRITING: Filling temperature table: $_\n";
		if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` != 0) {
		    print" Error in doing: $query\n"; exit;
		}
	    }
	}
    } elsif($_ =~ /(\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d) SENS2 T=(.+)/) {
	$myDay = $1;
	$myTime = $2;
	$myTemp = $3;
	if(($myDay gt '2014-04-27')&&($myDay lt '2014-05-06')) {
##### is this temperature already in the DB ? ######
#	    my $query = "\"SELECT temp_meas_id FROM temperature WHERE TIMESTAMPDIFF(SECOND, temp_meas_time, \'$myDay $myTime\') < 2 and TIMESTAMPDIFF(SECOND, temp_meas_time, \'$myDay $myTime\') > -2;\"";
	    my $query = "\"SELECT * FROM temperature WHERE temp_meas_time = \'$myDay $myTime\';\"";
	    system("echo $query > myQuery.sql");
	    if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` == 0) {
		my $query = "\"INSERT INTO temperature VALUES(null, \'$myDay $myTime\', null, null, null, $myTemp, null);\"";
		system("echo $query > myQuery.sql");
		print "DB WRITING: Filling temperature table: $_\n";
		if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` != 0) {
		    print" Error in doing: $query\n"; exit;
		}
	    }
	}
    } elsif($_ =~ /(\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d) SENS3 T=(.+)/) {
	$myDay = $1;
	$myTime = $2;
	$myTemp = $3;
	if(($myDay gt '2014-04-27')&&($myDay lt '2014-05-06')) {
##### is this temperature already in the DB ? ######
	    my $query = "\"SELECT * FROM temperature WHERE temp_meas_time = \'$myDay $myTime\';\"";
	    system("echo $query > myQuery.sql");
	    if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` == 0) {
		my $query = "\"INSERT INTO temperature VALUES(null, \'$myDay $myTime\', null, null, null, null, $myTemp);\"";
		system("echo $query > myQuery.sql");
		print "DB WRITING: Filling temperature table: $_\n";
		if(`mysql -u cmsdaq -p?cms?daq?2014 rundb_v1 < myQuery.sql | wc -l` != 0) {
		    print" Error in doing: $query\n"; exit;
		}
	    }
	}
      } else {	print "wrong format in Temperature file: line $_"; 
    }
}

exit;

