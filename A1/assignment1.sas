LIBNAME A1 '/folders/myfolders/A1/';
DATA data;
SET A1.assignmentdata;
RUN;

/* GRUBBS */
%macro grubbs(indata=,alpha=,var=);
	proc summary data=&INDATA ;
		var &VAR ;
		output out=__out1 mean=mean max=max min=min std=sd n=n;
	run;
	
	data _null_;
		set __out1;
		G = max( (max - mean)/sd , (mean-min)/sd );
		t = tinv( &ALPHA /(2*n),n-2) ;
		cutoff = sqrt((((n-1)**2)*(t**2))/(n*((t**2)+n-2)));
		put G= cutoff= ;
	run;
%mend;

%grubbs(indata=data,alpha=0.05,var=PPM);

/* calculating UK for all rows */
%macro calcUK(indata=,var=);
	/* return summary of overall mean */
	proc summary data=&INDATA;
		var &VAR;
		output out=_out mean=mean std=sd;
	run;
	
	data _null_;
		set data _out;
		uk = (PPM - mean)/sd;
		put uk=;
	run;
%mend;

%calcUK(indata=data,var=PPM);
