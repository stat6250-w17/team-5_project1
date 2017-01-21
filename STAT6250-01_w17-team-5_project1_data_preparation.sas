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
