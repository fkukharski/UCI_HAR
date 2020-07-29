### README

The ```UCI_HAR``` repository contain files intended for getting and cleaning data from UCI Human Activity Recognition repository from *[this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)*. This project was done as an Course Project at Getting and Cleaning Data Course provided by Johns Hopkins University.

#### List of files:

**1)** ```run_analysis.R``` - the .R script, that does the following:

- download UCI HAR data set from the link above.
- merges the training and the test sets to create one data set.
- extracts only the measurements on the mean and standard deviation for each measurement.
- uses descriptive activity names to name the activities in the data set.
- appropriately labels the data set with descriptive variable names.
- creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- save above data set into .txt file.

**2)** ```CodeBook.md``` - the code book that describes the variables, the data, and all transformations and work that was performed to clean up the data.

**3)** ```data.txt``` - obtained tidy data.

**4)** ```README.md``` - README file.
