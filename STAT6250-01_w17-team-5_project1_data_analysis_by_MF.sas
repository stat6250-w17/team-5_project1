*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding Hospital quality and services.

Dataset Name: HospInfo_analytic_file created in external file
STAT6250-01_w17-team-5_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

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

title1
"Research Question: What is the avalability of Emergency Services based on Hospital Ownership?"
;
title2
"Rationale: The Hospital Ownership is a factor that will impact the avalability of Emergency services.
By analyzing the Hospital Owvership by the Emergency services we can determine the the avalability structure of Emergency services
in Government hospitals compared to Non-profit compared to Proprietary."
;
footnote1
"Observation 1: The results show that 93.86% of hospitals are equppied with Emergency services and out of the the
Non-profit private hospitals have a larger share of 40.21% hospitals with Emergency services"
;
footnote2
"Observation 2: Similarly the output also shows that 6.14% of hospaitals are not equipped with Emergency services and out of that
Non-profit pivate hospiatls have a larger share of 2.16%. The government and tribal hospitals have a fair number of 
hospitals with emergency services (based on the total number of hospitals in the respective sector."
*
Methodology: 
PROC freq is a descriptive as well as statistical procedue. It describes data by reporting the
distribution of variable values. The FREQ procedure is used to create crosstabulation tables
that summarize data for two or more categorical variables and also show the number of observations
for each combination of variable values.
;
     
proc freq data=HospInfo_analytic_file;
	Table Emergency_Services*Hospital_Ownership;
run;
title;
footnote;


title1
"Research Question: What is the distribution of Patient Experinece based on the Hospital Overall Rating?"
;
title2
"Rationale: The Pateint experince can be compared with the hospital overall rating to analyse the overall pateint experince.
It can be analyzed from the results what is the pateint experince for the best rated hospital and the worst rated hospital.
The rating 5 is the best and rating 1 is the worst."
;
footnote1
"Observation 1: The hospitals with Pateint experience above national average have more number of 4* and 5* rated hospitals."
;
footnote2
"Observation 2: The hospitals with Pateint experience same as national average have more number of 2* and 3* rated hospitals
The hospitals with Patient experince below national average have more number of 1* 2* and 3* rated hospitals."

*
Methodology:
PROC freq is a descriptive as well as statistical procedue. It describes data by reporting the
distribution of variable values. The FREQ procedure is used to create crosstabulation tables
that summarize data for two or more categorical variables and also show the number of observations
for each combination of variable values. 
;

proc freq data=HospInfo_analytic_file;
  Table Patient_experience_national_comp*Hospital_overall_rating;
run;
title;
footnote;


title1
"Research Question: What is the distribution of Efficient use of medical imaging systems?"
;
title2
"Rationale: The efficient use of medical imaging can be compared with the hospital ownership. This analysis will help understand
the efficiency of medical imaging systems with respect to Governemnt, non-profit, propreitary hospitals."
;
footnote1
"Observation 1: There are higher number of Non-profit private hospitals in each rating category of efficiency of medical imaging systems"
;
footnote2
"Observation 2: Distribution of effiency of medical imaging systems has no correlation with hospital ownership. There may be other factors that should be evalauted for effectiveness of imaging systems."
*
Methodology:
PROC freq is a descriptive as well as statistical procedue. It describes data by reporting the
distribution of variable values. The FREQ procedure is used to create crosstabulation tables
that summarize data for two or more categorical variables and also show the number of observations
for each combination of variable values.
;
proc freq data=HospInfo_analytic_file; 
  Table Efficient_use_of_medical_imaging*Hospital_Ownership;
run;
title;
footnote;
