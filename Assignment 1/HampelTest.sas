LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
	i=1;
RUN;

/* calc means of dataset */
PROC UNIVARIATE DATA=dataset normal OUTTABLE=univariatedetails;  
	VAR PPM;
	by i;
RUN;

data mergeddataset;
	merge dataset univariatedetails;
	by i;
run;

DATA mergeddataset;
	SET mergeddataset;
	D = ABS(ppm-_median_);
RUN;

PROC UNIVARIATE DATA=mergeddataset outtable=details_D;
	VAR D;
	by i;
RUN;

DATA mergeddataset(DROP=_MEDIAN_);
	SET mergeddataset;
RUN;

data mergeddataset;
	merge details_D mergeddataset;
	by i;
run;

Data outliers_hampel;
	set mergeddataset;
	Z = D/_median_ ;
	if (D/_median_ > 3.5) then output;
run;
