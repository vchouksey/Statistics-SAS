LIBNAME sas '/folders/myfolders/A1/';
DATA data;
SET sas.assignmentdata;
RUN;

proc means data=data;
var PPM;
by Site;
run;

ods graphics on;
proc ttest h0=80 plots(showh0) sides=u alpha=0.1;
var PPM;
run;
ods graphics off;