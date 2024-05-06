select * from amazon.amazonsales;

use amazon;

select distinct timeofday from amazon.amazonsales ;


-- Analysis List
---------------------------------------------------------------------------------------------------------------------------------------
#2.1
 -- Add the new column
 
ALTER TABLE amazonsales
ADD COLUMN timeofday VARCHAR(10);

-- Update the timeofday column based on the time column
UPDATE amazonsales
SET timeofday =
    CASE
      
        WHEN TIME(time) >= '00:00:00' AND TIME(time) < '12:00:00' THEN 'Morning'
        WHEN TIME(time) >= '12:00:00' AND TIME(time) < '17:00:00' THEN 'Afternoon'
       ELSE 'Evening'
    END 
WHERE time IS NOT NULL ;  -- Add a WHERE clause if necessary to filter records

-- Optional: Display the updated records
SELECT * FROM sales_table;

-------------------------------------------------------------------------------------------------------------------------------------
#2.2
 ALTER TABLE amazonsales
 ADD COLUMN dayname VARCHAR(3);
 
 UPDATE amazonsales
 SET dayname = UPPER(LEFT(DAYNAME(date), 3));
 
#2.3
 ALTER TABLE amazonsales
 ADD COLUMN monthname VARCHAR(3);
 
 UPDATE amazonsales
 SET monthname = UPPER(LEFT(monthname(date), 3));
 
 
 /*-----------------------------------------------------------------------------------------------------------------------------------*/


-- Q.1 What is the count of distinct cities in the dataset?

select count(distinct(city)) as Count_of_distinct_city from amazon.amazonsales;


 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.2 For each branch, what is the corresponding city?

select branch, city from amazon.amazonsales group by branch, city; 

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.3 What is the count of distinct product lines in the dataset?

select count(distinct(Product_line)) as Count_of_distinct_product_line from amazon.amazonsales;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.4 Which payment method occurs most frequently?

select payment_method, count(payment_method) as Total_Payment_Method from amazon.amazonsales 
group by payment_method order by Total_Payment_Method Desc; 

select payment_method, count(payment_method) as Total_Payment_Method from amazon.amazonsales
 group by payment_method order by Total_Payment_Method Desc limit 1; 

 /*-----------------------------------------------------------------------------------------------------------------------------------*/
-- Q.5 Which product line has the highest sales?

select product_line, sum(total) as total_sales from amazon.amazonsales
 group by product_line ORDER BY total_sales DESC; 
 
select product_line, sum(total) as total_sales from amazon.amazonsales
 group by product_line ORDER BY total_sales DESC limit 1;
 
 
 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.6 How much revenue is generated each month?

select monthname as Month, sum(total) as Total_Monthly_Revenue from amazon.amazonsales
 group by monthname order by Total_Monthly_Revenue Desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.7 In which month did the cost of goods sold(cogs) reach its peak?

select monthname as Month, sum(cogs) as Total_Cogs from amazon.amazonsales
 group by monthname order by Total_Cogs Desc;


 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.8 Which product line generated the highest revenue?

select product_line, sum(total) as Total_Revenue from amazon.amazonsales
 group by product_line order by Total_Revenue Desc;
 
select product_line, sum(total) as Total_Revenue from amazon.amazonsales
 group by product_line order by Total_Revenue Desc limit 1;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.9 In which city was the highest revenue recorded?

select city, sum(total) as Total_Revenue from amazon.amazonsales
 group by city order by Total_Revenue Desc;

select city, sum(total) as Total_Revenue from amazon.amazonsales
 group by city order by Total_Revenue Desc limit 1;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.10 Which product line incurred the highest Value Added Tax?

select Product_line, sum(vat) as Total_VAT from amazon.amazonsales
 group by Product_line order by Total_VAT Desc;
 
select Product_line, sum(vat) as Total_VAT from amazon.amazonsales 
group by Product_line order by Total_VAT Desc limit 1;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/
 
-- Q.11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

Select product_line, total,
    CASE 
        WHEN total > (select avg(total) from amazon.amazonsales) THEN 'Good'
        ELSE 'Bad'
    END as Sales_Performance
from amazon.amazonsales group by product_line;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/
 
-- Q.12 Identify the branch that exceeded the average number of products sold.
SELECT branch,  total_quantity_sold
FROM    (SELECT branch, SUM(quantity) AS total_quantity_sold FROM amazonsales GROUP BY branch) branch_totals
WHERE total_quantity_sold > (SELECT AVG(quantity) FROM amazonsales);

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q. 13 Which product line is most frequently associated with each gender?

SELECT
    gender,
    product_line,
    COUNT(*) AS frequency
FROM
    amazonsales  
GROUP BY
    gender,
    product_line
ORDER BY
    gender,
    frequency DESC;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q. 14 Calculate the average rating for each product line.

select product_line, avg(rating) as avg_rating
from amazonsales
group by product_line
order by avg_rating desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q. 15  Count the sales occurrences for each time of day on every weekday.

select dayname, timeofday, count(*) as sales_occur 
from amazonsales
where dayname not in ('SAT','SUN')
group by timeofday, dayname
order by sales_occur desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q. 16 Identify the customer type contributing the highest revenue.

select customer_type, sum(total) as highest_revenue from amazonsales
group by customer_type 
order by highest_revenue desc ;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q. 17 Determine the city with the highest VAT percentage.

SELECT
    city,
    AVG(VAT / total) * 100 AS average_vat_percentage
FROM
    amazonsales  -- Replace with your actual table name
GROUP BY
    city
ORDER BY
    average_vat_percentage DESC
limit 1 ;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.18 Identify the customer type with the highest VAT payments.

select customer_type, sum(VAT) as highest_VAT
from amazonsales
group by customer_type
order by highest_VAT desc ;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.19 What is the count of distinct customer types in the dataset?

select count(distinct customer_type) as count_dist_cust
from amazonsales; 

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.20 What is the count of distinct payment methods in the dataset?

select count(distinct(payment_method)) as count_dist_payment_method 
from amazonsales;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.21 Which customer type occurs most frequently?
select customer_type, count(*) as Frequency from amazonsales group by customer_type;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.22 Identify the customer type with the highest purchase frequency.
select customer_type, count(*) as purchase_Frequency from amazonsales group by customer_type
order by purchase_frequency desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.23 Determine the predominant gender among customers.
select gender, count(*) as Customers from amazonsales group by gender order by Customers desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.24 Examine the distribution of genders within each branch.
select branch, gender, count(*) as distribution from amazonsales group by branch, gender order by distribution desc; 

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.25 Identify the time of day when customers provide the most ratings.
select timeofday, count(rating) as Rating from amazonsales group by timeofday order by Rating desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q26 Determine the time of day with the highest customer ratings for each branch.
select timeofday, branch, max(rating) as Rating from amazonsales group by timeofday, branch order by branch, Rating desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.27 Identify the day of the week with the highest average ratings.
select dayname, avg(rating) as Highest_avg_rating from amazonsales group by dayname order by Highest_avg_rating desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/

-- Q.28 Determine the day of the week with the highest average ratings for each branch.
select dayname, branch, avg(rating) as Highest_avg_rating from amazonsales group by dayname, branch 
order by dayname, branch, Highest_avg_rating desc;

 /*-----------------------------------------------------------------------------------------------------------------------------------*/
 /*-----------------------------------------------------------------------------------------------------------------------------------*/
 /*-----------------------------------------------------------------------------------------------------------------------------------*/
