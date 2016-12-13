LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

proc sort data=dataset ;
	by Site Sensor;
run;

/* calc means of dataset */
proc means data=dataset mean std var n;
	var PPM;
	class Site Sensor;
	output out=meansdetails mean=mean std=sd var=var n=n;
run;

proc sort data=meansdetails;
	by Site Sensor;
run;

/* merge into one dataset */
data mergeddataset;
	merge dataset meansdetails;
	by Site Sensor;
run;

/* Grubbs */
Data grubbs;
	set mergeddataset;
	u = (PPM - mean)/sd;
	Grubbs_final_value = abs(u);
run;

/* outliers */
data grubbs_outlier;
	set grubbs;
	/* two sided grubbs */
	t = tinv( 0.05 /(n),n-2) ;
	cutoff = sqrt((((n-1)**2)*(t**2))/(n*((t**2)+n-2)));
	if (cutoff < 0) then return;
	if (Grubbs_final_value > cutoff) then output;
run;

proc print data=grubbs_outlier;
run;


