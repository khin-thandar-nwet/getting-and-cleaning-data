# getting-and-cleaning-data
 The goal is to prepare tidy data that can be used for later analysis. This file contains the following contents
 1. Tidy data set in the name of run_analysis.R
 2.codebook that explains the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md
 3.README.md that explains how the work has been done
 # Data description
 The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
# Code explaination
The code combined training dataset and test dataset, and extracted partial variables to create another dataset with the averages of each variable for each activity.
# The code was written based on the instruction of this assignment
Read training and test dataset into R environment. Read variable names into R envrionment. Read subject index into R environment.

1.Merges the training and the test sets to create one data set. Use command rbind to combine training and test set
2.Extracts only the measurements on the mean and standard deviation for each measurement. Use grep command to get column indexes for variable name contains "mean()" or "std()"
3.Uses descriptive activity names to name the activities in the data set Convert activity labels to characters and add a new column as factor
4.Appropriately labels the data set with descriptive variable names. Give the selected descriptive names to variable columns
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Use pipeline command to create a new tidy dataset with command group_by and summarize_each in dplyr package
