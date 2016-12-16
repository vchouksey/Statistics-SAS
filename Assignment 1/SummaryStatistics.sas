LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

proc sort data=dataset;
	by Site Sensor;
run;

/* calc means of dataset */
Title 'Summary Statistics';
proc means data=dataset n min max mean median std var;
/* 	class Site Sensor; */
	class Site;
	var PPM;
	output out=meansdetails mean=mean std=sd var=var n=n;
run;