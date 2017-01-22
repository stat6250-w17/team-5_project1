%let dataPrepFileName = STAT6250-01_w17-team-5_project1_data_prep_BP.sas;
%let sasUEFilePrefix = .;

* load external file that generates analytic dataset HospInfo_analytic_file
using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;

%macro setup;
%if
	&SYSSCP. = WIN
%then
	%do;
		X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";			
		%include ".\&dataPrepFileName.";
	%end;
%else
	%do;
		%include "~/&sasUEFilePrefix./&dataPrepFileName.";
	%end;
%mend;
%setup;

/* 
Research Question 1. What is the distribution of Hospital overall ratings in the State?
Rationale: This analysis will give the view of the States that have more hospitals
with high ratings and which States have low rated hospitals. We can then analyze the health
of the patients based on this data.
Methodology: PROC FREQ provides a descriptive view of the data which makes it easy to analyze.
It describes the data by reporting the values of distribution variables. This procedure
combines values from various columns and present them in a tabular form which makes it clear 
to understand.
*/

proc freq data=HospInfo_analytic_file;
	Table State*Hospital_overall_rating;
run;


/*
Research Question 2. How does timely care in a Hospital affect its rating?
Rationale: Patients usually look for hospitals where they dont have to wait too much in line.
This data will give an insight whether care provided on time make any difference in the rating
of the hospital.
Methodology: PROC FREQ provides a descriptive view of the data which makes it easy to analyze.
It describes the data by reporting the values of distribution variables. This procedure
combines values from various columns and present them in a tabular form which makes it clear 
to understand.
*/

proc freq data=HospInfo_analytic_file;
	Table Hospital_overall_rating*Timeliness_of_care_national_comp;
run;
/*
proc sort data=HospInfo_analytic_file out=sorted_data_temp;
	where Timeliness_of_care_national_comp='Above the National Average';
	by Timeliness_of_care_national_comp;
run;
*/


/*
Research Question 3. Does the Mortality rate rise in absence of Emergency services in a hospital?
Rationale: The presence of Emergency services can make a huge difference in the death rates.
Hospitals who do not provide emergency services to the patients who come there n a critical condition,
can be the reason of higher mortality rates.
Methodology: PROC FREQ provides a descriptive view of the data which makes it easy to analyze.
It describes the data by reporting the values of distribution variables. This procedure
combines values from various columns and present them in a tabular form which makes it clear 
to understand
*/

proc freq data=HospInfo_analytic_file;
	Table Emergency_Services*Mortality_national_comparison;
run;




