## Getting and Cleaning Data Course Project:
## Prepares a tidy data that can be used for later analysis.

# Downloads and extracts data source if required.
fetchData <- function(src, dst) {
    if (!file.exists(dst)) {
        target <- "data.zip"
        message(sprintf("Downloading data from '%s'", src))
        download.file(src, target, method = "curl", quiet = TRUE)
        message(sprintf("Extracting to '%s' directory", dst))
        unzip(target)
    }
}

# Returns headers list.
loadFeatures <- function() {
    read.table("UCI HAR Dataset/features.txt",
               header = FALSE,
               colClasses = "character")
}
buildHeaders <- function() {
    features <- loadFeatures()
    list(features$V2,
         c("Activity"),
         c("Subject"),
         features$V2,
         c("Activity"),
         c("Subject"))
}

# Loads a file and renames its columns.
load <- function(file, headers) {
    message(sprintf("Loading '%s'", file))
    table <- read.table(file, header = FALSE)
    colnames(table) <- headers
    table
}
loadAll <- function(files, headers.list) {
    mapply(load, files, headers.list)
}

# Replaces activity codes with corresponding labels.
factorActivities <- function(df) {
    activities <- read.table("UCI HAR Dataset/activity_labels.txt",
                             header = FALSE,
                             colClasses = "character")
    factor(df$Activity,
           levels = activities$V1,
           labels = activities$V2)
} 

# Downloads file if required.
src <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data.path <- "UCI HAR Dataset"
fetchData(src, data.path)

# Loads training and test data.
all.files <- c("UCI HAR Dataset/train/X_train.txt",
               "UCI HAR Dataset/train/y_train.txt",
               "UCI HAR Dataset/train/subject_train.txt",
               "UCI HAR Dataset/test/X_test.txt",
               "UCI HAR Dataset/test/y_test.txt",
               "UCI HAR Dataset/test/subject_test.txt")
all.headers <- buildHeaders()
loaded.files <- loadAll(all.files, all.headers)
message("All files loaded")

# Extracts data frames from loaded files.
x.training <- data.frame(loaded.files[1])
y.training <- data.frame(loaded.files[2])
s.training <- data.frame(loaded.files[3])
x.test <- data.frame(loaded.files[4])
y.test <- data.frame(loaded.files[5])
s.test <- data.frame(loaded.files[6])

# Factors activities.
y.training <- data.frame(factorActivities(y.training))
y.test <- data.frame(factorActivities(y.test))

# Resets colnames after previous operations.
features <- loadFeatures()
colnames(x.training) <- features$V2
colnames(x.test) <- features$V2
colnames(y.training) <- c("Activity")
colnames(y.test) <- c("Activity")

# Merges training and test data.
all.training <- cbind(cbind(x.training, y.training), s.training)
all.test <- cbind(cbind(x.test, y.test), s.test)
all.data <- rbind(all.training, all.test)

# Selects activity, subject, mean() and std() columns and produces tidy output.
columns <- names(all.data)
mean.columns <- sapply(columns, grepl, pattern = "mean()", fixed = TRUE)
std.columns <- sapply(columns, grepl, pattern = "std()", fixed = TRUE)
mean.columns["Subject"] <- TRUE
mean.columns["Activity"] <- TRUE

library(data.table)
dt <- data.table(all.data[,(mean.columns | std.columns)])
tidy <- dt[, lapply(.SD, mean), by = "Activity,Subject"]
message("Writing output file")
write.table(tidy, file="tidy-data.csv", sep = ",", row.names = FALSE)
message("Done")
