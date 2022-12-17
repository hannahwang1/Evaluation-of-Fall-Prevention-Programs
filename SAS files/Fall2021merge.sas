/* read T/Th 3:00 Part 1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/97003617611_RegistrationReport - 97003617611_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p1_TuTh;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p1_TuTh;
length email $ 7;
set work.p1_TuTh; 
zoom1 = 97003617611;
drop 'Zip/Postal Code'n;
run;

*sort by email;
proc sort data= zoom_p1_TuTh;
by email "First Name"n "Last Name"n;
run;

/* read W/F 10:30 Part 1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/97247262970_RegistrationReport - 97247262970_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p1_WeFr;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p1_WeFr;
length email $ 7;
set work.p1_WeFr; 
zoom2 = 97247262970;
drop 'Zip/Postal Code'n;
run;

*sort by email;
proc sort data= zoom_p1_WeFr;
by email "First Name"n "Last Name"n ;
run;

*merge registration reports in part 1 by email;
data part1_merge; 
merge zoom_p1_TuTh zoom_p1_WeFr; 
by email "First Name"n "Last Name"n; 
run;

*frequency table by email; 
proc freq;
table email;
run; 

/* read W/F 4:00 Part 2 data*/

FILENAME REFFILE '/home/u58161476/Practicum/94777991103_RegistrationReport - 94777991103_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p2_WeFr;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p2_WeFr;
length email $ 7;
set work.p2_WeFr; 
zoom3 = 94777991103; 
drop 'Zip/Postal Code'n;
run;

*sort by email;
proc sort data= zoom_p2_WeFr;
by email "First Name"n "Last Name"n;
run;

/* read T/Th 10:00 Part 2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/98582596853_RegistrationReport - 98582596853_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p2_TuTh;
	GETNAMES=YES;
RUN;

proc freq;
table 'zip/postal code'n;
run;

*add zoom ID;
data zoom_p2_TuTh;
length email $ 7;
set work.p2_TuTh; 
zoom4 = 98582596853;
drop 'Zip/Postal Code'n;
*if 'Zip/Postal Code'n = "Na" then 'Zip/Postal Code'n = "."; 
run;

*sort by email;
proc sort data= zoom_p2_TuTh;
by email "First Name"n "Last Name"n;
run;

*merge registration reports in part 2 by email;
data part2_merge; 
merge zoom_p2_TuTh zoom_p2_WeFr; 
by email "First Name"n "Last Name"n; 
run;

*frequency table by email; 
proc freq;
table email;
*table email*zoom;
run; 

/* read T/TH 4:00 Part 3-1 data*/
FILENAME REFFILE '/home/u58161476/Practicum/97843797748_RegistrationReport - 97843797748_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_1_TuTh;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p3_1_TuTh;
length email $ 7;
set work.p3_1_TuTh; 
zoom5 = 97843797748;
drop 'Zip/Postal Code'n; 
run;

*sort by email;
proc sort data= zoom_p3_1_TuTh;
by email "First Name"n "Last Name"n;
run;

/* read W/F 9:30 Part 3-1 data*/
FILENAME REFFILE '/home/u58161476/Practicum/95448843776_RegistrationReport - 95448843776_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_1_WeFr;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p3_1_WeFr;
length email $ 7;
set work.p3_1_WeFr; 
zoom6 = 95448843776;
drop 'Zip/Postal Code'n; 
run;

*sort by email;
proc sort data= zoom_p3_1_WeFr;
by email "First Name"n "Last Name"n;
run;

*merge registration reports in part 3_1 by email;
data part3_1_merge; 
merge zoom_p3_1_TuTh zoom_p3_1_WeFr; 
by email 'First Name'n 'Last Name'n; 
run;

*frequency table by email; 
proc freq;
table email;
*table email*zoom;
run;

/* read T/Th 9am Full form/part3-2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/96153086203_RegistrationReport (2) - 96153086203_RegistrationReport (2).csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_TuTh;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p3_2_TuTh;
length email $ 7;
set work.p3_2_TuTh; 
zoom7 = 96153086203;
drop 'Zip/Postal Code'n; 
run;

*sort by email;
proc sort data= zoom_p3_2_TuTh;
by email "First Name"n "Last Name"n;
run;

/* read M/W/F 3pm Practice Full form/part3-2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/99911052051_RegistrationReport (2) - 99911052051_RegistrationReport (2).csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_MoWeFr;
	GETNAMES=YES;
RUN;

*add zoom ID;
data zoom_p3_2_MoWeFr;
length email $ 7;
set work.p3_2_MoWeFr; 
zoom8 = 99911052051;
drop 'Zip/Postal Code'n; 
run;

*sort by email;
proc sort data= zoom_p3_2_MoWeFr;
by email "First Name"n "Last Name"n;
run;

*merge registration reports in part 3_2 by email;
data part3_2_merge; 
merge zoom_p3_2_TuTh zoom_p3_2_MoWeFr; 
by email "First Name"n "Last Name"n; 
run;

*frequency table by email; 
proc freq;
table email;
*table email*zoom;
run;

*merge all sessions in Fall2021 by email;
data all_merge; 
merge zoom_p1_TuTh zoom_p1_WeFr zoom_p2_WeFr zoom_p2_TuTh zoom_p3_1_TuTh zoom_p3_1_WeFr zoom_p3_2_TuTh zoom_p3_2_MoWeFr;  
by email "First Name"n "Last Name"n; 
run;

*frequency table by email; 
proc sort data = all_merge nodupkey;
by email;
run;

proc freq; 
*table email;
table email*zoom;
run;

proc freq;
table zoom1 zoom2 zoom3 zoom4 zoom5 zoom6 zoom7 zoom8;
run; 

*export data;
proc export data=all_merge
    outfile="/home/u58161476/Practicum/export.csv"
    dbms=csv;
run;

/* read export data*/
FILENAME REFFILE '/home/u58161476/Practicum/export.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.export;
	GETNAMES=YES;
RUN;

*frequency table by email; 
proc freq; 
table email;
*table email*zoom;
run;

proc freq;
table zoom1 zoom2 zoom3 zoom4 zoom5 zoom6 zoom7 zoom8;
run; 

/*perform paired samples t-test*/
proc ttest data=WORK.export alpha=.05;
    paired risk*p_risk;
run;
