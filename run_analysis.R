#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#You should create one R script called run_analysis.R that does the following.

#read datas
names_activity <- read.table("activity_labels.txt")
names_features <- read.table("features.txt")

X_text <- read.table("X_test.txt")
Y_text <- read.table("y_test.txt")
subject_text <- read.table("subject_test.txt")
#names(Y_text) <- "actividad"
#names(subject_text) <- "subject" 

X_train <- read.table("X_train.txt")
Y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
#names(Y_train) <- "actividad"
#names(subject_train) <- "subject" 

Data_text <- cbind(X_text, Y_text, subject_text)
Data_train <- cbind(X_train, Y_train, subject_train)

#Merges the training and the test sets to create one data set.
Data_ambos <- rbind(Data_text, Data_train)
names(Data_ambos) <- as.character(names_features$V2)
names(Data_ambos)[c(562, 563)] <- c("actividad", "subject")

index <- which(grepl("mean\\(\\)|std\\(\\)", names(Data_ambos)) == TRUE)
Data_ambos <- Data_ambos[, c(index, 562, 563)]

Data_ambos$actividad <- factor(Data_ambos$actividad, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

install.packages("reshape2")
library("reshape2")

melted <- melt(Data_ambos, id=c("subject","actividad"))
tidy <- dcast(melted, subject+actividad ~ variable, mean)

write.table(tidy, file = "data.txt", row.name=FALSE)
