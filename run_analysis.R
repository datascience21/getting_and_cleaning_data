

library(reshape2)
library(plyr)

# Reading activity lables and assigning column columnames to the 
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)
names(activitylabels) <-c("Activity_No","Activity_Desc")
# Reading features.txt and extracint variable names and column indices for mean and std columns
features <- read.table("UCI HAR Dataset/features.txt",header = FALSE)
variablenames <- as.vector(features[,2])
mean_std_index <- grep("(mean|std)\\(\\)",variablenames)
# Test dataset
    # Reading subject information
    testsubjectdata <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE)
    colnames(testsubjectdata) <- "Subject_Number"
    # Reading test labels and merging it with activity names
    testlabels <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE)
    names(testlabels) <-c("Activity_No")
    testlabels<- merge(testlabels,activitylabels,by="Activity_No",sort = F)
    # Reading test data from UCI HAR dataset "test" folder and descriptive variable names
    testdata <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE)    
    colnames(testdata) <-variablenames
    #Extracting mean and std columns from testdata
    testdata_mean_std <- testdata[,mean_std_index]
    #Binding subject data and testlabels activity description data to testdata
    testdata_mean_std<-cbind(testsubjectdata,testlabels,testdata_mean_std)
    
# Train dataset    
    # Reading subject information
    trainsubjectdata <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE)
    colnames(trainsubjectdata) <- "Subject_Number"
    # Reading train labels and merging it with activity names
    trainlabels <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE)
    names(trainlabels) <-c("Activity_No")
    trainlabels<- merge(trainlabels,activitylabels,by="Activity_No",sort = F)
    # Reading train data from UCI HAR dataset "train" folder and descriptive variable names
    traindata <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE)    
    colnames(traindata) <-variablenames
    #Extracting mean and std columns from testdata
    traindata_mean_std <- traindata[,mean_std_index]
    #Binding subject data and testlabels activity description data to testdata
    traindata_mean_std<-cbind(trainsubjectdata,trainlabels,traindata_mean_std)
    
# combining test and train data
    combineddata <- rbind(testdata_mean_std,traindata_mean_std)
    combineddata <-combineddata[,-2]
# Reshaping combined data to tidy data    
    tidydata <- melt(combineddata, id=c("Subject_Number","Activity_Desc"),measures.vars=combineddata[1:66])
# Generating tidydataset2 and writing it to a file
    tidydataset2 <- ddply(tidydata,.(Subject_Number,Activity_Desc,variable),summarize,Result = mean(value))
    write.table(tidydataset2,file="tidydataset2.txt",row.names=FALSE)
    