Getting and Cleaning Data : Course Project : README
===================================================

### submitted by Manoj Chandrasekar

## Step 1:
Download raw data. Uncomment the "url <... " and the "download.fi..." lines to download the data file if it doesn't already exist

	# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
	zipFile <- "data.zip";
	# download.file(url, destfile = zipFile);
	unzip(zipFile, exdir=".");

## Step 2: 
Load and merge the base data sets (test and train).


	testData <- read.table("./UCI HAR Dataset/test/x_test.txt", header=FALSE, colClasses="numeric");
	trainData <- read.table("./UCI HAR Dataset/train/x_train.txt", header=FALSE, colClasses="numeric");
	mergedData <- rbind(testData, trainData);


## Step 3:
Assign proper field names in the loaded datasets. Field names are in the 'features.txt' file.


	fieldNames <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character");
	fieldNames <- fieldNames[,2];
	colnames(mergedData) <- fieldNames;


## Step 4:
As per the assignment requirements, load only mean and standard deviations. This code uses regular expressions to match "mean(" and "std(" in the column names to identify them as mean or standard deviation


	subsetData <- mergedData[, grep("mean\\(|std\\(", fieldNames)];


## Step 5:
Read in the activity data and merge them into one dataset


	testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, colClasses="character");
	trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, colClasses="character");
	mergedActivities <- rbind(testActivities, trainActivities);


## Step 6:
Read in activity descriptions and merge it into the merged activity data


	activityDesc <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character");
	mergedActivities <- merge(mergedActivities, activityDesc, by.x="V1", by.y="V1");
	write.table(mergedActivities, file="ma.csv", sep=",");


## Step 7:
Read in subjects data files (test and train) and merge them into one dataset


	testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, colClasses="numeric");
	trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, colClasses="numeric");
	mergedSubjects <- rbind(testSubjects, trainSubjects);
	write.table(mergedSubjects, file="ms.csv", sep=",");


## Step 8:
Combine subjects list, activity list and data into a single data frame


	combiData <- cbind(mergedSubjects, mergedActivities[,2], subsetData);
	colnames(combiData)[1] = "subject";
	colnames(combiData)[2] = "activity";


## Step 9:
Create an aggregated dataset and store it in a "tidy_data.txt" file.


	tidyData <- aggregate(. ~ subject + activity, data=combiData, FUN="mean", na.rm=TRUE);
	colnames(tidyData[3:68]) <- paste("Mean",colnames(tidyData[3:68]), sep="");
	write.table(tidyData, file="./tidy_data.txt", row.name=FALSE);

