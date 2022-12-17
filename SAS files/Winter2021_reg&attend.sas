/* read Part 1 data*/
PROC IMPORT OUT= part1 DATAFILE= "/home/u58161476/Winter2021/TCA Winter 2021 Attendance.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="Part 1"; 
     GETNAMES=Yes;
RUN;

*sort by email; 
data p1; 
length email $ 7;
set part1; 
keep "First Name"n "Last Name"n email total; 
rename total=total_p1; 
if "First Name"n = "" then delete; 
run; 

proc sort data=p1;
by email "First Name"n "Last Name"n;
run;

/* read Part 2 data*/
PROC IMPORT OUT= part2 DATAFILE= "/home/u58161476/Winter2021/TCA Winter 2021 Attendance.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="Part 2"; 
     GETNAMES=Yes;
RUN;

*sort by email; 
data p2; 
length email $ 7;
set part2; 
keep "First Name"n "Last Name"n email total; 
rename total=total_p2; 
if "First Name"n = "" then delete; 
run; 

proc sort data=p2;
by email "First Name"n "Last Name"n;
run;

/* read Part 3_1 data*/
PROC IMPORT OUT= part3_1 DATAFILE= "/home/u58161476/Winter2021/TCA Winter 2021 Attendance.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="Part 3-1"; 
     GETNAMES=Yes;
RUN;

*sort by email; 
data p3_1; 
length email $ 7;
set part3_1; 
keep "First Name"n "Last Name"n email total; 
rename total=total_p3_1; 
if "First Name"n = "" then delete; 
run; 

proc sort data=p3_1;
by email "First Name"n "Last Name"n;
run;

/* read Part 3_2 data*/
PROC IMPORT OUT= part3_2 DATAFILE= "/home/u58161476/Winter2021/TCA Winter 2021 Attendance.xlsx" 
            DBMS=xlsx REPLACE;
     SHEET="Full Form3-2"; 
     GETNAMES=Yes;
RUN;

*sort by email; 
data p3_2; 
length email $ 7;
set part3_2; 
keep "First Name"n "Last Name"n email total; 
rename total=total_p3_2; 
if "First Name"n = "" then delete; 
run; 

proc sort data=p3_2;
by email "First Name"n "Last Name"n;
run;

*merge all attendence in Winter 2021 by email;
data attend_merge; 
merge p1 p2 p3_1 p3_2;  
by email "First Name"n "Last Name"n; 
run;

*export data;
proc export data=attend_merge
    outfile="/home/u58161476/Winter2021/attendmerge.xlsx"
    dbms=xlsx;
run;

* read export data;
FILENAME REFFILE '/home/u58161476/Winter2021/attendmerge.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.attendmerge;
	GETNAMES=YES;
RUN;

proc sort data=attendmerge;
by email "First Name"n "Last Name"n;
run;

/* read zoom data*/
FILENAME REFFILE '/home/u58161476/Winter2021/zoommerge.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.zoommerge;
	GETNAMES=YES;
RUN;

proc sort data=zoommerge;
by email "First Name"n "Last Name"n;
run;

*merge registration reports and attendence by email;
data final; 
merge zoommerge attendmerge;  
by email "First Name"n "Last Name"n; 
run;

*export data;
proc export data=final
    outfile="/home/u58161476/Winter2021/final.xlsx"
    dbms=xlsx;
run;

* read export data;
FILENAME REFFILE '/home/u58161476/Winter2021/final.xlsx';

PROC IMPORT DATAFILE=REFFILE replace
	DBMS=XLSX
	OUT=final;
	GETNAMES=YES;
RUN;

*frequency table by zoom; 
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


