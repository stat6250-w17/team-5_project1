*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Hospital quality and patient services.

Dataset Name: FRPM1516_analytic_file created in external file
STAT6250-01_w17-team-5_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

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


title1
"Research Question: What is the mortality rate based on Hospital ownership?"
;

title2
"Rationale: ownership might impact quality of care. private vs. government. By combining Hospital Ownership and Mortality_national_comparison, we can see quality care breakdown
across the various Hospital."
;

footnote1
"Observation:Further analysis indicates 8.3% Above Average and 56% same as National Average"
;
*/
Methodology: The FREQ procedure was used since it is the most descriptive statistical procedure.
Used proc freq to cross-tabulate bins.
;

           
proc freq data=HospInfo_analytic_file;
	Table Mortality_national_comparison*Hospital_Ownership;
run;
title;
footnote;


title1
"Research Question: What is the distribution for the hospital ownership and timeliness of care?"
;

title2
"Rationale: Hospital ownership may contribute how quickly patients are treated."
;
footnote1
"Observation 1: By comparing hospital ownership with patient timeliness of care provides which hosptial are the best."
;
footnote2
"Observation 2: Further analysis indicates 22% Above Average and 33% same as National Average"
;
*/
Methodology: The FREQ procedure was used since it is the most descriptive statistical procedure.
Used proc freq to cross-tabulate bins.
;
proc freq data=HospInfo_analytic_file;
	Table Timeliness_of_care_national_comp*Hospital_Ownership;
run;
title;
footnote;

title1
"Research Question: What is the distribution for the Hospital rating and Readmission?"
;

title2
"Rationale: If hospital rating is lower, do lots of patient return. "
;
footnote1
"Observation 1: For hospital overall rating, 5 is considered to be best and 1 is the worst."
;
footnote2
"Observation 2:Data shows best rated hospital have less readmission(1.7%)."
;
*/
Methodology: The FREQ procedure was used since it is the most descriptive statistical procedure.
Used proc freq to cross-tabulate bins.
;

proc freq data=HospInfo_analytic_file;
	Table Readmission_national_comparison*Hospital_overall_rating;
run;
title;
footnote;
