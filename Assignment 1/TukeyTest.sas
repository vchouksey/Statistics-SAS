LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

PROC UNIVARIATE DATA=dataset outtable=univariatedetails;
	VAR ppm;
	class Site;
	class Sensor;
RUN;

PROC SORT DATA=dataset;
	By Site Sensor;
RUN;


data mergeddataset;
	merge dataset univariatedetails;
	by Site Sensor;
run;

DATA mergeddataset;
	SET mergeddataset;
	LOWER = _Q1_ - 1.5*_QRANGE_;
	UPPER = _Q3_ + 1.5*_QRANGE_;
RUN;

PROC SORT DATA=mergeddataset;
	BY Site Sensor;
RUN;

DATA mergeddataset;
	SET mergeddataset;
	IF ppm>UPPER OR ppm<LOWER THEN OUTLIER=1;
		ELSE OUTLIER=0;
RUN;

DATA Tukey_Outlier;
	SET mergeddataset;
	if outlier = 1 then output;
run;



/*Outlier detection using BOXPLOT*/
DATA TUKEY;
	SET dataset;
	BY Site;
RUN;

PROC BOXPLOT DATA=TUKEY;
   PLOT  ppm/boxstyle = schematicid;
   ID id;
RUN;QUIT;


