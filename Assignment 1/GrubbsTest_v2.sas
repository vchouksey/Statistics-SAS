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

data site_before site_1 site_2 site_3 site_4 site_5 site_6 site_7;
	set grubbs;
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
	by Grubbs_final_value;
run;
proc sort data=site_1;
	by Grubbs_final_value;
run;
proc sort data=site_2;
	by Grubbs_final_value;
run;
proc sort data=site_3;
	by Grubbs_final_value;
run;
proc sort data=site_4;
	by Grubbs_final_value;
run;
proc sort data=site_5;
	by Grubbs_final_value;
run;
proc sort data=site_6;
	by Grubbs_final_value;
run;
proc sort data=site_7;
	by Grubbs_final_value;
run;

/* outliers */
data grubbs_outlier;
	set site_before site_1 site_2 site_3 site_4 site_5 site_6 site_7;
	/* two sided grubbs */
	t = tinv( 0.05 /(2*n),n-2) ;
	cutoff = sqrt((((n-1)**2)*(t**2))/(n*((t**2)+n-2)));
	if (cutoff < 0) then return;
	if (Grubbs_final_value > cutoff) then output;
run;

proc print data=grubbs_outlier;
run;


