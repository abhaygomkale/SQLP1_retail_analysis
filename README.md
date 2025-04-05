# 🧠 Retail Analysis SQL Project

## 📌 About the Project
This project showcases a comprehensive SQL practice exercise using a simulated retail sales dataset named `retail_analysis`. It is designed for beginners and intermediate learners looking to sharpen their SQL skills in a practical, real-world scenario. The dataset includes transaction records with fields like:

- `transactions_id`
- `sale_date`
- `sale_time`
- `customer_id`
- `gender`
- `age`
- `category`
- `quantity`
- `price_per_unit`
- `cogs`
- `total_sale`

Using this dataset, you will learn to write efficient queries that solve real analytics problems such as identifying peak sales periods, analyzing customer behavior, and calculating revenue.

---

## 📊 SQL Queries Covered

### 🔍 Basic Queries
```sql
-- 1. Retrieve all sales made on a specific date
SELECT * FROM retail_analysis WHERE sale_date = '2022-11-05';

-- 2. Clothing category transactions with quantity > 4 in Nov 2022
SELECT * FROM retail_analysis
WHERE category = 'Clothing' AND quantity > 4 AND sale_date LIKE '2022-11-%';
```

### 📈 Aggregation & Grouping
```sql
-- 3. Total sales for each category
SELECT category, SUM(total_sale) AS Total_Sales
FROM retail_analysis
GROUP BY category;

-- 4. Average age of customers in Beauty category
SELECT category, AVG(age) AS average_beauty
FROM retail_analysis
WHERE category = 'Beauty';

-- 5. Transactions where total_sale > 1000
SELECT * FROM retail_analysis
WHERE total_sale > 1000;
```

### 📦 Grouping with Multiple Columns
```sql
-- 6. Total transactions by gender and category
SELECT gender, category, COUNT(transactions_id) AS Transactions
FROM retail_analysis
GROUP BY gender, category
ORDER BY gender;
```

### 📅 Date and Time Analysis
```sql
-- 7. Average sales per month, best-selling month per year
SELECT YEAR, MONTH, total_sale
FROM (
    SELECT
        MONTH(sale_date) AS MONTH,
        YEAR(sale_date) AS YEAR,
        SUM(cogs) AS total_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(cogs) DESC) AS rnk
    FROM retail_analysis
    GROUP BY MONTH(sale_date), YEAR(sale_date)
) AS monthly_sales
WHERE rnk = 1;
```

### 🧑‍🤝‍🧑 Customer Insights
```sql
-- 8. Top 5 customers based on total sales
SELECT customer_id, SUM(total_sale) AS Total_sale
FROM retail_analysis
GROUP BY customer_id
ORDER BY Total_sale DESC
LIMIT 5;

-- 9. Unique customers per category
SELECT category, COUNT(DISTINCT customer_id) AS NoOfCustomers
FROM retail_analysis
GROUP BY category;
```

### 🕒 Shift-wise Order Analysis
```sql
-- 10. Number of orders per shift (Morning, Afternoon, Evening)
SELECT
  COUNT(transactions_id) AS Orders,
  CASE
    WHEN sale_time < '12:00:00' THEN 'MORNING'
    WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'AFTERNOON'
    ELSE 'EVENING'
  END AS Shift
FROM retail_analysis
GROUP BY Shift;
```

---

## ✅ How to Use
- Clone this repository
- Run the SQL scripts in your MySQL workbench or any SQL IDE
- Use the queries as practice or enhance them to fit your own dataset

---

## 📌 License
This project is for learning and educational purposes. Feel free to fork and modify.

