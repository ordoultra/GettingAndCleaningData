#Import data.table package
library(data.table)

#Read in the column labels from the file system.
Labels <- read.table('features.txt', strip.white=TRUE)
subject_id_label = 'Subject_ID'
activity_label = 'Activity'

#Read in the activity descriptions
ActivityLabels <- read.table('activity_labels.txt', strip.white=TRUE)

## Read in, combine, and label the Train sets from the file system
## Params:
##   x - location of X dataset (e.g. X_train.txt, X_test.txt)
##   subject - location of subject dataset (e.g. subject_train.txt, subject_test.txt)
##   y - location of X dataset (e.g. y_train.txt, y_test.txt)
##   subject_id_label - String of the subject id column lable
##   activity_label - String of the activity column lable
## Returns:
##   <data.frame> of combined and tidy data for given train or test set
readAndCombineSets <- function(x, subject, y, Labels, subject_id_label, activity_label)
{
    X <- read.table(x, strip.white=TRUE, stringsAsFactors=FALSE)
    colnames(X) <- Labels$V2

    Subject <- read.table(subject, strip.white=TRUE, stringsAsFactors=FALSE)
    colnames(Subject) <- c(subject_id_label)

    ActLabels_ID <- read.table(y, strip.white=TRUE, stringsAsFactors=FALSE)
    ActLabels <- data.frame(lapply(ActLabels_ID, function(i) ActivityLabels[i,'V2']))
    colnames(ActLabels) <- c(activity_label)

    Data <- cbind(X,Subject)
    Data <- cbind(Data,ActLabels)

    return(Data)
}

Train <- readAndCombineSets('train/X_train.txt', 
                            'train/subject_train.txt',
                            'train/y_train.txt',
                            Labels,
                            subject_id_label,
                            activity_label)

Test <- readAndCombineSets('test/X_test.txt', 
                           'test/subject_test.txt',
                           'test/y_test.txt',
                           Labels,
                           subject_id_label,
                           activity_label)

# Add subject_id and activity labels to Labels dataframe (increment label id)
Labels <- rbind(Labels, data.frame(V1 = max(Labels['V1'])+1, V2 = subject_id_label))
Labels <- rbind(Labels, data.frame(V1 = max(Labels['V1'])+1, V2 = activity_label))

#Append the Train and Test datasets to create one master dataset
Master <- rbind(Train, Test)

#Find the indexes of the labels which contain the standard deviation or mean, ignore case.
regExSearchStr = paste0(subject_id_label, '|', activity_label, '|std|mean') 
ExtractedIndexes <- grep(regExSearchStr, colnames(Master), ignore.case=TRUE)

#Create data frame which only consits of standard deviation or mean 
TidyData <- subset(Master, select=ExtractedIndexes)

#Save the tidy data set to the file system
write.table(TidyData, "tidy_data.txt", sep='|', quote=FALSE, row.names=FALSE)


#Cast TidyData as <data.table>
TD <- data.table(TidyData)

#Calculate means, grouped by Subject_ID and Activity
TDMeans <- data.frame(TD[, lapply(.SD,mean), by=list(Subject_ID,Activity)])

#Clean up column headers
colnames(TDMeans) <- paste0(gsub("\\.","_",colnames(TDMeans)),'_Subject_Activity_Mean')
colnames(TDMeans) <- gsub("__","_",colnames(TDMeans))
colnames(TDMeans) <- gsub("__","_",colnames(TDMeans))
colnames(TDMeans)[1] <- subject_id_label
colnames(TDMeans)[2] <- activity_label

#Save the tidy data means to the file system
write.table(TDMeans, "tidy_data_means.txt", sep='|', quote=FALSE, row.names=FALSE)

