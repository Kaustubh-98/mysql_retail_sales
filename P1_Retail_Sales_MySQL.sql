--DATA CLEANING
SELECT *
FROM retail_sales
WHERE transaction_id IS NULL;

SELECT *
FROM retail_sales
WHERE sale_time IS NULL;

SELECT *
FROM retail_sales
WHERE transaction_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sales IS NULL OR age IS NULL;

DELETE FROM retail_sales
WHERE quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- DATA EXPLORATION
-- Q1 how many sales have we closed?
SELECT COUNT(transaction_id)
FROM retail_sales;
-- Q2 how many unique customer and categories?
SELECT DISTINCT(customer_id)
FROM retail_sales;
SELECT DISTINCT(category)
FROM retail_sales;

-- DATA ANALYSIS & BUSINESS KEY PROBLEMS 

-- Q1 Write a SQL query to retrive all columns for sales made on 2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05';

-- Q2 Write a SQL to retrive all transaction where category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-22
SELECT *
FROM retail_sales
WHERE category='Clothing' AND DATE_FORMAT(sale_date,"%M %d")= 'Nov 22'
AND quantity>=4;

-- Q3 Write a SQL query to calculate total sales for each category
SELECT category, SUM(total_sales) AS net_sale, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Q4 Write a SQL query to find th avergae age of customers who purchased items from the 'Beauty' category;
SELECT ROUND(AVG(age),2) AS average_age
FROM retail_sales
WHERE category = 'beauty';

-- Q5 Write a SQL query to find all transaction where total_sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sales>1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender to each category
SELECT gender, category, SUM(transaction_id) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY 2;

-- Q7 Write a SQL query to calculate the average sale for each month, Find out the best selling month in each year
SELECT *
FROM (SELECT YEAR(sale_date) AS "YEAR", MONTH(sale_date) AS "Month", AVG(total_sales) AS "Avg_Sales",
RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sales) DESC) AS "Rank"
FROM retail_sales
GROUP BY 1,2) AS t1
WHERE t1.Rank=1;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sales) AS "total_sales"
FROM retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT customer_id) AS unq_customers
FROM retail_sales
GROUP BY category;

-- Q10 Write a SQL query to create each shift and number of Order (Morining <=12, Afternoon between 12 and 17, Evening>=17)
SELECT COUNT(*),
CASE 
	WHEN HOUR(sale_time) <=12 THEN 'morning'
    WHEN HOUR(sale_time)  BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS 'Shift'
FROM retail_sales
GROUP BY shift;

-- END OF PROJECT
