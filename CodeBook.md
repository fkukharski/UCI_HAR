### Code book

The ```run_analysis.R``` script get UCI HAR data and make it tidy.

**1) Downloading and preparing data:**

- if data is already downloaded and located in ```Dataset``` folder in working directory, this step can be skipped. If not, data is downloaded from *[this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)*. Zip-file is unzipped in working directory to the ```Dataset``` folder.

**2) Reading internal data:**

- data from ```activity_labels.txt``` file is written to ```activity_labels``` variable. Compare six types of activity with its code.
- data from ```features.txt``` file is written to ```features``` variable. Contain all features selected for this database, that comes from accelerometer and gyroscope and transformed variables.
- data from ```test/X_test.txt``` file is written to ```x_test``` variable. Contain measurements by all of the features from ```feature``` variable.
- data from ```test/subject_test.txt``` file is written to ```subject_test``` variable. Contain information about 30% (9/30 people) volunteers, links the person and a row (measurement) in ```x_test``` data.
- data from ```test/y_test.txt``` file is written to ```y_test``` variable. Contain information about activities, links the type of activity and a row (measurement) in ```x_test``` data.
- data from ```train/X_train.txt``` file is written to ```x_train``` variable. Contain measurements by all of the features from ```feature``` variable.
- data from ```train/subject_train.txt``` file is written to ```subject_test``` variable. Contain information about 70% (21/30 people) volunteers, links the person and a row (measurement) in ```x_train``` data.
- data from ```train/y_train.txt``` file is written to ```y_train``` variable. Contain information about activities, links the type of activity and a row (measurement) in ```x_train``` data.

**3) Merging test and train data:**

- ```x_merged``` variable created by merging ```x_test``` and ```x_train``` data using ```rbind()``` function.
- ```y_merged``` variable created by merging ```y_test``` and ```y_train``` data using ```rbind()``` function.
- ```subject_merged``` variable created by merging ```subject_test``` and ```subject_train``` data using ```rbind()``` function.
- ```merged_data``` variable created by merging ```subject_merged```, ```y_merged``` and ```x_merged``` data using ```cbind()``` function.

**4) Extracting mean and standard deviation measurements:**

- ```data``` variable created by selecting ```mean``` and ```std``` measurements from ```merged_data``` variable using function ```select()``` from ```dplyr``` package and ```contains()``` selector on key-words ```"mean"``` and ```"std"```.

**5) Using descriptive activity names to name the activities in the data set:**

- all numbers from ```activityID``` column at ```data``` variable replaced with descriptive activity names accordingly to ```activity_labels``` variable.

**6) Creating approriate descriptive variable names:**

- ```activityID``` column at ```data``` renamed into ```activity```.
- character ```t``` at the beginning of the all names replaced by ```Time```.
- character ```f``` at the beginning of the all names and ```Freq``` parts replaced by ```Frequency```.
- all parts ```Acc``` replaced by ```Acceleration```.
- all parts ```Gyro``` replaced by ```Gyroscope```.
- all parts ```Mag``` replaced by ```Magnitude```.
- all parts ```tBody``` replaced by ```TimeBody```.
- all parts ```angle``` replaced by ```Angle```.
- all parts ```gravity``` replaced by ```Gravity```.
- repeated parts ```BodyBody``` replaced by ```Body```.
- all function names ```mean``` replaced by ```Mean```.
- all function names ```std``` replaced by ```STD```.

**7) Creating dataset with the average of each variable for each activity and each person:**

- new dataset called ```averaged_data``` created by converting ```data``` data-frame into data-table.
- ```averaged_data``` dataset grouped by two columns ```personID``` and ```activity```, values in other columns are averaged using ```mean``` function and ```lapply``` function. Obtained dataset ```averaged_data``` is sorted by ```personID``` column in increasing order.
- obtained dataset ```averaged_data``` saved into ```data.txt``` file in working directory.