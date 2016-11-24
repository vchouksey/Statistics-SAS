DATA Pharmaceutical;
	input id variable @@;
	datalines;
	102 104 102 97 95 106 103 98 96 97
	;
RUN;
/*Sorting of pharmaceutical data*/
PROC sort data=Pharmaceutical;
	by variable;
RUN;

/*Calculation for std dev,min,max*/
proc means data=pharmaceutical;
RUN;

/* Calculation of skewness */
proc univariate data=pharmaceutical;
var variable;
Run;

proc univariate data=pharmaceutical;
var variable;
histogram variable/normal;
qqplot variable/normal;
ppplot variable/normal;
Run;




