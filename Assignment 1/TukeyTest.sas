LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
	i=1;
RUN;

PROC UNIVARIATE DATA=dataset outtable=univariatedetails;
	VAR ppm;
	by i;
RUN;

data mergeddataset;
	merge dataset univariatedetails;
	by i;
run;

DATA mergeddataset;
	SET mergeddataset;
	LOWER = _Q1_ - 1.5*_QRANGE_;
	UPPER = _Q3_ + 1.5*_QRANGE_;
RUN;

PROC SORT DATA=mergeddataset;
	BY ppm;
RUN;

DATA mergeddataset;
	SET mergeddataset;
	IF ppm>UPPER OR ppm<LOWER THEN OUTLIER=1;
		ELSE OUTLIER=0;
RUN;


/*Outlier detection using BOXPLOT*/
DATA TUKEY;
	SET dataset;
	GROUP=1;
RUN;

PROC BOXPLOT DATA=TUKEY;
   PLOT  ppm*group/boxstyle = schematicid;
   ID id;
RUN;QUIT;


