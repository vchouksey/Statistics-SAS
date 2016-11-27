libname data '/folders/myfolders';

/* Import data and detect values outside of the specification range(97 - 103)*/
DATA pharmaceutical;
	input CU OS @@;
	if OS = '0';
	datalines;
	102 0 104 1 102 0 97 0 95 1 106 1 103 0 98 0 96 1 97 0
	;
RUN;
/*Sort it out based on IDs*/
proc sort data = pharmaceutical;
    by CU;
run;
/*Calculate CI for mean and standard deviation of CU*/
ods select BasicIntervals Quantiles;
proc univariate data=pharmaceutical cibasic outtable=outpharm;
	var CU;
run;
/*Calculate CI for the first quartile*/
libname sql 'SAS-library';
proc sql;
   title 'Quartile 1';
   select _Q1_ from work.outpharm;
run;


