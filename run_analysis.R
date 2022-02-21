library(dplyr)
#Dodnload the zip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "A:/Downloads/Quiz.zip")

#setting the root, location of the files
base_dir<-"A:/Downloads/UCI HAR Dataset/"
#Extracting features and activities files
activity_labels_doc<-read.table(paste(base_dir, "activity_labels.txt",sep = ""), header = FALSE, sep = "", dec = ".")
activity_labels<-activity_labels_doc[,2]
features_doc<-read.table(paste(base_dir, "features.txt",sep = ""), header = FALSE, sep = "", dec = ".")
features<-features_doc[,2]
#Filtering features, to subset only the ones with mean and standard deviation
mean_and_std_index<-grepl("mean|std",features)

#Getting th test data, values, activity ID and subject ID
x_test<-read.table(paste(base_dir, "test/x_test.txt",sep = ""), header = FALSE, sep = "", dec = ".")
y_test<-read.table(paste(base_dir, "test/y_test.txt",sep = ""), header = FALSE, sep = "", dec = ".")
subjects_test<-read.table(paste(base_dir, "test/subject_test.txt",sep = ""), header = FALSE, sep = "", dec = ".")

#Features as column names will make easier to identify the name of the value meassured
colnames(x_test)<-features
colnames(subjects_test)<-"subject_ID"

#Applying the subset of the features filtered, adding a column to recognize the activity name and binding it into a complete Test data set
x_test_means_and_std<-x_test[,mean_and_std_index]
y_test_with_names<-mutate(y_test,activity=activity_labels[y_test$V1])
colnames(y_test)[1]<-"activity_id"
test_data<-cbind(y_test_with_names,subjects_test,x_test_means_and_std)
test_data<-mutate(test_data,modeling_usage="test", .after=subject_ID)

#Repeated same process was used for Test Data but now with Train Data set
x_train<-read.table(paste(base_dir, "train/x_train.txt",sep = ""), header = FALSE, sep = "", dec = ".")
y_train<-read.table(paste(base_dir, "train/y_train.txt",sep = ""), header = FALSE, sep = "", dec = ".")
subjects_train<-read.table(paste(base_dir, "train/subject_train.txt",sep = ""), header = FALSE, sep = "", dec = ".")

colnames(x_train)<-features
colnames(subjects_train)<-"subject_ID"

x_train_means_and_std<-x_train[,mean_and_std_index]
y_train_with_names<-mutate(y_train,activity=activity_labels[y_train$V1])
colnames(y_train)[1]<-"activity_id"
train_data<-cbind(y_train_with_names,subjects_train,x_train_means_and_std)
train_data<-mutate(train_data,modeling_usage="train", .after=subject_ID)

#Combining the training and testing data
model_means_and_std<-rbind(train_data,test_data)
colnames(model_means_and_std)[1]<-"activity_ID"
model_means_and_std<-tbl_df(model_means_and_std)

#Grouping data set by subject ID and activity
grouped_subject_activity<-group_by(model_means_and_std,subject_ID, activity)

#creating a new data set with the means after the data was grouped
means_by_subject_and_activity<-summarise_all(grouped_subject_activity,mean)
means_by_subject_and_activity<-arrange(means_by_subject_and_activity,subject_ID,activity_ID)

