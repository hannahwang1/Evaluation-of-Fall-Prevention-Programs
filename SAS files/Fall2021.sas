/* read Part 1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Part 1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_one;
	GETNAMES=YES;
RUN;

*count missing values by dates; 
proc freq data=work.part_one;
table var7 -- var102 / missing; 
run;

*count missing values by participants; 
data attend1;
set work.part_one;
cnt_missing_values_1 = cmiss(of var7 -- var102);
run; 

*add meeting id of the session(s) registered; 
data part1_id; 
set work.part_one; 
if workshop = "W/F 10:30am" then id1 = "972 4726 2970";
if workshop = "T/Th 3pm" then id2 = "970 0361 7611"; 
if workshop = "Both" then id1 = "972 4726 2970" ;
if workshop = "Both" then id2 = "970 0361 7611";
run; 

proc sort;
by email;
run;

proc freq; 
table email;
run;

*read part1 registration data;
FILENAME REFFILE '/home/u58161476/Practicum/Part 1 Registration  - Sheet1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_one_reg;
	GETNAMES=YES;
RUN;

*merge attend data and reg data; 
data mergep1;
merge  part1_id part_one_reg;
by email 
run; 

/* read Part 2 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Part 2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_two;
	GETNAMES=YES;
RUN;

*count missing values by dates; 
proc freq data=work.part_two;
table var7 -- var103 / missing; 
run;

*count missing values by participants; 
data attend2;
set work.part_two;
cnt_missing_values_2 = cmiss(of var7 -- var103);
run; 

*add meeting id of the session(s) registered; 
data part2_id; 
set work.part_two; 
if workshop = "T/Th 10am" then id1 = "985 8259 6853";
if workshop = "W/F 4pm" then id2 = "947 7799 1103"; 
if workshop = "Both" then id1 = "985 8259 6853" ;
if workshop = "Both" then id2 = "947 7799 1103";
run; 

/* read Part 3-1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Part 3-1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_three_one;
	GETNAMES=YES;
RUN;

*count missing values by dates; 
proc freq data=work.part_three_one;
table var7 -- var102 / missing; 
run;

*count missing values by participants; 
data attend3_1;
set work.part_three_one;
cnt_missing_values_3_1 = cmiss(of var7 -- var102);
run; 

*add meeting id of the session(s) registered; 
data part3_1_id; 
set work.part_three_one; 
if workshop = "T/Th 4pm" then id1 = "978 4379 7748";
if workshop = "W/F 9:30am" then id2 = "954 4884 3776"; 
if workshop = "Both" then id1 = "978 4379 7748" ;
if workshop = "Both" then id2 = "954 4884 3776";
run; 

/* read Part 3-2 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Full Form_3-2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_three_two;
	GETNAMES=YES;
RUN;

*count missing values by dates; 
proc freq data=work.part_three_two;
table var7 -- var102 / missing; 
run;

*count missing values by participants; 
data attend3_2;
set work.part_three_two;
cnt_missing_values_3_2 = cmiss(of var7 -- var102);
run; 

*add meeting id of the session(s) registered; 
data part3_2_id; 
set work.part_three_two; 
if workshop = "M/W/F 3pm" then id1 = "999 1105 2051";
if workshop = "T/Th 9am" then id2 = "961 5308 6203"; 
if workshop = "Both" then id1 = "999 1105 2051" ;
if workshop = "Both" then id2 = "961 5308 6203";
run; 

/* read T/Th 3:00 Part 1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/97003617611_RegistrationReport - 97003617611_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p1_TuTh;
	GETNAMES=YES;
RUN;

/* read W/F 10:30 Part 1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/97247262970_RegistrationReport - 97247262970_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p1_WeFr;
	GETNAMES=YES;
RUN;

*merge 2 sessions in part 1 by email;
data part1_reg; 
merge work.p1_TuTh work.p1_WeFr; 
run;

proc sort;
by email;
run;

*merge attend and reg in part 1 by email;
data part1_merge; 
merge part1_reg part_one; 
by email; 
run;

/* read W/F 4:00 Part 2 data*/

FILENAME REFFILE '/home/u58161476/Practicum/94777991103_RegistrationReport - 94777991103_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p2_WeFr;
	GETNAMES=YES;
RUN;

/* read T/Th 10:00 Part 2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/98582596853_RegistrationReport - 98582596853_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p2_TuTh;
	GETNAMES=YES;
RUN;

*merge 2 sessions in part 2 by email;
data part2_reg; 
merge work.p2_TuTh work.p2_WeFr; 
by email;
run;

/* read T/TH 4:00 Part 3-1 data*/
FILENAME REFFILE '/home/u58161476/Practicum/97843797748_RegistrationReport - 97843797748_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_1_TuTh;
	GETNAMES=YES;
RUN;

/* read W/F 9:30 Part 3-1 data*/
FILENAME REFFILE '/home/u58161476/Practicum/95448843776_RegistrationReport - 95448843776_RegistrationReport.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_1_WeFr;
	GETNAMES=YES;
RUN;

*merge 2 sessions in part 3-1 by email;
data part2_reg; 
merge work.p3_1_TuTh work.p3_1_WeFr; 
by email;
run;

/* read T/Th 9am Full form/part3-2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/96153086203_RegistrationReport (2) - 96153086203_RegistrationReport (2).csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_TuTh;
	GETNAMES=YES;
RUN;

/* read M/W/F 3pm Practice Full form/part3-2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/99911052051_RegistrationReport (2) - 99911052051_RegistrationReport (2).csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_MoWeFr;
	GETNAMES=YES;
RUN;

*merge 2 sessions in part 3-2 by email;
data part3_reg; 
merge work.p3_2_TuTh work.p3_2_WeFr; 
by email;
run;

/* read M/W/F 3pm Practice Full form/part3-2 data*/
FILENAME REFFILE '/home/u58161476/Practicum/99911052051_RegistrationReport (2) - 99911052051_RegistrationReport (2).csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_MoWeFr;
	GETNAMES=YES;
RUN;