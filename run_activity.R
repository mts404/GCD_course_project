## GCD course project code
## This R file has a hard dependency on data from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## (in this case downloaded April 20, 2015) 
## NOTE: This file must be unzipped in the working directory.  
##
## This R code will read in data from the .txt files, and test & train directories. 
## The directories contain movement data from user tests with mobile phones. 
## Data will be bound to the corresponding subject (user) number, and the corresponding
## activity type. This data will also be subset to only contain the columns showing means
## and standard deviations. Then the data will be condensed to take the mean of these
## means and standard deviations, for each subject (user) for each activity.
##
## The final result is then written to a local txt file: SamsungDataAverages.txt 

## Clear local variables
rm(list = ls())

## Insure plyr package is in library
library(plyr)

## Read in the values from the ./ directory
##
features <- read.table("features.txt")
features <- as.character(features[,2])   ## Convert from a factor to character
act_labels <- read.table("activity_labels.txt")

## Go through both test and train directories to process 3 files in each
##
for(i in c("test", "train")) {
      
      ## Create file-path and names to use for files with text and trial
      x_filename <- paste0(i, "/x_", i, ".txt")
      y_filename <- paste0(i, "/y_", i, ".txt") 
      s_filename <- paste0(i, "/subject_", i, ".txt") 
      
      ## Create 3 data.frames from files in test and train sub-directories, 
      ## with related column names
      xframe <- read.table(x_filename, col.names = features)
      yframe <- read.table(y_filename, col.names = "Activity")
      sframe <- read.table(s_filename, col.names = "SubjectID")
      
      ## Subset xframe by grepping for only column names containing .mean. or .std.
      xsub <- xframe[,grep("\\.mean\\.|\\.std\\.", colnames(xframe))]
      
      ## Create initial output by column-binding subject, activity, and x-subset
      ## into output_test and output_train
      assign(paste0("output_", i), cbind(sframe, yframe, xsub))
}

## Connect the 2 output data frames created above: output_test and output_train
##
dataCombined <- rbind(output_test, output_train)

## Calculate the mean of each variable, for each Subject & Activity pair
##
dataMeans <- ddply(dataCombined, .(SubjectID, Activity), colMeans)

## Replace Activity column numeric values with Activity Labels
##
dataMeans[,2] <- act_labels[dataMeans[,2],2]

## Create more descriptive variable (column) names
##
columnnames <- names(dataMeans)
columnnames <- gsub("\\.\\.", "", columnnames)
columnnames <- gsub("BodyBody", "Body", columnnames)
columnnames <- gsub("^t", "time", columnnames)
columnnames <- gsub("^f", "frequency", columnnames)
names(dataMeans) <- columnnames

## Write the final (wide) tidy data set to a file
##
write.table(dataMeans, file = "SamsungDataAverages.txt", row.names = FALSE)
