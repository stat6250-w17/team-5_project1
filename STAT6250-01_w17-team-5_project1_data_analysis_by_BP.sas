
%let dataPrepFileName = STAT6250-01_w17-team-5_project1_data_preparation.sas;
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
1. What is the mortality rate based on Hospital ownership?
Rationale: ownership might impact quality of care. private vs. government.
By combining Hospital Ownership and Mortality_national_comparison, we can see quality care breakdown
across the various Hospital.
Methodology: The FREQ procedure was used since it is the most descriptive statistical procedure.
Used proc freq to cross-tabulate bins.


*/
           
proc freq data=HospInfo_analytic_file;
	Table Mortality_national_comparison*Hospital_Ownership;
run;


/*
2. What is the distribution for the hospital ownership and timeliness of care?
Rationale: Hospital ownership may contribute how quickly patients are treated.
By comparing hospital ownership with patient timeliness of care provides which hosptial are the best.
Methodology: The FREQ procedure was used since it is the most descriptive statistical procedure.
Used proc freq to cross-tabulate bins.
*/

proc freq data=HospInfo_analytic_file;
	Table Timeliness_of_care_national_comp*Hospital_Ownership;
run;

/*
3. What is the distribution for the Hospital rating and Readmission?
[Rationale] If hospital rating is lower, do lots of patient return. 
For hospital overall rating, 5 is considered to be best and 1 is the worst. 
Data must show best rated hospital have less readmission.
Methodology: The FREQ procedure was used since it is the most descriptive statistical procedure.
Used proc freq to cross-tabulate bins.
*/

proc freq data=HospInfo_analytic_file;
	Table Readmission_national_comparison*Hospital_overall_rating;
run;

