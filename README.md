##File Descriptions

###run_analysis.R  
**Prerequsites:**  Requires table.data R package.  For further info please refer to http://cran.r-project.org/web/packages/data.table/index.html.

**Description:**  R script which combines and transforms the training and test data sets from into a tidy data set.  Data sets can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

###tidy_data.txt
**Description:**  A tidy data set which contains both a combination of the training and test sets including subjects and activity lables.

###tidy_data_means.txt
**Description:**  A tidy data set which contains the mean of all observations by feature column grouped by subject and activity.

##General Processing
The run_analysis.R script performs the necessary R code to read in, combine, and label the Samsung data set.  A series of steps is take to create a tidy data set.  Further processing details are documented in [CODEBOOK.md](https://github.com/ordoultra/GettingAndCleaningData/blob/master/CODEBOOK.md "Descriptive Data Code Book")

##Instructions
1.  Download the Samsung data from:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2.  Unzip the compressed file.
3.  Place the run_analysis.R script in the 'UCI HAR Dataset' directory.
4.  Execute the following command:  `Rscript run_analysis.R`

