Getting and Cleaning Data - Project information.
This is the course project for Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:
1. Download the dataset if it does not already exist in the working directory.
2. Load the activity.
3. Load feature info.
4. Loads both training and test datasets, with only those columns which has mean or standard deviation.
5. Loads activity and subject data for train and test dataset.
6. Merges train and test datasets.
7. Converts the activity and subject columns into factors.
8. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
9. The end result is in the file tidy.txt.
