# This R script creates a tidy dataset from "Human Activity Recognision using Smartphones Dataset"

# Load feature descriptions and select only mean and standard deviation descriptions
library(dplyr)

features <- read.table("features.txt")
features <- features[grep("mean\\(\\)|std\\(\\)", ft$V2),  ]
features$td <- tolower(gsub((gsub(x=features$V2, pattern = "-|\\(\\)\\-", replacement = "\\.")), pattern="\\(\\)", replacement = ""))


#Load activity lables

activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity")

# function to load dataset, select appropriate fatures, 
# assign descriptive names and assign descriptive activity

process_dataset <- function(xname, yname, subjname) {
  #load main data
  x_data <- read.table(xname) 
  # select columns that we need
  x_data <- x_data[, features$V1]
  #assign descriptive names
  colnames(x_data) <- features$td

  #load activities
  
  y_data <- read.table(yname)
  
  
  
  colnames(y_data) <- c("activity_id")
  #assign rownum id
  y_data$id <- 1:nrow(y_data)
  
  #merge with activity name and order by id
  
  y_data <- merge(y_data, activity_labels, by = "activity_id")
  
  y_data <- y_data[order(y_data$id),]
  
  # combine x and y datasets
  
  x_data <- cbind(y_data$activity, x_data)
  names(x_data)[1] <- "activity" 

  #load subject data
  
  s_data <- read.table(subjname)
  x_data <- cbind(s_data, x_data)
  names(x_data)[1] <- "subject"
  x_data
}

#load and process test data

test_data <- process_dataset("test/X_test.txt", "test/Y_test.txt", "test/subject_test.txt")

#load and process train data
train_data <- process_dataset("train/X_train.txt","train/Y_train.txt", "train/subject_train.txt")

#combine test and train data
final_dataset <- rbind(test_data, train_data)

#save data to file
write.csv(x = final_dataset, file = "tidy_data.csv", row.names = FALSE)

summary_data <- final_dataset %>% group_by(subject, activity) %>% dplyr::summarise_all(funs(mean))

#save summary data

write.csv(summary_data, file = "summary.csv", row.names = F)
