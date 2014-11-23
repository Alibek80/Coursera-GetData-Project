# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.

training_set <- read.table("./w3data/train/X_train.txt")
training_labels <- read.table("./w3data/train/y_train.txt")

test_set <- read.table("./w3data/test/X_test.txt")
test_labels <- read.table("./w3data/test/y_test.txt")

training_subject <- read.table("./w3data/train/subject_train.txt")
test_subject <- read.table("./w3data/test/subject_test.txt")

merged_set <- rbind(training_set, test_set)
merged_labels <- rbind(training_labels, test_labels)
merged_subject <- rbind(training_subject, test_subject)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./w3data/features.txt")
features_indices <- grep("-(mean|std)\\(\\)",features[,2])
extracted_data <- merged_set [,features_indices]
names(extracted_data) <- features[features_indices,2]

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("./w3data/activity_labels.txt")
activity_labels <- activities[merged_labels[, 1], 2]
merged_labels[, 1] <- tolower(activity_label)
names(merged_labels) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names. 

names(merged_subject) <- "subject"
all_data <- cbind(merged_subject, merged_labels, extracted_data)
if (!file.exists("w3project")) {
        dir.create("w3project")
}
write.table(all_data, "./w3project/all_data.txt", row.name=FALSE)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)
column_num <- ncol(all_data)
tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 3:column_num]))
write.table(tidy_data, "./w3project/tidy_data.txt", row.name=FALSE)