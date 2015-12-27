
run_Analysis.R script merges the test and training data into and performs the following 5 tasks
as per the project requirements
    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 Here are the steps 
 Assumption: All the required files within the folder "UCI HAR Dataset" should be present in the working directory
 
1.Reads the activity_labels.txt file into a dataframe and assigns column names to it
2.Reads the features.txt file and extracts the mean and std variable names.Column indices arte stored in mean_std_index
3.Test data set	
	3.1 Reads the subject_test.txt file and assigns column names to it
	3.2 Reads the test labels from y_test.txt file and combines it with the activity names data read in step 1
	3.3	Reads test data into a datafrace from X_test.txt file and assigns column names 
	3.4 Extracts the mean and std columns from the data read in step 3.3 
	3.5 Combines the test data (from step 3.4) with subject and labels data
4.Train data set	
	3.1 Reads the subject_train.txt file and assigns column names to it
	3.2 Reads the train labels from y_train.txt file and combines it with the activity names data read in step 1
	3.3	Reads train data into a datafrace from X_train.txt file and assigns column names 
	3.4 Extracts the mean and std columns from the data read in step 3.3 
	3.5 Combines the test data (from step 3.4) with subject and labels data
5. Combines test and train data into a dataframe and eliminates Activity no column
6. Creates a tidydata set by melting the data from Step 5 which creates a new column "variable" with all the variables
7. Creates a tidydata set 2 by summarizing the results by Subject Number, Activity Description and variable	