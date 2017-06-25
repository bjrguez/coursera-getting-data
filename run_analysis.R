#read datas
names_activity <- read.table("activity_labels.txt")
names_features <- read.table("features.txt")

X_text <- read.table("X_test.txt")
Y_text <- read.table("y_test.txt")
subject_text <- read.table("subject_test.txt")

X_train <- read.table("X_train.txt")
Y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

#Merges the training and the test sets to create one data set.
X_ambos <- rbind(X_text, X_train)
Y_ambos <- rbind(Y_text, Y_train)
subject_ambos <- rbind(subject_text, subject_train)

#Appropriately labels the data set with descriptive variable names.
names(X_ambos) <- as.character(names_features$V2)

#Uses descriptive activity names to name the activities in the data set
Y_ambos$V1[which(Y_ambos$V1 == "1")] <- as.character(names_activity$V2[1])
Y_ambos$V1[which(Y_ambos$V1 == "2")] <- as.character(names_activity$V2[2])
Y_ambos$V1[which(Y_ambos$V1 == "3")] <- as.character(names_activity$V2[3])
Y_ambos$V1[which(Y_ambos$V1 == "4")] <- as.character(names_activity$V2[4])
Y_ambos$V1[which(Y_ambos$V1 == "5")] <- as.character(names_activity$V2[5])
Y_ambos$V1[which(Y_ambos$V1 == "6")] <- as.character(names_activity$V2[6])

#Extracts only the measurements on the mean and standard deviation for each measurement.
index <- which(grepl("mean\\(\\)|std\\(\\)", names(X_ambos)) == TRUE)
X_ambos_ms <- X_ambos[, index]

#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
index <- which(grepl("mean\\(\\)", names(X_ambos_ms)) == TRUE)
X_ambos_m <- X_ambos_ms[, index]

X_complete <- cbind(X_ambos_m, Y_ambos)

write.table(X_complete, file = "data.txt", row.name=FALSE)
