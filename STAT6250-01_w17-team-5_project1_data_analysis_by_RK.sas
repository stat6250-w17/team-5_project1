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
"Research Question 1. What is the distribution of Hospital overall ratings in the State?"
;
title2
"Rationale: This analysis will give the view of the States that have more hospitals with high ratings and which States have low rated hospitals. We can then analyze the health of the patients based on this data."
;
footnote1
"Observation 1: From the above output, We can clearly observe that 8 States in the US have no 4* or 5* hospitals."
;
footnote2
"Observation 2: Also, most of the states have more 2* and 3* rated hospitals and few highly rated which indicates the need of better health care centers in the country"
;
/*
Methodology: PROC FREQ provides a descriptive view of the data which makes it easy to analyze.
It describes the data by reporting the values of distribution variables. This procedure
combines values from various columns and present them in a tabular form which makes it clear 
to understand.
*/

proc freq 
	data=HospInfo_analytic_file;
	Table 
	    State*Hospital_overall_rating;
run;
title;
footnote;



title1
"Research Question 2. How does timely care in a Hospital affect its rating?"
;
title2
"Rationale: Patients usually look for hospitals where they dont have to wait too much in line. This data will give an insight whether care provided on time make any difference in the rating of the hospital."
;
footnote1
"Observation 1 : From the results it can be analyzed that the timeliness of care does not impact the hospital rating to a large extent. Maximum number of hospitals whose care time is above or same as National average lie under 3* and 4* rating."
;
footnote2
"Observation 2 : This eventually means that there are other factors that contribute to the rating of a hospital."
;
/*
Methodology: PROC FREQ provides a descriptive view of the data which makes it easy to analyze.
It describes the data by reporting the values of distribution variables. This procedure
combines values from various columns and present them in a tabular form which makes it clear 
to understand.
*/

proc freq 
	data=HospInfo_analytic_file;
	Table 
	    Hospital_overall_rating*Timeliness_of_care_national_comp;
run;
title;
footnote;



title1
"Research Question 3. Does the Mortality rate rise in absence of Emergency services in a hospital?"
;
title2
"Rationale: The presence of Emergency services can make a huge difference in the death rates. Hospitals who do not provide emergency services to the patients who come there n a critical condition, can be the reason of higher mortality rates."
;
footnote1
"Observation 1 : Around 93% of the hospitals in the country provide Emegency Services to the patients. "
;
footnote2
"Observation 2 : 55% of the emergency service providing hospitals have the mortality rate same as the national average. Mortality rate is lower for only 7% of the hospitals with ES. Hence, we can say that Mortality rate in the nation is not dependent on the facility of Emergency Services."
;
/*
Methodology: PROC FREQ provides a descriptive view of the data which makes it easy to analyze.
It describes the data by reporting the values of distribution variables. This procedure
combines values from various columns and present them in a tabular form which makes it clear 
to understand
*/

proc freq 
	data=HospInfo_analytic_file;
	Table 
	    Emergency_Services*Mortality_national_comparison;
run;
title;
footnote;
