LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
	ID = _n_;
RUN;

proc sort data=dataset;
	by Site Sensor;
run;

/* ods graphics off; */
proc boxplot data=dataset;
   plot PPM*Site / boxstyle = schematic;
run;

proc boxplot data=dataset;
   plot PPM*Sensor / boxstyle = schematic;
   by Site;
run;