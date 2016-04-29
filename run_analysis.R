if(!file.exists("UCI HAR Dataset")){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="getdata-projectfiles-UCI HAR Dataset.zip")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}
testsetx<-read.table("UCI HAR dataset/test/x_test.txt")
trainsetx<-read.table("UCI HAR dataset/train/x_train.txt")
testsety<-read.table("UCI HAR dataset/test/y_test.txt")
trainsety<-read.table("UCI HAR dataset/train/y_train.txt")
subjecttest<-read.table("UCI HAR dataset/test/subject_test.txt")
subjecttrain<-read.table("UCI HAR dataset/train/subject_train.txt")
activity_labels<-read.table("UCI HAR dataset/activity_labels.txt")
features<-read.table("UCI HAR dataset/features.txt")
mergedsetx<-rbind(testsetx,trainsetx)
names(mergedsetx)<-features[,2]
grepset<-grep(".[Mm]ean.|.std.",names(mergedsetx))
mergedsetx<-mergedsetx[,grepset]
mergedsety<-rbind(testsety,trainsety)
mergedlabels<-merge(mergedsety,activity_labels,sort=F)
names(mergedlabels)<-c("labels","activities")
mergedsubject<-rbind(subjecttest,subjecttrain)
names(mergedsubject)<-"subject"
completeset<-cbind(mergedsubject,mergedsetx,mergedlabels)
newdataset<-aggregate(completeset[,c(-1,-88,-89)],by=list(subject=completeset$subject,labels=completeset$labels),FUN=mean)
newdataset<-newdataset[order(newdataset$subject),]
write.table(newdataset,"tidy_dataset.txt",row.names=FALSE)