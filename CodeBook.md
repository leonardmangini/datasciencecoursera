Coursera Getting and Cleaning Data- Peer Review Project CodeBook

This file describes the variables, data, and transformations performed to clean up the raw data provided into a tidy data set.

Data and Source:

The raw data comes from the UCI Machine Learning Database.

It was collected from accelerometers in Samsung Galaxy S smartphones.
The phones detected that the people were laying, sitting, standing, walking, going up stairs or down stairs.

Here is the website describing the raw data and how it was collected:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Coursera students downloaded zip files with the raw data from this website:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Data transformations:

The run_analysis.R script retrieves and cleans the raw data producing a text file with "tidy data".

It assumes that the R working directory has been set to the folder that holds the zip file.
The R script assumes that the zip file has been unzipped before it is run.

The zip file creates sub-folders called /train and /test when it is unzipped.
The R script reads raw data from these 2 subfolders and writes a tidy data set into the working directory.

It performs the following steps to clean the data:

Reads X_train.txt, y_train.txt and subject_train.txt from the "./train" folder
Stores them in trainingData, trainingLabels and trainingSubjects respectively

Read X_test.txt, y_test.txt and subject_test.txt from the "./test" folder
Stores them in testData, testLabels and testSubjects respectively.

Loads the plyr package library
Uses the rbind command to append the test data sets at the bottom of the training data sets
Stores them in mergedData, mergedLabels, and mergedSubjects respectively

The script then subsets the mean and standard deviation measurements using the grep command.
It stores the result back in mergedData, mergedLabels, and mergedSubjects

The script then cleans up variable names in the mergedData dataset.
It uses the names and gsub commands to remove parenthesis and dashes and fix capitalization

The script then cleans up the activities in mergedLabels with tolower, toupper and gsub commands.
It removes underscores and take 'ALLCAPS' formats to capitalized first letters of the second half of the name
It saves these back into mergedLabels

It then cleans up the subject names and uses cbind to append mergedSubjects, mergedLabels, mergedData in that order
This is stored in the cleanedupDataSet variable.

Next the script uses the ddply command to apply the colMeans function to replace columns 3 thru 68 with avergaes
This is stored in the frame averaged_data.

Finally this is written out to the textfile tidydata.txt in the working directory.

This text file is tidy in the data science sense:

Each variable is in once column
Each observation has its own row
There variable names and columns are descriptive, have R format (lowercaseUpper) without dashes, parenthesis etc.