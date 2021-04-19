#Task 1:Create a database called credit_card_classification
CREATE DATABASE credit_card_classification; 

#Task 2: Create a table credit_card_data with the same columns as given in the csv file. Please make sure you use the correct data types for each of the columns.
# We crate the columsn with the menu of MySQL. The Code is the alternative way:
CREATE TABLE credit_card_data (
  `Customer_Number` INT NULL,
  `Offer_Accepted` VARCHAR(45) NULL,
  `Reward` VARCHAR(45) NULL,
  `Mailer_Type` VARCHAR(45) NULL,
  `Income_Level` VARCHAR(45) NULL,
  `Bank_Accounts_Open` INT NULL,
  `Overdraft_Protection` VARCHAR(45) NULL,
  `Credit_Rating` VARCHAR(45) NULL,
  `Credit_Cards_Held` INT NULL,
  `Homes_Owned` INT NULL,
  `Household Size` INT NULL,
  `Own_Your_Home` VARCHAR(45) NULL,
  `Average_Balance` DECIMAL(9,2) NULL,
  `Q1_Balance` INT NULL,
  `Q2_Balance` INT NULL,
  `Q3_Balance` INT NULL,
  `Q4_Balance` INT NULL);

use credit_card_classification;

#Task 3: Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. 
#To not modify the original data, if you want you can create a copy of the csv file as well. 
# Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:
# The code does not work, because secure-file_pric (error 1290)
# That is the reason why we used menü point -> Table Data Import Wizard.
LOAD DATA
INFILE 'C:/Users/AnjaF/Desktop/creditcardmarketing.csv'
INTO TABLE credit_card_data;

#Task 4: Select all the data from table credit_card_data to check if the data was imported correctly.
select * from credit_card_data;

#Task 5 Use the alter table command to drop the column q4_balance from the database, as we would not use it in the analysis with SQL. 
ALTER TABLE credit_card_data
Drop Q4_Balance;

#Select all the data from the table to verify if the command worked. Limit your returned results to 10.
select * from credit_card_data
Limit 10;

#Task 6 Use sql query to find how many rows of data you have.
Select Count(*) from credit_card_data;

#Task 7: Now we will try to find the unique values in some of the categorical columns:
# What are the unique values in the column Offer_accepted?
Select Distinct Offer_Accepted from credit_card_data;

# What are the unique values in the column Reward?
Select Distinct Reward from credit_card_data;

#What are the unique values in the column mailer_type?
Select Distinct Mailer_Type from credit_card_data;

#What are the unique values in the column credit_cards_held?
Select Distinct Credit_Cards_Held from credit_card_data;

#What are the unique values in the column household_size?
Select Distinct Household_Size from credit_card_data;

#Task 8: Arrange the data in a decreasing order by the average_balance of the house. Return only the customer_number of the top 10 customers with the highest average_balances in your data.
Select Customer_Number From credit_card_data
Order By Average_Balance DESC
Limit 10;

#Task 9: What is the average balance of all the customers in your data?
Select Round(AVG(Average_Balance),2) as AVG_Balanced_for_all FROM credit_card_data;

#Task 10: In this exercise we will use simple group by to check the properties of some of the categorical variables in our data. 
# Note wherever average_balance is asked, please take the average of the column average_balance: 

#What is the average balance of the customers grouped by Income Level? 
#The returned result should have only two columns, income level and Average balance of the customers. Use an alias to change the name of the second column.

Select Round(AVG(Average_Balance),2) as AVG_Balanced_for_all FROM credit_card_data
Group By Income_Level;

#What is the average balance of the customers grouped by number_of_bank_accounts_open? 
#The returned result should have only two columns, number_of_bank_accounts_open and Average balance of the customers. Use an alias to change the name of the second column.

Select Round(AVG(Average_Balance),2) as AVG_Balanced_for_all, Bank_Accounts_Open as NUmber_of_Bank_accounts FROM credit_card_data
Group By Bank_Accounts_Open;

#What is the average number of credit cards held by customers for each of the credit card ratings? 
#The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.

Select Credit_Rating, Round(AVG(Credit_Cards_Held),0) FROM credit_card_data
Group By Credit_Rating;

#Is there any correlation between the columns credit_cards_held and number_of_bank_accounts_open? 
#You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
#Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

Select Credit_Cards_Held, sum(Bank_Accounts_Open) FROM credit_card_data
Group By Credit_Cards_Held;
#Answer: From Credit_Cards_Held 1to 2: positive Correlation
#and from Credit_Cards_Held 2 to 4 a negative correlation

#Task 11: Your managers are only interested in the customers with the following properties:
#Credit rating medium or high

SELECT Customer_Number
FROM credit_card_data
WHERE Credit_Rating = "High" or  Credit_Rating = "Medium";

#Credit cards held 2 or less
SELECT Customer_Number
FROM credit_card_data
WHERE Credit_Cards_Held <= 2;

# Owns their own home
SELECT Customer_Number
FROM credit_card_data
WHERE Own_Your_Home = "Yes";

# Household size 3 or more
SELECT Customer_Number
FROM credit_card_data
WHERE Homes_Owned > 2;

# One Solution for all
Select Customer_Number From credit_card_data
WHERE Homes_Owned > 2
and
Own_Your_Home = "Yes"
and
Credit_Cards_Held <= 2
and
(Credit_Rating = "High" or  Credit_Rating = "Medium")
and Offer_Accepted ="Yes";

#Task 12 Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. 
# Write a query to show them the list of such customers. You might need to use a subquery for this problem.

SELECT Customer_Number FROM credit_card_data
WHERE Average_Balance < (SELECT AVG(Average_Balance) FROM credit_card_data);

#Task 13 Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW Customer_less_than_AVG as
SELECT Customer_Number FROM credit_card_data
WHERE Average_Balance < (SELECT AVG(Average_Balance) FROM credit_card_data);

#Task 14: What is the number of people who accepted the offer vs number of people who did not?

SELECT count(Customer_Number), Offer_Accepted FROM credit_card_data
Group By Offer_Accepted;

#Task 15: Your managers are more interested in customers with a credit rating of high or medium. 
# What is the difference in average balances of the customers with high credit card rating and low credit card rating?

Select Credit_Rating, Average_Balance,
avg(Average_Balance) over (Partition by Credit_Rating orderd) 
FROM credit_card_data;

#Task 16: In the database, which all types of communication (mailer_type) were used and with how many customers?

Select count(Customer_Number), Mailer_Type from credit_card_data
Group By Mailer_Type;

#Task 17: Provide the details of the customer that is the 11th least Q1_balance in your database.

Select *,
dense_rank() OVER (Order By Q1_Balance DESC) as "Rank" 
from credit_card_data
Where "Rank" = 11;


