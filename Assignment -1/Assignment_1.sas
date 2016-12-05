/*********************************************/
			Title ' Exercise 3';	

DATA DataSets;
	INPUT Obs Value @@;
	DATALINES;
	1 	104.3 	6 	99.0 	11 	112.5 	16 	114.0 
	2 	132.4 	7 	109.4 	12 	98.8 	17 	98.9 
	3 	112.4 	8 	101.9 	13 	97.0 	18 	112.1 
	4 	100.7 	9 	100.5 	14 	114.8 	19 	100.6 
	5 	105.3 	10 	110.5 	15 	110.7 	20 	119.3 
	;
RUN;

PROC SORT DATA = DataSets;
	BY Value;
RUN;

DATA DataSets;
	SET DataSets;
RUN;

PROC MEANS DATA = DataSets MEAN STD VAR;
	VAR Value ;
	OUTPUT OUT=Meandetails  MEAN(Value)=MEANValue   STD(Value)=STDValue   VAR(Value)=VARValue; 
RUN;

/*Outliers Detect from dataset by DOORNBOS Test*/
Data DOORNBOS;
	set datasets;
	N=20;
	/*𝑢𝑘 =(𝑦𝑘 − 𝑦̅ )/𝑠 𝑦̅ is mean value, s is square root of standard deviation value*/
	U = (Value - 107.755)/SQRT(77.2605);
	/* Based on value of wk comes from uk value given in course notes*/
	W = SQRT((N*(N-2)*U**2)/((N-1)**2-N*U**2));
	/*We need absolute value*/
	DOORNBOS_FinalValue=ABS(W);
	/*The two-sided test criterion is (1- 𝛼/2𝑛) where alpha is 0.05 and n=20, 18 is t(n-2)*/
	DOORNBOS_Outlier_Criteria= QUANTILE('T', 1-0.05/(2*20), 18);
Run;
PROC SORT DATA =DOORNBOS;
	BY DOORNBOS_FinalValue;
RUN;


PROC PRINT DATA= DOORNBOS;
RUN;

/* Outliers Detects from dataset by Grubbs Test */
Data Grubbs;
	set datasets;
	N= 20;
	U = (Value - 107.755)/SQRT(77.2605);
	Grubbs_FinalValue = ABS(U);
Run;

PROC SORT DATA =Grubbs;
	BY Grubbs_FinalValue;
RUN;

PROC PRINT DATA=Grubbs;
RUN;

/* Outlier detection using Hampel's rule*/
PROC SORT DATA=Datasets OUT=Hampel;
	BY Value;
RUN;

PROC UNIVARIATE DATA=Hampel normal;  
	VAR Value;
RUN;

DATA Hampel;
	SET Hampel;
	D = ABS(Value-107.35);
RUN;

PROC UNIVARIATE DATA=Hampel;
	VAR D;
RUN;

DATA Hampel;
	SET Hampel;
	Z = ABS(Value-107.35)/6.65;
RUN;

PROC PRINT DATA=Hampel;
RUN;

/*Outlier detection using Tukey method*/
PROC UNIVARIATE DATA=Datasets;
	VAR Value;
RUN;
 
DATA TUKEY;
	SET ;
	LOWER = 100.55 - 1.5*11.9;
	UPPER = 112.45 + 1.5*11.9;
RUN;

PROC SORT DATA=TUKEY;
	BY Value;
RUN;

DATA TUKEY;
	SET TUKEY;
	IF Value>UPPER OR Value<LOWER THEN OUTLIER=1;
		ELSE OUTLIER=0;
RUN;

PROC PRINT DATA=TUKEY;
RUN;

/*Outlier detection using BOXPLOT*/
DATA TUKEY;
	SET Datasets;
	GROUP=1;
RUN;


PROC BOXPLOT DATA=TUKEY;
   PLOT  Value*group/boxstyle = schematicid;
   ID OBS;
RUN;QUIT;


