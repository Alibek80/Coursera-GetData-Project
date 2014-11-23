# Coursera Getting and Cleaning Data Course Project Codebook

## Data Description

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

### For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

### The dataset includes the following files:
*  'features.txt': List of all features.
*  'activity_labels.txt': Links the class labels with their activity name.
*  'train/X_train.txt': Training set.
*  'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train (or test)/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

### A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### The script "run_analysis.R" performs the following:

* Merges the training and the test sets to create one data set. 
	- Reads data from "w3data/train/X_train.txt" and "./w3data/train/X_train.txt" files and then joins them into the "merged_set" data frame.
	- Reads labels from "w3data/train/y_train.txt" and "w3data/test/y_test.txt" files and then joins them into the "merged_labels" data frame.
	- Reads subjects from "w3data/train/subject_train.txt" and "w3data/test/subject_test.txt" files and then  joins them into the "merged_subject" data frame.

* Extracts only the measurements on the mean and standard deviation for each measurement. 
	- Reads "w3data/features.txt" file to "features" data frame.
	- Extracts names of variables of data with the mean and standard deviation only and loads their indices into "features_indices" variable.
	- Subsets original data to "extracted_data" data frame containing only measurements on the mean and standard deviation.
	- Assignes names of variables to "extracted_data" data set.

* Uses descriptive activity names to name the activities in the data set
	- Reads activities names from "w3data/activity_labels.txt" and then substitutes the indices of activities to their names.

* Appropriately labels the data set with descriptive variable names. 
	- Merges data all together in the "all_data" data frame: first - subject index, then activity name, then all other data from "extracted_data" data frame.
	- Writes "all_data" data frame into "/w3project/all_data.txt" file (if "w3project" folder doesn't exist - creates this folder).

* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	- Creates "tidy_data" data frame with "ddply" function (in plyr package)  data with the average of each variable for each activity and each subject by calling "colMeans" from 3rd to last column. The first two columns are scipped as they are subject and activity.
	- Writes "tidy_data" data frame into "w3project/tidy_data.txt" file.
