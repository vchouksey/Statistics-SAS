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

Title 'Perform D�Agostino test';
PROC RANK DATA=site_before OUT=RANKS;
	VAR LOGPPM;
	RANKS K;
RUN;

DATA DAgos;
	SET RANKS;
	S = 0.078997;
	N = 20;
	D_YK = LOGPPM*(K - 0.5*(N+1))/(S*SQRT(N**3*(N-1)));
RUN;

PROC MEANS DATA=DAgos SUM;
	VAR D_YK;
RUN;