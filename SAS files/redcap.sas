/* read redcap data from csv*/

FILENAME REFFILE '/home/u58161476/Practicum/SBTraumaFallPreventi_DATA_2021-09-27_1656.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV replace
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

/*demographic info*/
proc freq;
table prog ;
run;

proc univariate;
var age sex ethnicity edu house; 
run; 

PROC SGPLOT ;
   VBOX age 
   / category = edu;
run;

/*health and fall*/
proc univariate;
var health limited fall fall_num injury fall_loc___1 fall_loc___2 fall_loc___3 fall_loc___99 fall_care___1 fall_care___2 fall_care___3 fall_care___4 fall_care___99;
run; 

PROC SGPLOT ;
   VBOX fall_num 
   / category = health;
run;

/*remove not answered observations*/
data notanswer;
set WORK.IMPORT;
if race___99 = 1 then delete;
run; 

/*compare function*/
proc compare
 base = sashelp.class
 compare = sashelp.classfit;
 var age;
run;

/*site name input*/
data site;
set WORK.IMPORT;
if record_id < = 27 then  site = "Meadowbrook";
if 28 < =record_id < = 45 then  site = "Stony Brook University Olli";
if 46 < =record_id < = 56 then  site = "Stony Brook University Olli";
if 57 < =record_id < = 73 then  site = "Stony Brook University Olli";
if 74 < =record_id < = 95 then  site = "Stony Brook Olli";
if 96 < =record_id < = 114 then  site = "Setauket FD";
if 115 < =record_id < = 124 then  site = "Stony Brook South Hampton Campus";
if 125 < =record_id < = 142 then  site = "Setauket Fire department";
if 143 < =record_id < = 159 then  site = "Strathmore Gate Community Association";
if 160 < =record_id < = 174 then  site = "Encore Lake Grove";
if 175 < =record_id < = 188 then  site = "Encore Lake Grove";
if 189 < =record_id < = 207 then  site = "Stony Brook University";
if 208 < =record_id < = 226 then  site = "Stony Brook University";
if 227 < =record_id < = 228 then  site = "Strathmore Gate Community Association";
if 229 < =record_id < = 238 then  site = "Encore at Lake Grove 55+ Community";
if 239 < =record_id < = 261 then  site = "Encore at Lake Grove 55+ Community";
if 262 < =record_id < = 278 then  site = "Strathmore Gate Community Association";
if 279 < =record_id < = 297 then  site = "Stony Brook University";
run;

*data quality assurance purposes, fill in all site name;
data QA___site;
set site;
if site = "" then QA___site = 1; else QA___site = 0;
run;

proc freq;
table QA___site; 
run; 

/*create variables for mutiracial groups*/
data race;
set WORK.IMPORT; 
if race___2 = 1 and race___5 = 1 then race___whiteasian = 1; else race___whiteasian =0; 
run; 

/*create variables for mutiple chronic diseases groups*/
data cd;
set WORK.IMPORT; 
if cd___7 = 1 and cd___8 = 1 then cd___DiabetesHeartDisease = 1; else cd___DiabetesHeartDisease =0; 
run; 

/*create variables for chronic disease frequency*/;

data sum; 
set WORK.IMPORT;
cd___sum = sum(cd___1, cd___2, cd___3, cd___4, cd___5, cd___6, cd___7, cd___8, cd___9, cd___10, cd___11, cd___12, cd___13, cd___14, cd___15, cd___16, cd___98);
run;

proc freq; 
table cd___sum; 
run; 

data risk;
set sum;
if cd___sum > 3 then cd___risk = 1; else cd___risk = 0;
run;

proc freq; 
table cd___risk; 
run; 

/*completion rate*/

*fill in missing values in prog;
data fix;
set work.import;
keep record_id program prog attend age sex ethnicity edu health fall_num injury cd___sum race___1 race___2 race___3 race___4 race___5 race___99;  
if record_id = 1318 then prog = 1;
if record_id = 1434 then prog = 1;
run;

*transform race variables into 1 combined, continous variables;
data race;
set fix; 
if race___1 = 1 then race = 1;
if race___2 = 1 then race = 2;
if race___3 = 1 then race = 3;
if race___4 = 1 then race = 4;
if race___5 = 1 then race = 5;
if race___99 = 1 then race = 99;
run;

*program completion rate;
data prog1;
set race;
where prog = 1 and attend ne 0;
if attend >= 15 then cr___1 = 1;  else cr___1 = 0;
run;

data prog2;
set race;
where prog = 2 and attend ne 0;
if attend >= 15 then cr___2 = 1; else cr___2 = 0;
run;

data prog3;
set race;
where prog = 3 and attend ne 0;
if attend >= 15 then cr___3 = 1; else cr___3 = 0;
run;

data prog;
merge prog1 prog2 prog3;
by record_id;
run; 

proc freq;
table cr___1 cr___2 cr___3;
run;

proc freq;
table attend;
run;
 
*overall completion rate; 
data overall;
set prog;
if cr___1 = 1 or cr___2 = 1 or cr___3 = 1 then cr = 1; else cr = 0;
run;

proc freq;
table cr;
run;

*session completion rate; 
proc sort; 
by record_id; 
run;

data session;
set overall;
if record_id < = 27 then  session = 1;
if 28 < =record_id < = 45 then  session = 2;
if 46 < =record_id < = 56 then  session = 3;
if 57 < =record_id < = 73 then  session = 4;
if 74 < =record_id < = 95 then  session = 5;
if 96 < =record_id < = 114 then  session = 6;
if 115 < =record_id < = 124 then  session = 7;
if 125 < =record_id < = 142 then  session = 8;
if 143 < =record_id < = 159 then  session = 9;
if 160 < =record_id < = 174 then  session = 10;
if 175 < =record_id < = 188 then  session = 11;
if 189 < =record_id < = 207 then  session = 12;
if 208 < =record_id < = 226 then  session = 13;
if 227 < =record_id < = 228 then  session = 14;
if 229 < =record_id < = 238 then  session = 15;
if 239 < =record_id < = 261 then  session = 16;
if 262 < =record_id < = 278 then  session = 17;
if 279 < =record_id < = 297 then  session = 18;
run;

proc freq; 
table cr;
by session;
run;

*basic analysis;
proc gplot data=overall;
plot cr*age;
run;
 quit;

*logistic regression on cr and demographic info;
proc logistic data=overall;
class cr sex ethnicity edu race/ param=ref;
model cr = age sex ethnicity edu race;
run;

*logistic regression on cr and health-related info;
proc logistic data=overall;
class cr / param=ref;
model cr = health fall_num injury cd___sum attend;
run;

proc contents data=overall; 
run;

proc freq data=overall; 
table edu; 
run;

/*perform paired samples t-test*/
proc ttest data=test_scores alpha=.05;
    paired pre*post;
run;

/*perform paired samples t-test*/
proc ttest data=WORK.IMPORT alpha=.05;
    paired reduce*p_reduce;
run;




 
