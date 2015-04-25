# GCD_course_project
Coursera course project - README file

This is a README for the production of the output file for the Coursera 
Getting and Cleaning Data course project. The output file is SamsungDataAverages.txt.
The run_analysis.R file is the R script producing the output from the source data. 
The accompanying Codebook file provides more details on the output file. 

The source data is from:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

SamsungDataAverages.txt is produced by running the run_analysis.R script in the 
working directory where the above source data .zip has been extracted. 

The zip source file contains measurement data, taken from 30 subjects doing various
activities while carrying a mobile phone which recorded their physical movement
information. The zip source also includes text files with details 
on the measurements.

The output is achieved by merging the measurement variables in the
'test' and 'train' directories. Then the measurements which are Means and 
Standard Deviations are extracted, and the Mean of those variables are calculated
for each "Subject & Activity" pair.

The resulting output has 180 rows (30 subjects * 6 different activities). It also
has 66 movement measurement variables (averages of the different means and standard 
deviation measurements) for each subject & activity pair.

Finally some of the column/variable labels are modified for clarity, and the output is
saved to the SamsungDataAverages.txt using the write.table() function.