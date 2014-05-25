Getting-And-Cleaning-Data-Course-Project
========================================

Getting And Cleaning Data Course Project Script

script name : run_analysis.R

algorithm:
1. Merge X_train.txt, y_train.txt and subject_train.txt in train folder and features.txt in root folder. features.txt contains the column names for each column in X_train.txt, subject_train.txt contains information on the subject from which each row data are coming from and y_train.txt contains a label of activity type.
2. Merge X_test.txt, y_test.txt and subject_test.txt in test folder and features.txt in root folder. features.txt contains the column names for each column in X_test.txt, subject_test.txt contains information on the subject from which each row data are coming from and y_test.txt contains a label of activity type.
3. Do a row bind of data from part 1 and part 2
4. Create a table that contains columns containing mean measurement only by using grepl function to extract column locations that contain "mean" and "std" in the name. Retain subject and activity columns as identifiers.
5. Use ddply to create average by subject and activity group.
6. Use write table to export required data sets as txt file.


Variables used in Script:
1. activityLabels : Data frame that contains mapping of activity label to activity description
2. trainTable : Data frame that contains data from X_train.txt
3. trainLabels : Data frame that contains data from y_train.txt
4. trainSubject : Data frame that contains data from subject_train.txt
5. trainVariables : Data frame that contains the column names from features.txt
6. testTable : Data frame that contains data from X_test.txt
7. testLabels : Data frame that contains data from y_test.txt
8. testSubject : Data frame that contains data from subject_test.txt
9. testVariables : Data frame that contains the column names from features.txt
10. columnNames : String Vector that contains the column names from trainVariables and testVariables with additional column names of "subject", "activity" and "sample"
11. fullData : Data frame that contains tidy data from train and data set
12. MeanStdData : Scaled down data frame from fullData that contains only columns that has "mean" or "std" in it and also has "activity" and "subject" column.
13. SubjectActivitySummary : Summary of average of each variable by activity and subject.
