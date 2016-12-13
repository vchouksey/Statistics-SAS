LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

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

data site_before;
	set dataset_without_outliers;
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