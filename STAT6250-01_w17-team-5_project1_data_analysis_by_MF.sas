
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
1. What is the avalability of Emergency Services based on Hospital Ownership?
Rationale: The Hospital Ownership is a factor that will impact the avalability of Emergency services.
By analyzing the Hospital Owvership by the Emergency services we can determine the the avalability structure of Emergency services
in Government hospitals compared to Non-profit compared to Proprietary.

Methodology: 
PROC freq is a descriptive as well as statistical procedue. It describes data by reporting the
distribution of variable values. The FREQ procedure is used to create crosstabulation tables
that summarize data for two or more categorical variables and also show the number of observations
for each combination of variable values.
*/     
     
proc freq data=HospInfo_analytic_file;
	Table Emergency_Services*Hospital_Ownership;
run;

/*
2. What is the distribution of Patient Experinece based on the Hospital Overall Rating?
Rationale: The Pateint experince can be compared with the hospital overall rating to analyse the overall pateint experince.
It can be analyzed from the results what is the pateint experince for the best rated hospital and the worst rated hospital.
The rating 5 is the best and rating 1 is the worst.

Methodology:
PROC freq is a descriptive as well as statistical procedue. It describes data by reporting the
distribution of variable values. The FREQ procedure is used to create crosstabulation tables
that summarize data for two or more categorical variables and also show the number of observations
for each combination of variable values. 
*/

proc freq data=HospInfo_analytic_file;
  Table Patient_experience_national_comp*Hospital_overall_rating;
run;

/*
3. What is the distribution of Efficient use of medical imaging systems?
Rationale: The efficient use of medical imaging can be compared with the hospital ownership. This analysis will help understand
the efficiency of medical imaging systems with respect to Governemnt, non-profit, propreitary hospitals.

Methodology:
PROC freq is a descriptive as well as statistical procedue. It describes data by reporting the
distribution of variable values. The FREQ procedure is used to create crosstabulation tables
that summarize data for two or more categorical variables and also show the number of observations
for each combination of variable values.
*/
proc freq data=HospInfo_analytic_file; 
  Table Efficient_use_of_medical_imaging*Hospital_Ownership;

run;
/*
4. What Hospital type has the best Hospital overall rating?
Rationale: List Accute care hospitals, critical care hospitals, childrens hospital
with rating 1.
Methodology: 
PROC means procedure is used to summarize the dataset using Output statement.
Also Class statement is used to produce separte analyses for grouping the obsevations
or overall rating.
*/

proc means mean noprint data=HospInfo_analytic_file;
    class Hospital_type;
    var Hospital_overall_rating;
    output out=HospInfo_analytic_file_temp;
run;
proc sort data=HospInfo_analytic_file_temp;
    by Hospital_type;
    where Hospital_overall_rating=5;
run;
