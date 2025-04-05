-- Use the retail_analysis database
USE retail_analysis;

-- View all records in the table
SELECT * FROM retail_analysis;

-- 1. Retrieve all columns for sales made on 2022-11-05
SELECT *
FROM retail_analysis
WHERE sale_date = '2022-11-05';

-- 2. Retrieve transactions where category is 'Clothing' and quantity > 4 in November 2022
SELECT *
FROM retail_analysis
WHERE category = 'Clothing'
  AND quantity > 4
  AND sale_date LIKE '2022-11-%'
ORDER BY transactions_id;

-- 3. Calculate total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS total_sales
FROM retail_analysis
GROUP BY category;

-- 4. Find average age of customers who purchased items from 'Beauty' category
SELECT category, AVG(age) AS average_age
FROM retail_analysis
WHERE category = 'Beauty';

-- 5. Retrieve all transactions where total_sale > 1000
SELECT *
FROM retail_analysis
WHERE total_sale > 1000;

-- 6. Count number of transactions by each gender in each category
SELECT gender, category, COUNT(transactions_id) AS transactions
FROM retail_analysis
GROUP BY gender, category
ORDER BY gender;

-- 7. Calculate average sale per month and find best selling month in each year
SELECT year, month, total_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(cogs) AS total_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(cogs) DESC) AS rnk
    FROM retail_analysis
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_sales
WHERE rnk = 1;

-- 8. Find top 5 customers based on highest total sales
SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail_analysis
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- 9. Count unique customers per category
SELECT category, COUNT(DISTINCT customer_id) AS num_customers
FROM retail_analysis
GROUP BY category;

-- 10. Create each shift and count number of orders in each
SELECT 
  COUNT(transactions_id) AS orders,
  CASE
    WHEN sale_time < '12:00:00' THEN 'MORNING'
    WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'AFTERNOON'
    ELSE 'EVENING'
  END AS shift
FROM retail_analysis
GROUP BY shift;
