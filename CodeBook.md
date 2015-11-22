### The code book for Coursera "*Getting And Cleaning Data*" Course Project

***

#### Data

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

***

#### Variable Names

The variable names are found in the file "features.txt".  There are total 561 features/variables collected during the experiments.  Please refer to the file "features_info.txt" for detailed description of all the features. These features form the basis for column labels of the final tidy dataset.  

The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

***

#### Transformations
1. While the feature names pretty much follow the naming convention of the variable labels, some transformations were applied.

  + Feature variables that included "mean()" or "std()" in their labels were kept. Note that feature variables that include "mean" or "std" as part of their names, for example, "meanfreq", were dropped because these were not calculated the same way as the other kept features that include "mean()" or "std()".

  + The sepcial chracters "()" were removed from variable names for better readability. 

2. The train and test data each contain a subjectID and an activityID.  The activityID was used as a key to join train or test data frame with activity label data frame, thereby assigning the correct activity labels. The activityID was then dropped. 

3. The test and train data sets were then merged into one dataset.  This merged dataset was then ordered by subjectID and activity label.  The mean was cauculated for each of the variables (measurements).  The string "Mean_" was finally affixed to the beginning of each feature variable name. The new tidy data set was saved to a file named "newTidyData.txt".


