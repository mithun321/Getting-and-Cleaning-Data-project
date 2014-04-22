Getting-and-Cleaning-Data course project Readme
===============================================

All the necessary files required for this project is uploaded in this repository. Main script written is run_analysis.R. It assumes that the same folder contains the files activity_labels.txt and features.txt. Besides, the train and test data should be in sub-folders in the same directory named as train and test respectively. train folder should contain files subject_train.txt, X_train.txt and y_train.txt. test folder should contain subject_test.txt, X_test.txt and y_test.txt. Once we run the R script, 3 txt files will be produced as output. These 3 files are uploaded in the answer to the first question in Coursera peer assignments webpage. Descriptions are given below:

* tidydata.txt: Tidy data set with required specification



* group_average: Tidy data set with the average of each variable for each activity and each subject


* combined.txt: Although it is not required, but the combined data with train and test data is uploaded below (it is the data just after 1st step mentioned in the question, final tidy data named as tidydata is uploaded above)


For checking the data clearly, I suggest to rename the files with .csv as extension (instead of .txt) and then open in any application that can open spreadsheet. As the Coursera platform does not allow us to upload csv files, txt files are uploaded. csv files are also uploaded in this repository.

Steps followed in the R script
------------------------------
R script is commented to describe which part is doing what. 

* Firstly the X sets are extracted from test and train data set. 

* Then y sets and next subject sets are extracted. The extracted sets are also combined into single R matrix object.

* Matrices are converted into data.frame. Column names are also extracted from feature.txt file and inserted into data.frame object.

* Descriptive activity names for y are inserted

* Then only the measurements on the mean and standard deviation are extracted

* Data is prepared and written for first output (tidydata.txt)

* Second data set  with the average of each variable for each activity and each subject is produced (group_average.txt)

* combined.txt is produced as described above


