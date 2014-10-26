The Base Data Set
=================

The base data set is split into tests and training sets, each one also split
into three files containing measurements, activities and subjects. Those files
and sets are merged by the `run_analysis.R` script.

The `run_analysis.R` R Script
=============================

The R script does not require any additional parameter to be run. It first
downloads the base date set in the current directory if required. Then, the
following operations are performed on the loaded data:

* merges the training and test sets to create one data set,
* replaces activity values in the dataset with descriptive activity names,
* extracts only the measurements on the mean and standard deviation for each
measurement,
* appropriately labels the columns with descriptive names,
* creates a tidy CSV data set `tidy-data.csv` with an average of each variable
for each each activity and each subject.

**Note:** this script requires the `data.table` package.

The `tidy-data.csv` CSV File
============================

The `run_analysis.R` R script produces a CSV file with 68 columns :

* **Activity** label,
* **Subject** identifier,
* 33 mean features,
* and 33 standard deviation features.

The 10299 found observations are merged in 180 groups (6 activities and 30
subjects), with the average for each mean and standard deviation features being
computed. The result is saved as a CSV file, with the appropriate headers at the
first line of the file.