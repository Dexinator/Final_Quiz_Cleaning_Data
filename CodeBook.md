---
title: "Cleaning Data Final Quiz"
author: "JPBD"
date: "2/21/2022"
output: html_document
---


## Variables
means_by_subject_and_activity:Final and resulted data set
features: Name of the 561 measures
activity_labels: Name of the six activities.
model_means_and_std :combined data of test and training
grouped_subject_activity: last variable grouped by subjects and activities
grouped_subject_and_activity: combined data of 
All our project is divided by test train data set, each of the following variables is really a pair of them corresponding to 1 of each category
For x and y:
means_and_std: Extracted data that are only means or standard deviations
with_names: activities with their respective names
data:Datasets with the required filtered values and activity names

## Process
The steps followed were the next:
1. Download Files
2. Extract and prepare the common files of training and testing data, such as matching activity names with the activity labels. Filtered only the measures of mean and standard deviations
3. Train and test data were treated with the same process, Y data was used as column names, Data was filtered with the required features and subjects were added.
4. Both, train and test data is combined
5. Data was grouped by subject ID and activity



