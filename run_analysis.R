#run_analysis.R
# You should create one R script called run_analysis.R that does the following.
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement.
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names.
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd('./r') 
# URL with source files
lurl<-'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
 
# create download directory and set it
.exdir = 'extraction'
.maindir=getwd()
if (!file.exists(.exdir))  {  dir.create(file.path(.maindir, .exdir)) } 

.filedest = file.path(.exdir, 'data.zip')
# downloads file
download.file(lurl,.filedest )
 
# Unzips file
unzip(.filedest,exdir=.exdir)

# Reads files
setwd('./extraction/UCI HAR Dataset')
subject_train<-read.table('./train/subject_train.txt') 
y_train<-read.table('./train/y_train.txt') 
x_train<-read.table('./train/x_train.txt') 

subject_test<-read.table('./test/subject_test.txt') 
y_test<-read.table('./test/y_test.txt') 
x_test<-read.table('./test/x_test.txt') 

features<-read.table('features.txt')
activity<-read.table('Activity_labels.txt')

# Sets column names for subjects table
colnames(subject_train)='subject'
colnames(subject_test)='subject'
subject_train$sample='Train'
subject_test$sample='Test'

# Sets column names for Measures
n<-nrow(features)
feat2 <- gsub("tB", "Time_B", features[1:n,2])
feat2 <- gsub("fB", "Frequency_B", feat2[1:n])
feat2 <- gsub("tG", "Time_G", feat2[1:n])
feat2 <- gsub("fG", "Frequency_G", feat2[1:n])
colnames(x_train)=feat2
colnames(x_test)=feat2

# Sets column names for Activities
y_train2<-merge(y_train,activity)
y_test2<-merge(y_test,activity)
colnames(y_train2)<-c("Activity_id","Activity_desc")
colnames(y_test2)<-c("Activity_id","Activity_desc")

# 1. Merges the training and testsets to create one data set 
dt1<-data.frame(subject_train,y_train2,x_train)
dt2<-data.frame(subject_test,y_test2,x_test)
# Merges test and train dataframes
dt<-rbind(dt1,dt2)
print (dt)

#2. Extracts only the measurements on the mean and std for ea measure
ndx1 = grep('mean', names(dt) , perl=T)
ndx2 = grep('std()',names(dt),perl=T)
# Subsets dataframe for those columns that have std or mean,keeps Subject and Activity name
dt3<-cbind(dt[,1:4],dt[,ndx1],dt[,ndx2])
dt3 

#3. Uses descriptiveactivity names to name the activities on the data set
str(dt)

#4 Appropiately labels the data set with descriptive variable names
str(dt)
write.csv(dt,file="HAR.csv")


#5. From the data set in step 4 creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject
dt4<-cbind(dt$Activity_desc,dt$subject,dt[,ndx1])
colnames(dt4)[1]<-'Activity_desc'
colnames(dt4)[2]<-'subject'
dt5<-tapply(dt4,subject, FUN=mean)
