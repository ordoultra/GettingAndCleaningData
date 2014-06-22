#File Descriptions

##run_analysis.R  
**Prerequsites:**  Requires table.data R package.
R script which combines and transforms the training and test data sets from into a tidy data set.

##tidy_data.txt
A tidy data set which contains both a combination of the training and test sets including subjects and activity lables.

##tidy_data_means.txt
A tidy data set which contains the mean of all observations by feature column grouped by subject and activity.

#General Processing
##tidy_data.txt
Step 1)  Combine train/subject_train.txt  train/X_train.txt  train/y_train.txt into a single training set.
Step 2)  Combine test/subject_test.txt  test/X_test.txt  test/y_test.txt into a single test set.
Step 3)  Label both training and test data frames with headers provided in features.txt.
Step 4)  Extract columns which contain std or mean strings in the headers ignoring case.  Also include subject and activity columns.
Step 5)  Save the resultant data frame to the file system.

##tidy_data_means.txt
Step 1)  Use the data.table package and lapply to calcualte means of each column grouped by subject and activity.
Step 2)  Clean up headers.
Step 3)  Save the resultant data frame to the file system.

#Instructions
1) Download the Samsung data from:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2) Unzip the compressed file.
3) Place the run_analysis.R script in the 'UCI HAR Dataset' directory.
4) Execute the following command:  
'''bash
Rscript run_analysis.R
'''
