Create table Retail_sales (
transactions_id INT primary key ,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age INT,
category Varchar(15),
quantity Int,
price_per_unit Float,
cogs Float,
total_sale Float
 
);

SELECT * FROM retail_sales ;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

		Select * from retail_sales
		where sale_date = '2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

		Select * from retail_sales
		where category = 'Clothing' and 
		To_CHAR(sale_date, 'YYYY-MM') = '2022-11'
		and quantity >= 4;
		
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

		select category, sum(total_sale) as Total_sale_for_each_category
		from retail_sales
		group by 1;

		
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

		select round(avg(age),2) from retail_sales
		where category = 'Beauty';
		
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

		SELECT * from retail_sales 
		where total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

		select gender,category, count(transactions_id)
		from retail_sales
		group by 1,2;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
		
		select year,
		month,
		avg_sale
		from 
		(
		select 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as avg_sale,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) desc) as rank
		from retail_sales
		group by 1,2
		) as t1
		where rank = 1
		order by 1,3 desc;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

		Select customer_id, sum(total_sale)
		from retail_sales
		group by 1
		order by 2 desc 
		limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

				select category,
				count(distinct customer_id) as distinct_customers
				from retail_sales
				group by category;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

				with hourly_sale
				as
				(
				select *,
				case 
				when Extract(Hour from sale_time) <= 12 then 'Morning'
				when Extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
				when Extract(Hour from sale_time) > 17 then 'Evening'
				end as shift
				from retail_sales)
				Select shift, count(*) as Total_orders from hourly_sale
				group by shift
				;


	-- End of Project -- 
