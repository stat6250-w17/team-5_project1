*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
This file prepares the dataset described below for analysis.
Dataset Name: Hospital General Information
Experimental Units: All US hospitals
Number of Observations: 4,807
Number of Features: 28
Data Source: https://www.kaggle.com/cms/hospital-general-information/downloads/
hospitalgeneralinformation.zip 
This dataset is available on kaggle.com and is provided by Centers for 
Medicare & Medicaid Services. The data was downloaded as a Zip file, which 
on extraction gives a csv file. 
The file was edited to produce file HospInfo-edited.xls by 
-deleting the column "Location" as it had no values
-Reformatting the column headers to contain the only characters permitted in 
SAS variable names and
-setting all cell values to "Text" format
Data Dictionary: worksheet "Data Field Descriptions" in file HospInfo-edited.xls
Unique ID: The columns Provider_ID serves as the Primary key.
It has unique ID for each hospital.
;

* setup environmental parameters;
%let inputDatasetURL =
http://filebin.ca/39gOt3ZfiNuv/HospInfo-edited.xls
;

* load raw FRPM dataset over the wire;
filename HOSPtemp TEMP;
proc http
    method="get" 
    url="&inputDatasetURL." 
    out=HOSPtemp
    ;
run;
proc import
    file=HOSPtemp
    out=Hosp_raw
    dbms=xls
    replace
    ;
run;
filename HOSPtemp clear;

* check raw FRPM dataset for duplicates with respect to its composite key;
proc sort nodupkey data=Hosp_raw dupout=Hosp_raw_dups out=_null_;
    by Provider_ID;
run;

* build analytic dataset from HOSP dataset with the least number of columns and
minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;
data HospInfo_analytic_file;
    retain
    	Mortality_national_comparison
        Hospital_Type
        Hospital_Ownership
        Timeliness_of_care_national_comp
        Readmission_national_comparison
    ;
    keep
        Mortality_national_comparison
        Hospital_Type
        Hospital_Ownership
        Timeliness_of_care_national_comp
        Readmission_national_comparison
    ;
    set Hosp_raw;
run;
