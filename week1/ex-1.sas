data color;
	input region eyes$ hair$ count@@;
	datalines;
	1 blue fair 23 1 blue red 7 1 blue medium 24 
	1 blue dark 11 1 green fair 19 1 green red 7
	1 green medium 18 1 green dark 14 1 brown fair 34
	2 green red 31 2 green medium 37 2 green dark 23
	2 brown fair 56 2 brown red 42 2 brown medium 53
	2 brown dark 54
	;
run;
/* proc print */
proc print data=color;
run;
/* proc contents */
proc contents data=color;
run;	

/* save */
libname data "/folders/myfolders/";
data data.color;
set color;
run;