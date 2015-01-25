# run_analysis.R
# Getting and Cleaning Data : Course Project

# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
# zipFile <- "data.zip";
# download.file(url, destfile = zipFile);
# unzip(zipFile, exdir=".");

# Read the test and train datasets and merge them into one dataset
testData <- read.table("./UCI HAR Dataset/test/x_test.txt", header=FALSE, colClasses="numeric");
trainData <- read.table("./UCI HAR Dataset/train/x_train.txt", header=FALSE, colClasses="numeric");
mergedData <- rbind(testData, trainData);

# Read in field names and apply to mergedData
fieldNames <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character");
fieldNames <- fieldNames[,2];
colnames(mergedData) <- fieldNames;

# Extract only mean() and std() data
subsetData <- mergedData[, grep("mean\\(|std\\(", fieldNames)];

# Read in the activity data and merge them into one dataset
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, colClasses="character");
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, colClasses="character");
mergedActivities <- rbind(testActivities, trainActivities);

# Read in activity descriptions and merge it into the activity data
activityDesc <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character");
mergedActivities <- merge(mergedActivities, activityDesc, by.x="V1", by.y="V1");
write.table(mergedActivities, file="ma.csv", sep=",");

# Read in subject data and merge them into one dataset
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, colClasses="numeric");
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, colClasses="numeric");
mergedSubjects <- rbind(testSubjects, trainSubjects);
write.table(mergedSubjects, file="ms.csv", sep=",");

# Combine subjects list, activity list and data into a single data frame
combiData <- cbind(mergedSubjects, mergedActivities[,2], subsetData);
colnames(combiData)[1] = "subject";
colnames(combiData)[2] = "activity";

tidyData <- aggregate(. ~ subject + activity, data=combiData, FUN="mean", na.rm=TRUE);
colnames(tidyData)[3:68] <- paste("Mean",colnames(tidyData)[3:68], sep="");
write.table(tidyData, file="./tidy_data.txt", row.name=FALSE);
