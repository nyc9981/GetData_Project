# download and unzip the data file to current working directory
# Execute the following commented code only once in the beginning
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
#                "getdataProject2Data.zip", method="curl")
# unzip("getdataProject2Data.zip")

library(dplyr)

train_x_file <- "./UCI HAR Dataset/train/X_train.txt"
train_y_file <- "./UCI HAR Dataset/train/y_train.txt"
train_subjectID_file <- "./UCI HAR Dataset/train/subject_train.txt"

test_x_file <- "./UCI HAR Dataset/test/X_test.txt"
test_y_file <- "./UCI HAR Dataset/test/y_test.txt"
test_subjectID_file <- "./UCI HAR Dataset/test/subject_test.txt"

feature_file <- "./UCI HAR Dataset/features.txt"
activity_label_file <- "./UCI HAR Dataset/activity_labels.txt"

# function:  build data from four files
buildData <- function(x_file, y_file, subjectID_file, 
                      feature_file, activity_label_file) {
    require(dplyr)
    
    # read each file with proper classes, assign proper names
    x_df <- read.table(x_file)
    y_df <- read.table(y_file, col.names = c("activityID"))
    subjectID_df <- read.table(subjectID_file, col.names = c("subjectID"))
    feature_df <- read.table(feature_file, colClasses = c("integer", "character"),
                             col.names = c("featureID", "feature"))
    activity_label_df <- read.table(activity_label_file, 
                                    colClasses = c("integer", "character"),
                                    col.names = c("activityID", "activity"))
    
    # make the duplicate feature names unique, and assign them to x_df col names
    names(x_df) <- make.unique(feature_df$feature)

    # process all the necessary data frames to build the data set
    dat <- 
        x_df %>% 
        tbl_df %>% 
        select(contains("mean()"), contains("std()")) %>%
        bind_cols(y_df, subjectID_df) %>%
        inner_join(activity_label_df, by = "activityID") %>%
        select(subjectID, activity, everything(), -activityID)
    
    # Remove ( and ) from the col names
    names(dat) <- gsub("[()]", "", names(dat))
    
    dat
}

# build training data set
trainData <- buildData(train_x_file, train_y_file, train_subjectID_file, 
                       feature_file, activity_label_file)
# build test data set
testData <- buildData(test_x_file, test_y_file, test_subjectID_file, 
                      feature_file, activity_label_file)
# combine training and test data sets
dataSet <- bind_rows(trainData, testData)

# process dataSet to make a new tidy data set
newTidyDataSet <- 
    dataSet %>%
    group_by(subjectID, activity) %>%
    summarize_each( funs(mean) ) %>%
    setNames(c( "subjectID", "activity", paste0( "Mean_", names(dataSet)[-c(1,2)]) ))

#save the new tidy data set to a file named "newTidyData.txt"
write.table(newTidyDataSet, file="newTidyData.txt", row.names = FALSE)
