# bellatrix-lestrange

- ***Day 1***

###MySQL
- we solve the My SQL tasks
- pass two taks to solve it later

###Python

- ***Step 0***
- we read the file into Python
- Create the column names because the csv has no headers

***Step 1***
- Explore the data (with Python,Tableau,Excel)
- Missing Values: We drop the Missing values : only 24 values yes and no are the same missbalanced in comparison to the whole dataset
- There are no duplicates in the Dataset
- unwanted columns Q1_Balance to Q4_Balance and customer_number
- target variable: offered accepted
- Maybe later: create groups
- datatypes are correct

***Step3***
***EDA***

![bild_1](bild_1.jpg)
y-Variable(yes, No)
- one hint: Drop the outliers for NO can redurce the dataset. The dataset für ysy gets notr bigger but the relationship between no and yes gets better. It is a step to imporve the dataset befor starts the model.
- we create 3 different dataset for handling with the outliers and we how our model will works (because we have different housholdsize and differentz income level that influence of course the dataset

![bild_2](bild_2.jpg)
- we will check if the houeholdsize 8 and 9 (only 1 row) stays in the dataset. Because if we normalize/encode the features, the influence of the bothe rows withe the householdsize 8 and 9 have a big influence of the new interval.