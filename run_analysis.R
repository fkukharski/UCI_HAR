# zip file must be in a working directory "UCI_HAR"
zip_file <- "getdata_projectfiles_UCI HAR Dataset.zip"

# if the zip file doesn't exist, download it to the wd
if (!file.exists(zip_file)){
        zip_file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(zip_file_URL, zip_file)
}

# if Dataset-folder doesn't exist, unzip the file and rename unzipped folder
if (!file.exists("Dataset")){
        unzip(zip_file)
        file.rename("UCI HAR Dataset", "Dataset")
}

# reading activity_labels and feature files
activity_labels <- read.table(".//Dataset//activity_labels.txt", col.names = c("activityID", "activity"))
features <- read.table(".//Dataset//features.txt", col.names = c("n", "feature"))

# reading test data
x_test <- read.table(".//Dataset//test//X_test.txt", col.names = features$feature)
y_test <- read.table(".//Dataset//test//y_test.txt", col.names = "activityID")
subject_test <- read.table(".//Dataset//test//subject_test.txt", col.names = "personID")

# reading train data
x_train <- read.table(".//Dataset//train//X_train.txt", col.names = features$feature)
y_train <- read.table(".//Dataset//train//y_train.txt", col.names = "activityID")
subject_train <- read.table(".//Dataset//train//subject_train.txt", col.names = "personID")

# merging test and train data
x_merged <- rbind(x_test, x_train)
y_merged <- rbind(y_test, y_train)
subject_merged <- rbind(subject_test, subject_train)
merged_data <- cbind(subject_merged, y_merged, x_merged)

# extracting mean and std measurements
data <- select(merged_data, personID, activityID, contains("mean"), contains("std"))

# name activities using descriptive activity names
data$activityID <- activity_labels[data$activityID, 2]
names(data)[2] <- "activity"

# create descriptive variable names
names(data) <- gsub("^t", "Time", names(data))
names(data) <- gsub("Freq", "Frequency", names(data))
names(data) <- gsub("^f", "Frequency", names(data))
names(data) <- gsub("Acc", "Acceleration", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))
names(data) <- gsub("tBody", "TimeBody", names(data))
names(data) <- gsub("angle", "Angle", names(data))
names(data) <- gsub("std", "STD", names(data))
names(data) <- gsub("mean", "Mean", names(data))
names(data) <- gsub("gravity", "Gravity", names(data))

# dataset with the average of each variable for each activity and each person
averaged_data <- data.table(data)
averaged_data <- averaged_data[, lapply(.SD, mean), by = c("personID", "activity")]
averaged_data <- averaged_data[order(personID)]

# writing data table into file
write.table(averaged_data, "data.txt", row.names = FALSE)
