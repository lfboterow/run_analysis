Run_analysis.R

This script takes a file @ https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Decompresses it into the following tables as illustrated by David Hood (Community TA @ Coursera)

Variable Names       	Features.txt 	subject			Activity
----------------------------------------------------------------------------------------------------------
Data		   	x_train.txt	subject_train.txt	y_train.txt	|
			x_test.txt	subject_test.txt	y_test.txt	|     activity_labels.txt

Processing:
1. Sets working directory, creates temp directory to unzip files
2. Downloads zip files
3. Decompresses zip files
4. Reads files: x_train.txt, x_test.txt, subject_train.txt, subject_test.txt, y_train.txt, y_test.txt, activity_labels.txt, features.txt
5. Sets column names for x_train and x_test,  Activity names: y_train and y_test bring complete activity description. Subject_test.txt brings subjects.
6. Merges columns into a single data frame  (DT)
7. Saves DT as a comma separated values file   HAR.csv
8. Aggregates the dataframe to get mean of all the variables, by calculating mean of the variables that include ..mean.. into DT5 data frame

