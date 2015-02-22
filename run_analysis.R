# Step 1: Merge the training and the test sets to create one data set.
#
# Assumes this R script is in the same working directory as the folders /train and /test
# setwd("/Users/ManginiActuarialAndRiskAdvisoryLLC/datasciencecoursera/UCI HAR Dataset")
#
# load ncessary libraries
library(plyr)
#
# X_train contains training data so load into a variable named appropriately
trainingData <- read.table("./train/X_train.txt")
#
# y_train contains data lables so load into a variable named appropriately
trainingLabels <- read.table("./train/y_train.txt")
#
# subject_train contains subject data so load into a variable named appropraitely 
trainingSubjects <- read.table("./train/subject_train.txt")
#
# X_test contains test data so load into a variable named appropriately
testData <- read.table("./test/X_test.txt")
#
# y_test contains labels for test data so load into a variable named approporiately
testLabels <- read.table("./test/y_test.txt") 
#
# subject_test conatins test subject data so load into a variable named appropriately
testSubjects <- read.table("./test/subject_test.txt")
#
# Use the plyr package command rbind to merge the three pairs of training and data sets
mergedData <- rbind(trainingData, testData)
mergedLabels <- rbind(trainingLabels, testLabels)
mergedSubjects <- rbind(trainingSubjects, testSubjects)
#
#
# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
features <- read.table("./features.txt")
# 
# use grep to find variables with mean and std in their titles
mean_and_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])
#
# subset these measurements from the merged data table
mergedData <- mergedData[, mean_and_std]
# clean up the variable names by removing (), capitalizing first letters, removing - dashes
names(mergedData) <- gsub("\\(\\)", "", features[mean_and_std, 2])
names(mergedData) <- gsub("mean", "Mean", names(mergedData))
names(mergedData) <- gsub("std", "Std", names(mergedData))
names(mergedData) <- gsub("-", "", names(mergedData))
#
#
# Step 3. Use descriptive activity names to name the activities in data set
#
activities <- read.table("./activity_labels.txt")
#
# clean up fully capitalized names, remove underscores, recapitalize second half as standard R naming
#
activities[, 2] <- tolower(gsub("_", "", activities[, 2]))
substr(activities[2, 2], 8, 8) <- toupper(substr(activities[2, 2], 8, 8))
substr(activities[3, 2], 8, 8) <- toupper(substr(activities[3, 2], 8, 8))
#
activitiesLabels <- activities[mergedLabels[, 1], 2]
mergedLabels[, 1] <- activitiesLabels
names(mergedLabels) <- "activities"
#
#
# Step 4. Appropriately label subject data set with descriptive names
#
names(mergedSubjects) <- "subject"
#
# bind all three cleaned and merged tables column-wise into new data set
cleanedupDataSet <- cbind(mergedSubjects, mergedLabels, mergedData)
#
# Step 5. Create second, independent tidy dataset with avg of each variable for each activity/subject. 
#
# Use the ddply command to apply colMeans to the last 66 columns with numeric data
averaged_data<-ddply(cleanedupDataSet, .(subject, activities), function(x) colMeans(x[,3:68]))
#
# write out data with averages as our tidy_data file
write.table(averaged_data, "tidy_data.txt", row.name=FALSE)
#
#
