GettingandCleaningDataCourseProject
===================================
Step 1:
I started by reading the data sets. There're 8 datasets to read in: 3 train data sets, 3 test data sets, 1 feature data set and 1 activity_label dataset. 

Then I used cbind to put the subject label and activity label togehter with the corresponding training and testing sets. I obtained two data frames. 
data_train is the train data set with dimension 7352x563.
data_test is the test data set with dimension 247x563. 

Then I used rbind to merge the train dat and test data. Obtained the data_full data frame with dimension 10299x563. 

Use the names() function to rename the columns of data_full. The command is:

names(data_full) <- cbind("Subject","Activity",t(as.character((features$V2))))

The first column is the Subject, the 2nd column is the Activity. And for the rest of the variables the column names comes from the 2nd column of the feature table. 

Step 2:
Out of the properly labeled data_full data set, extract only the measurements on the mean and standard deviation for each measurement. The command is:

data_meanstd <- data_full[,grep("mean()|std()|Subject|Activity",names(data_full))]

Step 3:
Uses descriptive activity names to name the activities in the data set. I used the merge() to do this step and dropped the first column which is the numeric Activity label. The commands are:

data_labeled <-merge(activity, data_meanstd, by.y="Activity",by.x="V1",all=TRUE)[,-1]
colnames(data_labeled)[1] <- "Activity" 

Step 4 & Step 5:

The commands are:

library(reshape2)

data_melt <- melt(data_labeled, id = c("Activity", "Subject"))     
data_cast <- dcast(data_melt, Activity + Subject ~ variable, mean)
data_final <- melt(data_labeled, id = c("Activity", "Subject"))
names(data_final) <- c("Activity", "Subject", "Feature", "Mean")
data_final

Here I used the melt() function to first transform the data set into a long narrow data frame with 813621 obs. of 4 variables. 
Then I used the dcast() function to calculate the mean of each measurement for each activity and each subject, which gives me a wide data_cast data frame with 180 obs. of 81 variables. 
Then I melted the data set again with melt() to get a final data set with 813621 obs. of 4 variables. 
I labeled data_final with the names() function. 
The data_final dataset is a tidy dataset in the long narrow form. 








