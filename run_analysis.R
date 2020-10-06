if(!file.exists("./data")){
  dir.create("./data")
}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "./data/dataset.zip",method = "curl")
unzip(zipfile = "./data/dataset.zip",exdir="./data" )

#getting the list of the unzipped file
p<-file.path("./data","UCI HAR Dataset")
files<-list.files(p,recursive = TRUE)

#reading data from the files into variables
activitytest<-read.table(file.path(p,"test","y_test.txt"),header = FALSE)
activitytrain<-read.table(file.path(p,"train","y_train.txt"),header = FALSE)
subjecttest<-read.table(file.path(p,"test","subject_test.txt"),header = FALSE)
subjecttrain<-read.table(file.path(p,"train","subject_train.txt"),header = FALSE)
featuretest<-read.table(file.path(p,"test","X_test.txt"),header = FALSE)
featuretrain<-read.table(file.path(p,"train","X_train.txt"),header = FALSE)

#1.Merging training and test sets as one data set
subject<-rbind(subjecttrain,subjecttest)
activity<-rbind(activitytrain,activitytest)
feature<-rbind(featuretrain,featuretest)

#assigning names to variables
names(subject)<-c("subject")
names(activity)<-c("activity")
featurenames<-read.table(file.path(p,"features.txt"),header = FALSE)
names(feature)<-featurenames$V2
dataComplete<-cbind(subject,activity)
Data<-cbind(feature,dataComplete)

#only measurements on mean and standard deviation
subfeaturenames<-featurenames$V2[grep("mean\\(\\)|std\\(\\)",featurenames$V2)]
selectednames<-c(as.character(subfeaturenames),"subject","activity")
Data<-subset(Data,select=selectednames)

# Naming the activities in data set using descriptive activity names 
activitylables<-read.table(file.path(p,"activity_labels.txt"),header = FALSE)
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#Creating the tidy data set and output
library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

#producing code book
library(knitr)
knit2html("codebook.Rmd")
