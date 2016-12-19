LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA raw_dataset;
	SET A1.assignmentdata;
RUN;

/* Delete measurement ourliers. */
DATA dataset;
	set raw_dataset;
	if (PPM >=0.1) then output;
run;

DATA dataset;
	set dataset;
	ID = _n_;
	LOGPPM = LOG(PPM);
run;

/* calc means of dataset */
proc means data=dataset mean std var n;
	var PPM;
	by Site;
	output out=meansdetails mean=mean std=sd var=var n=n;
run;

/* merge into one dataset */
data mergeddataset;
	merge dataset meansdetails;
	by Site;
run;

/* outliers Doornbos */
Data doornbos;
	set mergeddataset;
	u = (PPM - mean)/sd;
	w = sqrt((n*(n-2)*u**2)/((n-1)**2-n*u**2));
	DOORNBOS_final_value=ABS(w);
	DOORNBOS_outlier_criteria = quantile('T', 1-0.05/(2*n), (n-2));
run;

/* DOORNBOS outliers and exclude them from dataset */
data dataset_without_outliers;
	set doornbos;
	if (DOORNBOS_final_value <= DOORNBOS_outlier_criteria) then output;
run;

proc sort data=dataset_without_outliers;
	by Site Sensor;
run;



























data site_before site_1 site_2 site_3 site_4 site_5 site_6 site_7;
	set dataset_without_outliers;
	if (Site = 'Before') then output site_before ;
	if (Site = 'Site1') then output site_1 ;
	if (Site = 'Site2') then output site_2 ;
	if (Site = 'Site3') then output site_3 ;
	if (Site = 'Site4') then output site_4 ;
	if (Site = 'Site5') then output site_5 ;
	if (Site = 'Site6') then output site_6 ;
	if (Site = 'Site7') then output site_7 ;
run;


proc sort data=site_before;
	by Site Sensor;
run;

proc sort data=site_1;
	by Site Sensor;
run;

proc sort data=site_2;
	by Site Sensor;
run;

proc sort data=site_3;
	by Site Sensor;
run;

proc sort data=site_4;
	by Site Sensor;
run;

proc sort data=site_5;
	by Site Sensor;
run;

proc sort data=site_6;
	by Site Sensor;
run;

proc sort data=site_7;
	by Site Sensor;
run;
Title 'Normality Testing';
proc univariate data=site_before normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST1;
run;
/* PROC PRINT DATA=NORMALITYTEST; */
/* RUN; */

proc univariate data=site_1 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST2;
run;

proc univariate data=site_2 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST3;
run;

proc univariate data=site_3 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST4;
run;

proc univariate data=site_4 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST5;
run;

proc univariate data=site_5 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST6;
run;

proc univariate data=site_6 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST7;
run;

proc univariate data=site_7 normal;
	var PPM LOGPPM;
	by Site Sensor;
	histogram PPM LOGPPM/normal;
	probplot PPM LOGPPM/normal;
	ods output TestsForNormality=NORMALITYTEST8;
run;
*ods rtf file='temp.rtf';
PROC PRINT DATA=NORMALITYTEST1;
RUN;
PROC PRINT DATA=NORMALITYTEST2;
RUN;
PROC PRINT DATA=NORMALITYTEST3;
RUN;
PROC PRINT DATA=NORMALITYTEST4;
RUN;
PROC PRINT DATA=NORMALITYTEST5;
RUN;
PROC PRINT DATA=NORMALITYTEST6;
RUN;
PROC PRINT DATA=NORMALITYTEST7;
RUN;
PROC PRINT DATA=NORMALITYTEST8;
RUN;
*ods rtf close;
/*  */
/* Title 'Perform D�Agostino test'; */
/* PROC RANK DATA=site_before OUT=RANKS; */
/* 	VAR LOGPPM; */
/* 	RANKS K; */
/* RUN; */
/*  */
/* DATA DAgos; */
/* 	SET RANKS; */
/* 	S = 0.078997; */
/* 	N = 20; */
/* 	D_YK = LOGPPM*(K - 0.5*(N+1))/(S*SQRT(N**3*(N-1))); */
/* RUN; */
/*  */
/* PROC MEANS DATA=DAgos SUM; */
/* 	VAR D_YK; */
/* RUN; */