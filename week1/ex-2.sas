LIBNAME sas '/folders/myfolders/week1/';
DATA data;
SET sas.iq;
RUN;

proc print data=data;
run;

proc means data=data;
var iq;
run;

PROC UNIVARIATE DATA = data;
	VAR iq;
	HISTOGRAM iq/NORMAL;
	QQPLOT iq/NORMAL;
	PPPLOT iq/NORMAL;
RUN;

proc sort data=data;
by class;
run;

proc means data=data;
var iq;
by class;
run;