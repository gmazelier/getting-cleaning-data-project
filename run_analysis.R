## Getting and Cleaning Data Course Project:
## Prepares a tidy data that can be used for later analysis.

# Downloads and extracts data source if required.
fetchData <- function(src, dst) {
    if (!file.exists(dst)) {
        target <- "data.zip"
        download.file(src, target, method = "curl")
        unzip(target)
    }
}

# Main script
src <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data.path <- "UCI HAR Dataset"

fetchData(src, data.path)
