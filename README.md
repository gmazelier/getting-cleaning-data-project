Getting and Cleaning Data Project
=================================

This repository contains one R script `run_analysis.R` that downloads the
required Samsung data if needed and then produces the expected tidy data set,
save as `tidy_data.csv`. This script does not expect any parameter to be run.

The downloaded data is saved in the current directory as `data.csv` and unzipped
in a `UCI HAR Dataset` sub-directory. The original data is taken from [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

See the [`CODEBOOK.md`](CODEBOOK.md) file for more information.
