LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

proc sort data=dataset;
	by Site Sensor Hour;
run;

/* calc means of dataset */
Title 'Summary Statistics';
proc means data=dataset n min max mean median std var;
/* 	class Site Sensor; */
	class Site Hour Sensor;
	var PPM;
	output out=meansdetails mean=mean std=sd var=var n=n;
run;

Title 'Sensor 1 by Hour';
proc means data=dataset n min max mean median std var;
/* 	class Site Sensor; */
	class Site Hour;
	var PPM;
	where sensor = 1;
run;

Title 'Sensor 2 by Hour';
proc means data=dataset n min max mean median std var;
/* 	class Site Sensor; */
	class Site Hour;
	var PPM;
	where sensor = 2;
run;