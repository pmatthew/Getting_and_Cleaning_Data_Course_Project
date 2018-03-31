library(readr)
library(plyr)

# Read data in
#   - readr.read_table is to be used for faster reading

subject_train <- read.table("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/train/subject_train.txt", fileEncoding = "us-ascii", header = FALSE)
y_train <- read.table("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/train/y_train.txt", fileEncoding = "us-ascii", header = FALSE, col.names = "id")
X_train <- as.data.frame(read_table("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/train/X_train.txt", progress = interactive(), col_names = F))

subject_test <- read.csv("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/test/subject_test.txt", fileEncoding = "us-ascii", header = FALSE)
y_test <- read.csv("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/test/y_test.txt", fileEncoding = "us-ascii", header = FALSE, col.names = "id")
X_test <- as.data.frame(read_table("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/test/X_test.txt", progress = interactive(), col_names = F))

features <- read.csv("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/features.txt",sep = " ", fileEncoding = "us-ascii", header = FALSE, col.names = c("id", "feature"))
act <- read.csv("./Getting_and_Cleaning_Data_Course_Project/UCI HAR Dataset/activity_labels.txt",sep = " ", fileEncoding = "us-ascii", header = FALSE, col.names = c("id", "activity"))

# extract the indexes of those columns, which name contains either "mean()" or "std()"; parenthesis needs to be escaped with //
c <- as.vector(rbind(grep("std\\(\\)", features[,2]), grep("mean\\(\\)", features[,2])))

# name the columns by features
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]

# "join" the activity id with the activity description; use plyr join to keep the original row order
y_train <- join(x = y_train, y = act)
y_test <- join(x = y_test, y = act)

# merge the 3 data set columns, get only the description of the activity and the mean and std measures from the X_train
train_b <- cbind(subject_train, y_train[,2], X_train[,c])
test_b <- cbind(subject_test, y_test[,2], X_test[,c])

# to be able to match by names
names(test_b) <- names(train_b)

# match the two data sets
binded <- rbind(train_b, test_b)

# name the frist two columns as well
colnames(binded)[1] <- "SubjectId"
colnames(binded)[2] <- "ActivityDesc"

# Clean up column names. Delete parenthesis, dash; 
names(binded) <- gsub("[\\(\\)-]","",names(binded))
names(binded) <- gsub("^f","frequency",names(binded))
names(binded) <- gsub("^t","time",names(binded))
names(binded) <- gsub("mean","Mean",names(binded))
names(binded) <- gsub("std","StandardDeviation",names(binded))

# aggregate
agr <- aggregate(binded[,3:68], by = list(subject_id=binded$SubjectId, activity_name=binded$ActivityDesc), mean)

# save aggregate to file
write.table(agr, "tidy_average.txt", row.names = F, quote = F)



