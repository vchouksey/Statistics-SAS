LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
RUN;

proc sort data=dataset;
	by Site Hour;
run;

proc univariate data=dataset normal noprint;
	class Site;
	var PPM;
	by Hour;
/* 	histogram PPM /normal; */
	probplot PPM /normal;
run;
/*  */
/* symbol v=plus; */
/* proc capability data=dataset; */
/* 	class Site; */
/* 	probplot PPM; */
/* run; */