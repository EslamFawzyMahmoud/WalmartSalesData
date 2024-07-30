-- Create database
CREATE DATABASE walmartSales;

--Rename Table [WalmartSalesData.csv] to [WalmartSales]
EXEC sp_rename '[WalmartSalesData.csv]' , 'WalmartSales';

--Edit The Data Type of Rating column
Alter TABLE dbo.WalmartSales ALTER COLUMN Rating DEC (10,1);

-- ADD Time of day column in the table
ALTER TABLE WalmartSales ADD Time_Of_Day VARCHAR(20);

UPDATE WalmartSales
SET Time_Of_Day = (CASE
			WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'Moring'
			WHEN Time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
			ELSE 'Evening'
		END);

-- ADD Day Name column in table
ALTER TABLE WalmartSales ADD Day_name VARCHAR(10);

UPDATE WalmartSales
SET Day_name = (DateNAME(WEEKDAY,Date));

-- ADD Day Name column in table
ALTER TABLE WalmartSales ADD Month_name VARCHAR(10);

UPDATE WalmartSales
SET Month_name = (DateNAME(month,Date));

----------------------------------Generic Question--------------------------------------
--Q1) How many unique cities does the data have?
SELECT DISTINCT City
FROM WalmartSales;

--Q2)In which city is each branch?
SELECT DISTINCT City , Branch 
FROM WalmartSales;

--------------------------------Product-----------------------------------------
--Q1)How many unique product lines does the data have?
SELECT DISTINCT Product_line
FROM WalmartSales;

--Q2)What is the most selling product line?
SELECT Product_line , SUM(Quantity) AS Quantity
FROM WalmartSales
GROUP BY Product_line
ORDER BY Quantity DESC;

--Q3)-- What is the total revenue by month?
SELECT Month_name , SUM(Total) AS Total_Revenue
FROM WalmartSales
GROUP BY Month_name
ORDER BY Total_Revenue DESC;

--Q4)What month had the largest COGS?
SELECT Month_name , SUM(cogs) AS 'largest COGS'
from WalmartSales
GROUP BY Month_name
ORDER BY [largest COGS] DESC;

--Q5) What product line had the largest revenue?
SELECT Product_line , SUM(Total) AS 'Largest Revenue'
from WalmartSales
GROUP BY Product_line
ORDER BY [Largest Revenue] DESC;

--Q6) What is the city with the largest revenue?
SELECT Branch,City , SUM(Total) AS 'Largest Revenue'
from WalmartSales
GROUP BY City ,Branch
ORDER BY [Largest Revenue] DESC;

--Q7) What product line had the largest VAT?
SELECT Product_line , SUM(Tax_5) AS 'Largest VAT'
from WalmartSales
GROUP BY Product_line
ORDER BY [Largest VAT] DESC;

--Q8) Which branch sold more products than average product sold?

SELECT Branch , SUM(Quantity) AS quantity
FROM WalmartSales
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM WalmartSales);

--Q9)What is the most common product line by gender
SELECT Gender, Product_line ,COUNT(Gender) AS Total_Gender
FROM WalmartSales
GROUP BY Gender , Product_line
ORDER BY Total_Gender DESC;

--Q10)What is the average rating of each product line
SELECT Product_line , AVG(Rating) Average_Rating
FROM WalmartSales
GROUP BY Product_line
ORDER BY Average_Rating DESC;

--------------------------------Customers ------------------------------------------

--Q1)How many unique customer types does the data have?
SELECT DISTINCT Customer_type
FROM WalmartSales;

--Q2)How many unique payment methods does the data have?
SELECT DISTINCT Payment
FROM WalmartSales;

--Q3)What is the most common customer type?
SELECT Customer_type , COUNT(Customer_type) AS 'Customer type'
FROM WalmartSales
GROUP BY Customer_type
ORDER BY [Customer type] DESC;

--Q4)What is the gender of most of the customers?
SELECT Gender,COUNT(Gender) AS 'Count Gender'
FROM WalmartSales
GROUP BY Gender
ORDER BY [Count Gender] DESC;

--Q5)What is the gender distribution per branch?
SELECT Branch , Gender , COUNT(Gender) 'Gender Count'
FROM WalmartSales
GROUP BY Branch , Gender
ORDER BY [Gender Count] DESC;

--Q6) Which time of the day do customers give most ratings?
SELECT Day_name , Max(Rating) AS 'Max Rating'
FROM WalmartSales
GROUP BY Day_name
ORDER BY [Max Rating] DESC;

--Q7)-- Which time of the day do customers give most ratings per branch?
SELECT Branch , Day_name , Max(Rating) AS 'Max Rating'
FROM WalmartSales
GROUP BY Branch , Day_name
ORDER BY [Max Rating] DESC;

--Q7) Which time of the day do customers give most ratings per branch?
SELECT Day_name , Max(Rating) AS 'Max Rating'
FROM WalmartSales
WHERE Branch = 'A'
GROUP BY Day_name
ORDER BY [Max Rating] DESC;

--Q8)Which day fo the week has the best avg ratings?
SELECT Day_name , AVG(Rating) AS 'AVG Rating'
FROM WalmartSales
GROUP BY Day_name
ORDER BY [AVG Rating] DESC;

--Q9)Which day of the week has the best average ratings per branch?
SELECT Branch , Day_name , AVG(Rating) AS 'AVG Rating'
FROM WalmartSales
GROUP BY Branch , Day_name
ORDER BY [AVG Rating] DESC;



----------------------------------Sales--------------------------------------
--Q1)Number of sales made in each time of the day per weekday
SELECT Day_name , COUNT(*) as 'Total sale'
FROM WalmartSales
GROUP BY Day_name
ORDER BY [Total sale] DESC;

--Q2)Which of the customer types brings the most revenue?
SELECT Customer_type , SUM(Total) AS 'Total Revenue'
FROM WalmartSales
GROUP BY Customer_type
ORDER BY [Total Revenue];

--Q3)Which city has the largest tax/VAT percent?
SELECT City , ROUND(SUM(Tax_5),2) AS 'Total Tax'
FROM WalmartSales
GROUP BY City
ORDER BY [Total Tax] DESC;

--Q4)Which customer type pays the most in VAT
SELECT Customer_type , ROUND(SUM(Tax_5),2) AS 'Total Tax'
FROM WalmartSales
GROUP BY Customer_type
ORDER BY [Total Tax] DESC;






