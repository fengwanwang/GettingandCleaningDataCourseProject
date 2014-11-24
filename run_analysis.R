subject_train <- read.table("./train/subject_train.txt")  ##read in training data sets
x_train <-read.table("./train/X_train.txt")
y_train <-read.table("./train/Y_train.txt")

subject_test <- read.table("./test/subject_test.txt")  ##read in testing data sets
x_test <-read.table("./test/X_test.txt")
y_test <-read.table("./test/Y_test.txt")

features <- read.table("features.txt")     ## read in features and activity labels
activity <- read.table("activity_labels.txt")

data_train <- cbind(subject_train, y_train, x_train)  ##merge training data variables and labels
data_test <- cbind(subject_test, y_test, x_test)      ##merge testing data variables and labels
data_full <- rbind(data_train, data_test)    ##merge training and testing data

names(data_full) <- cbind("Subject","Activity",t(as.character((features$V2))))  ##rename the data frame

data_meanstd <- data_full[,grep("mean()|std()|Subject|Activity",names(data_full))]  ##retrieve the mean and std columns

data_labeled <-merge(activity, data_meanstd, by.y="Activity",by.x="V1",all=TRUE)[,-1] ##get the activity descriptive labels

colnames(data_labeled)[1] <- "Activity" 

library(reshape2)

data_melt <- melt(data_labeled, id = c("Activity", "Subject"))     
data_cast <- dcast(data_melt, Activity + Subject ~ variable, mean)
data_final <- melt(data_labeled, id = c("Activity", "Subject"))
names(data_final) <- c("Activity", "Subject", "Feature", "Mean")
data_final
