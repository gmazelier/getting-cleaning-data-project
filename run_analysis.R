## Getting and Cleaning Data Course Project:
## Prepares a tidy data that can be used for later analysis.

# Downloads and extracts data source if required.
fetchData <- function(src, dst) {
    if (!file.exists(dst)) {
        target <- "data.zip"
        message("Downloading %s...", src)
        download.file(src, target, method = "curl")
        message("Extracting to %s", dst)
        unzip(target)
    }
}

# Returns headers list.
buildHeaders <- function() {
    features <- read.table("UCI HAR Dataset/features.txt",
                           header = FALSE,
                           colClasses = "character")
    list(features$V2,
         c("Activity"),
         c("Subject"),
         features$V2,
         c("Activity"),
         c("Subject"))
}

# Loads a file and renames its columns.
load <- function(file, headers) {
    message(sprintf("Loading %s...", file))
    table <- read.table(file, header = FALSE)
    colnames(table) <- headers
    table
}
loadAll <- function(files, headers.list) {
    mapply(load, files, headers.list)
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
