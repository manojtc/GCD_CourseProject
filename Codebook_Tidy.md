Getting and Cleaning Data : Course Project : Codebook
=====================================================

### submitted by Manoj Chandrasekar

The codebook for the raw data is in the file "Codebook_Raw.txt". This codebook file adds to that information and has details about the "tidy_data.txt" file.

The data is in a space-separated text file. The tidy_data.txt file holds a summary of the raw data.

Summarization is done by retaining only the mean and standard deviations in the raw data. Also, it is averaged for each subject and activity.

The fields are as follows -

| Column No. | Column Name | Notes |
|------------|-------------|-----------------------------------------------------------------------|
| 1 | subject | Test Subject ID |
| 2 | activity | Text description of the activity that was monitored |
| 3 to 68 | Mean[...] | Average of mean and standard deviation observations from the raw data |
