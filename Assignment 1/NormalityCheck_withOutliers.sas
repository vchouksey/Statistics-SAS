LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

data site_before;
	set dataset;
	if (Site = 'Before') then output;
run;

DATA site_before;
	SET site_before;
	LOGPPM = LOG(PPM);
RUN;

proc sort data=site_before;
	by Site Sensor;
run;

Title 'Normality Testing';
proc univariate data=site_before normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST;
run;

*ods rtf file='temp.rtf';
PROC PRINT DATA=NORMALITYTEST;
RUN;
*ods rtf close;