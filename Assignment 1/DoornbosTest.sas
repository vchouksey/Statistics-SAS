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

/* DOORNBOS outliers */
data outliers_doornbos;
	set doornbos;
	if (DOORNBOS_final_value > DOORNBOS_outlier_criteria) then output;
run;

proc print data=outliers_doornbos;
run;

