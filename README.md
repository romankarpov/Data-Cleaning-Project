# Data analysis description

1.Script assumes that working directory is set to the directory with the data 
1.Features were loaded and filtered to include only features with "mean()" and "std()" substrings using grep function
2. Activity file was loaded to use a mapping for activity names
3. Function "process_dataset" with parameters for "X" file, "Y" file and subject file processes a dataset (either test or train) to generate tidy subset of data
3. Function loads the "x" data file, selects columns identified in step 1
4. Function loads the "y" data file, and merges it with activity labels, while preserving the row order
5. Funtion loads the "subject" data file
6. Function combines all 3 files with cbind
7. Function returns the tidy subset
8. Script executes function for training and test data sets
9. Script writes tidy dataset into CSV file
10. Script summarized the dataset with summarize_all function from dplyr
11. Script writes summirezed data into CSV file
