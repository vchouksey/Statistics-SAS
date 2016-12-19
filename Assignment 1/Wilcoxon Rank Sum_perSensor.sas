LIBNAME A1 '/folders/myfolders/Assignment 1/';
DATA dataset;
	SET A1.assignmentdata;
/* 	ID = _n_; */
/* 	LOGPPM = LOG(PPM); */
RUN;

/* data site_before site_1 site_2 site_3 site_4 site_5 site_6 site_7; */
/* 	set dataset; */
/* 	if (Site = 'Before') then output site_before ; */
/* 	if (Site = 'Site1') then output site_1 ; */
/* 	if (Site = 'Site2') then output site_2 ; */
/* 	if (Site = 'Site3') then output site_3 ; */
/* 	if (Site = 'Site4') then output site_4 ; */
/* 	if (Site = 'Site5') then output site_5 ; */
/* 	if (Site = 'Site6') then output site_6 ; */
/* 	if (Site = 'Site7') then output site_7 ; */
/* run; */
data  site_1;
	set dataset;

	if (Site = 'Site1') then output site_1 ;
/* 	if (Site = 'Site2') then output site_2 ; */
/* 	if (Site = 'Site3') then output site_3 ; */
/* 	if (Site = 'Site4') then output site_4 ; */
/* 	if (Site = 'Site5') then output site_5 ; */
/* 	if (Site = 'Site6') then output site_6 ; */
/* 	if (Site = 'Site7') then output site_7 ; */
run;
/* PROC NPAR1WAY DATA=site_1;  */
/* CLASS SENSOR; */
/* VAR PPM; */
/* EXACT WILCOXON; RUN; */
PROC NPAR1WAY DATA=site_1; 
CLASS SENSOR;
VAR PPM;
EXACT KS; RUN;