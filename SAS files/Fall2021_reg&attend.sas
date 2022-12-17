/* read Part 1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Part 1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_one;
	GETNAMES=YES;
RUN;

*sort by email; 
data part1_email; 
length email $ 7;
set work.part_one; 
keep workshop "First Name"n "Last Name"n email comment total;
rename total=total_p1;  
run; 

proc sort data=work.part1_email;
by email "First Name"n "Last Name"n;
run;

/* read Part 2 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Part 2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_two;
	GETNAMES=YES;
RUN;

*sort by email; 
data part2_email; 
length email $ 7;
set work.part_two; 
keep workshop "First Name"n "Last Name"n email comment total; 
rename total=total_p2;  
run; 

proc sort data=work.part2_email;
by email "First Name"n "Last Name"n;
run;

/* read Part 3-1 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Part 3-1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_three_one;
	GETNAMES=YES;
RUN;

*sort by email; 
data part3_1_email; 
length email $ 7;
set work.part_three_one; 
keep workshop "First Name"n "Last Name"n email comment total; 
rename total=total_p3_1;  
run; 

proc sort data=part3_1_email;
by email "First Name"n "Last Name"n;
run;

/* read Part 3-2 data*/

FILENAME REFFILE '/home/u58161476/Practicum/Copy of TCA Fall 2021 Attendance.xlsx - Full Form_3-2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=part_three_two;
	GETNAMES=YES;
RUN;

*sort by email; 
data part3_2_email; 
length email $ 7;
set work.part_three_two; 
keep workshop "First Name"n "Last Name"n email comment total; 
rename total=total_p3_2;  
run; 

proc sort data=part3_2_email;
by email "First Name"n "Last Name"n;
run;

*merge all attendence in Fall2021 by email;
data attend_merge; 
merge work.part1_email work.part2_email work.part3_1_email work.part3_2_email;  
by email "First Name"n "Last Name"n; 
run;

*export data;
proc export data=attend_merge
    outfile="/home/u58161476/Practicum/attend_merge.csv"
    dbms=csv;
run;

/* read attend_merge data*/
FILENAME REFFILE '/home/u58161476/Practicum/attend_merge.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.attend_merge;
	GETNAMES=YES;
RUN;

proc sort data=work.attend_merge;
by email "First Name"n "Last Name"n;
run;

/* read reg_merge data*/
FILENAME REFFILE '/home/u58161476/Practicum/export.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.reg_merge;
	GETNAMES=YES;
RUN;

proc sort data=work.reg_merge;
by email "First Name"n "Last Name"n;
run;

*merge registration reports and attendence by email;
data final; 
merge work.reg_merge work.attend_merge;  
by email "First Name"n "Last Name"n; 
run;

*frequency table by email; 
proc sort data = final;
by email;
run;

proc freq;
table zoom1 zoom2 zoom3 zoom4 zoom5 zoom6 zoom7 zoom8;
run;

data category;
set final; 
if zoom1 or zoom2 ne . then highest_level = 1 ;
if zoom3 or zoom4 ne . then highest_level = 2 ;
if zoom5 or zoom6 ne . then highest_level = 3.1 ;
if zoom7 or zoom8 ne . then highest_level = 3.2 ;
total_attend = sum (total_p1, total_p2, total_p3_1, total_p3_2);
zoom_total = sum (zoom1, zoom2, zoom3, zoom4, zoom5, zoom6, zoom7,zoom8); 
run;

data zoom;
set category; 
zoom1= zoom1/zoom1;
zoom2= zoom2/zoom2;
zoom3= zoom3/zoom3;
zoom4= zoom4/zoom4;
zoom5= zoom5/zoom5;
zoom6= zoom6/zoom6;
zoom7= zoom7/zoom7;
zoom8= zoom8/zoom8;
session_registered = sum (zoom1, zoom2, zoom3, zoom4, zoom5, zoom6, zoom7,zoom8); 
run;

proc freq; 
table session_registered;
where total_attend >=11; 
run;

proc freq;
table highest_level;
where total_attend >=16; 
run;

proc freq data=category;
table highest_level;
where total_p1 >= 16 or total_p2 >= 16 or total_p3_1 >= 16 or total_p3_2 >= 16;
run;

proc freq data=category;
table highest_level;
where total_p1 >= 16 or total_p2 >= 16 or total_p3_1 >= 16 or total_p3_2 >= 16;
run;

proc freq;
table zoom1;
run;

