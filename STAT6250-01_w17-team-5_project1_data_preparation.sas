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
https://github.com/stat6250/team-5_project1/blob/master/HospInfo-edited.xlsx
;

*load raw Hospital Dataset over the wire;
filename HOSPtemp TEMP;
proc http
    method="get"
	url="&inputDatasetURL."
	out=HOSPtemp
	;
run;

*The file refers to the path of the file on the local system because
proc import gives error on importing .xlsx files using filename directly.
It works fine on importing .xls and .csv files;
proc import
    file='C:\Users\hu4883\HospInfo-edited.xlsx'
	out=Hosp_raw
	dbms=xlsx
	replace;
	;
run;

filename HOSPtemp clear;

* check raw Hospital dataset for duplicates with respect to its Primary key;
proc sort nodupkey data=Hosp_raw dupout=Hosp_raw_dups out=_null_;
    by Provider_ID;
run;
