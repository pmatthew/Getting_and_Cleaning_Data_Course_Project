# Getting_and_Cleaning_Data_Course_Project
Getting and Cleaning Data Course Project by pmatthew

The project contains an R script called run_analysis.R that does the following.

 1. Loads X, y and subject datasets. 
 2. Merges the training and the test sets to create one data set.
 3. Extracts only the measurements on the mean and standard deviation for each measurement.
 4. Uses descriptive activity names to name the activities in the data set, by loading and joining data from activity_labels.txt. 
 5. Appropriately labels the data set with descriptive variable names, by loading and merging data from features.txt. 
 6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Output file of the step 5 is tidy_average.txt. 
