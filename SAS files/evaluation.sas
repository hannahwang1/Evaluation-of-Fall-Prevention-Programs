/* read Part 1 Pre survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Pre-Survey++-+Part+1_May+6,+2022_21.19.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p1_pre;
	GETNAMES=yes;
	guessingrows=32000;
RUN;

data p1_pre_survey;
  set p1_pre (firstobs=92); 
  if startdate = " " then delete;
run;

Proc sort data=p1_pre_survey;
by Q3;
run;

data prep1;
  set p1_pre_survey (firstobs=3); 
run;

/* read Part 1 Post survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Post-Survey+(Part+1)_May+6,+2022_21.03.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p1_post;
	GETNAMES=YES;
	guessingrows=32000;
RUN;

data postp1;
  set p1_post (firstobs=106);
run;

proc sort data=postp1;
by Q3;
Run;

data p1_merge; 
merge prep1(in=a) postp1(in=b); 
by Q3; 
if a and not b;
run;

proc sql;
create table p1m as
select * from prep1(obs=0)
union corr
select * from postp1;
quit;

/* read Part 2 Pre survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Pre-Survey++-+Part+2_May+6,+2022_21.17.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p2_pre;
	GETNAMES=YES;
RUN;

data p2_post_survey;
  set p2_pre (firstobs=2);
run;

/* read Part 2 Post survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Post-Survey+(Part+2)_May+6,+2022_21.09.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p2_post;
	GETNAMES=YES;
RUN;

data p2_post_survey;
  set p2_post (firstobs=2);
run;

/* read Part 3_1 Pre survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Pre-Survey++-+Part+3-1_May+6,+2022_21.15.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_1_pre;
	GETNAMES=YES;
RUN;

data p3_1_pre_survey;
  set p3_1_pre (firstobs=2);
run;

/* read Part 3_1 Post survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Post-Survey+(Part+3-1)_May+6,+2022_21.07.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_1_post;
	GETNAMES=YES;
RUN;

data p3_1_post_survey;
  set p3_1_post (firstobs=2);
run;

/* read Part 3_2 Pre survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Pre-Survey++-+Part+3-2_Full+Form_May+6,+2022_21.05.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_pre;
	GETNAMES=YES;
RUN;

data p3_2_pre_survey;
  set p3_2_pre (firstobs=2);
run;

/* read Part 3_2 Post survey data*/

FILENAME REFFILE '/home/u58161476/evaluation/Fall+2021+Post-Survey+(Full+Form)_May+6,+2022_21.11.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.p3_2_post;
	GETNAMES=YES;
RUN;

data p3_2_post_survey;
  set p3_2_post (firstobs=2);
run;