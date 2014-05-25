tidyData <- function() {
    library(plyr)
    
    ## Read external data    
    activityLabels <- data.frame(label = c(1, 2, 3, 4, 5, 6), desc = c("WALKING", 
        "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
    trainTable <- read.table("./Dataset/train/X_train.txt")
    trainLabels <- read.table("./Dataset/train/y_train.txt")
    trainSubject <- read.table("./Dataset/train/subject_train.txt")
    trainVariables <- read.table("./Dataset/features.txt")
    testTable <- read.table("./Dataset/test/X_test.txt")
    testLabels <- read.table("./Dataset/test/y_test.txt")
    testSubject <- read.table("./Dataset/test/subject_test.txt")
    testVariables <- read.table("./Dataset/features.txt")
    
    ## Tidy up train data
    colnames(trainLabels) <- c("label")
    colnames(trainSubject) <- c("subject")
    for(i in 1:6) {trainLabels[trainLabels$label == i, "desc"] <- activityLabels[i, 2]}
    trainTable <- cbind(trainTable, trainLabels$desc)
    trainTable <- cbind(trainTable, trainSubject$subject)
    trainVariables[, 2] <- as.character(trainVariables[, 2])
    columnNames <- c(trainVariables[, 2], c("activity", "subject"))
    colnames(trainTable) <- columnNames
    

    ## Tidy up test data
    colnames(testLabels) <- c("label")
    colnames(testSubject) <- c("subject")
    for(i in 1:6) {testLabels[testLabels$label == i, "desc"] <- activityLabels[i, 2]}
    testTable <- cbind(testTable, testLabels$desc)
    testTable <- cbind(testTable, testSubject$subject)
    testVariables[, 2] <- as.character(testVariables[, 2])
    columnNames <- c(testVariables[, 2], c("activity", "subject"))
    colnames(testTable) <- columnNames

    # Merge train and test data
    trainTable$sample <- c("train")
    testTable$sample <- c("test")
    fullData <- rbind(trainTable, testTable)
    
    #Extract only columns that represent mean and standard deviation measurement
    MeanStdData <- fullData[, grepl("mean", names(fullData), ignore.case = TRUE) | grepl("std", names(fullData), ignore.case = TRUE) 
        | names(fullData) == "activity" | names(fullData) == "subject" | names(fullData) == "sample"]
    
    # Create second tidy data  with average of each variable by subject, activity and sample
    SubjectActivitySummary <- ddply(MeanStdData, .(subject, activity), function(df) colMeans(df[,1:86]))
    
    # Save data as txt files
    write.table(MeanStdData, "firstDataSet.txt", sep = "\t")
    write.table(SubjectActivitySummary, "secondDataSet.txt", sep = "\t")
}