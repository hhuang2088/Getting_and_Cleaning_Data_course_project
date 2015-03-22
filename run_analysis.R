library(reshape2)

# read each of the txt files into individual dataframes 
activity_labels <- read.table("UCI_data/activity_labels.txt")
features <- read.table("UCI_data/features.txt",stringsAsFactors=FALSE)

# read the test data
test_subject <- read.table("UCI_data/test/subject_test.txt", col.names = "subject")
test_set <- read.table("UCI_data/test/X_test.txt")
test_labels <- read.table("UCI_data/test/y_test.txt", col.names = "activity")

# read the training data
train_subject <- read.table("UCI_data/train/subject_train.txt", col.names = "subject")
train_set <- read.table("UCI_data/train/X_train.txt")
train_labels <- read.table("UCI_data/train/y_train.txt", col.names = "activity")

all_subject <- rbind(test_subject, train_subject, col.names = "subject")
all_set <- rbind(test_set, train_set)
all_labels <- rbind(test_labels, train_labels, col.names = "activity")

# merging the test data
test <- cbind(subject_test, test_labels, test_set)

# merging the training data
train <- cbind(subject_train, train_labels, train_set)

#replacing all number labels with descriptive labels
all_labels[,1]<-gsub(1,"WALKING",all_labels[,1])
all_labels[,1]<-gsub(2,"WALKING_UPSTAIRS",all_labels[,1])
all_labels[,1]<-gsub(3,"WALKING_DOWNSTAIRS",all_labels[,1])
all_labels[,1]<-gsub(4,"SITTING",all_labels[,1])
all_labels[,1]<-gsub(5,"STANDING",all_labels[,1])
all_labels[,1]<-gsub(6,"LAYING",all_labels[,1])

# merging both the test and training data
data <- cbind(all_subject, all_set, all_labels)

# labeling set data with labels provided by features.txt
set_variables <- features[,2]
names(all_set) <- c(set_variables)

# extract mean and standard deviation for each set 
all_set_mean_and_std <- all_set[grep("mean[^F]|std", names(all_set))]

# melt data down to all measurement data. 
data_melt <- melt(data,id=c("subject","activity"),measure.vars=c(names(data)[3:68]))

# cast data to find the average of all subject and activity from data_melt
averages <- dcast(data_melt, subject + activity ~ variable, mean)

# write the averages to a table with no row names
write.table(averages,file="tidydata.txt",row.names=FALSE)