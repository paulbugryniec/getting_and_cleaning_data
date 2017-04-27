# getting_and_cleaning_data
Assignment for Getting and Cleaning Data course on coursera

The R script run_analysis.R does the following

1. Imports and merges the required files in one data set called dat.
2. Extracts only the measurements on the mean and standard deviation for each measurement by searching for either "mean" or "std" in the variable names. It then creates a second data set called subDat.
3. Changes the variable acitivity in the subDat set from a ref number to a descriptive name.
4. Give the subDat dataset descriptive variable names.
5. Creates a third data set called tidyData which is a summarised data set from subDat and takes the average of each variable for each activity and each subject.
6. Writes the tidyData set to a text file
