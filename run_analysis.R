# read each of the txt files into individual dataframes 
activity_labels <- read.table("UCI_data/activity_labels.txt")
features <- read.table("UCI_data/features.txt")
subject_test <- read.table("UCI_data/test/subject_test.txt")
X_test <- read.table("UCI_data/test/X_test.txt")
Y_test <- read.table("UCI_data/test/y_test.txt")
subject_train <- read.table("UCI_data/train/subject_train.txt")
X_train <- read.table("UCI_data/train/X_train.txt")
Y_train <- read.table("UCI_data/train/y_train.txt")