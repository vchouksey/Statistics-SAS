data CI;
	input CU OS;
	datalines;
	102 0
	104 1
	102 0
	97 0
	95 1
	106 1
	103 0
	98 0
	96 1
	97 0
	;
run;

/* 2.1 */
proc univariate data=CI cibasic;
   var CU;
run;

/* 2.2 */
proc univariate data=CI cibasic;
   	var CU;
	where OS=1;
run;

/* 2.3 */
proc univariate data=CI cibasic;
   var CU;
   output out=pctl pctlpts=25 pctlpre=p
          cipctldf=(lowerpre=LCL upperpre=UCL);
run;