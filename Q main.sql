select * from customers;
select * from exchange_rates;
select * from product;
select * from sales;
select * from store;

-- queries to get insights from 5 tables
-- 1.overall female count
select count(C_Gender) as Female_count from customers
where C_Gender="Female";

-- 2.overall male count
select count(C_Gender) as Male_count from customers
where C_Gender="Male";

-- 3.count of customers in country wise
select sd.Store_Country,count(distinct c.CustomerKey)  as customer_count 
from sales c join store sd on c.StoreKey=sd.StoreKey
group by sd.Store_Country order by customer_count desc;

-- 4.overall count of customers
select count(distinct s.CustomerKey)  as customer_count 
from sales  s;

-- 5.count of stores in country wise
select Store_Country,count(StoreKey) from store
group by Store_Country order by count(StoreKey) desc;

-- 6.store wise sales
select s.StoreKey,sd.Store_Country,sum(Unit_Price_USD*s.Quantity) as total_sales_amount from product pd
join sales s on pd.ProductKey=s.ProductKey 
join store sd on s.StoreKey=sd.StoreKey group by s.StoreKey,sd.Store_Country;

-- 7.overall selling amount
select sum(Unit_Price_USD*sd.Quantity) as total_sales_amount from product pd
join sales sd on pd.ProductKey=sd.ProductKey ;

-- 8. brand count
select Brand ,count(Brand) as brand_count from product group by  Brand;

-- 9.cp and sp diffenecnce and profit
select Unit_Price_USD,Unit_Cost_USD,round((Unit_Price_USD-Unit_Cost_USD),2) as diff,
round(((Unit_Price_USD-Unit_Cost_USD)/Unit_Cost_USD)*100,2) as profit_percent
from product;

-- 10. brand wise selling amount
select Brand,round(sum(Unit_price_USD*sd.Quantity),2) as sales_amount
from product pd join sales sd on pd.ProductKey=sd.ProductKey group by Brand;

-- 11.Count of Subcategory 
select Sub_Category,count(Sub_Category) from product group by Sub_Category;

-- 12.Subcategory wise selling amount
select Sub_Category ,round(sum(Unit_price_USD*sd.Quantity),2) as TOTAL_SALES_AMOUNT
from product pd join sales sd on pd.ProductKey=sd.ProductKey
 group by Sub_Category order by TOTAL_SALES_AMOUNT desc;

-- 13.year wise brand sales
select year(Order_Date),pd.Brand,round(SUM(Unit_price_USD*sd.Quantity),2) as year_sales FROM sales sd
join product pd on sd.ProductKey=pd.ProductKey group by year(Order_Date),pd.Brand;

-- 14.overall sales with quatity
select Brand,sum(Unit_Price_USD*sd.Quantity) as sp,sum(Unit_Cost_USD*sd.Quantity) as cp,
(SUM(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity)) / SUM(Unit_Cost_USD*sd.Quantity) * 100 as profit 
from product pd join sales sd on sd.ProductKey=pd.ProductKey
group by Brand;

-- 15.month wise sales with quatity
select month(Order_Date),sum(Unit_Price_USD*sd.Quantity) as sp_month from sales  sd join product pd on sd.ProductKey=pd.ProductKey
group by month(Order_Date);

-- 16.month and year wise sales with quatity
select month(Order_Date),year(Order_Date),Brand,sum(Unit_Price_USD*sd.Quantity) as sp_month from sales sd join product pd on sd.ProductKey=pd.ProductKey
group by month(Order_Date),year(Order_Date),Brand;

--  17.year wise sales
select year(Order_Date),sum(Unit_Price_USD*sd.Quantity) as sp_month from sales sd join product pd on sd.ProductKey=pd.ProductKey
group by year(Order_Date);

-- 18.comparing current_month and previous_month
select YEAR(Order_Date),month(Order_Date) ,round(sum(Unit_Price_USD*sd.Quantity),2) as sales, LAG(sum(Unit_Price_USD*sd.Quantity))
OVER(order by YEAR(Order_Date), month(Order_Date)) AS Previous_Month_Sales from sales sd join product pd 
on sd.ProductKey=pd.ProductKey GROUP BY 
    YEAR(Order_Date), month(Order_Date);
    
-- 19.comparing current_year and previous_year sales
select YEAR(Order_Date) as year ,round(sum(Unit_Price_USD*sd.Quantity),2) as sales, LAG(sum(Unit_Price_USD*sd.Quantity))
OVER(order by YEAR(Order_Date)) AS Previous_Year_Sales from sales sd join product pd 
on sd.ProductKey=pd.ProductKey GROUP BY 
    YEAR(Order_Date);
    
-- 20.month wise profit
select YEAR(Order_Date) as year,month(Order_Date) as month,(SUM(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity)) as sales, 
LAG(sum(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))
OVER(order by YEAR(Order_Date), month(Order_Date)) AS Previous_Month_Sales,
round(((SUM(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))-
LAG(sum(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))
OVER(order by YEAR(Order_Date), month(Order_Date)))/LAG(sum(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))
OVER(order by YEAR(Order_Date), month(Order_Date))*100,2) as profit_percent
from sales sd join product pd 
on sd.ProductKey=pd.ProductKey GROUP BY 
    YEAR(Order_Date), month(Order_Date);
    
 -- 21.year wise profit   
select YEAR(Order_Date) as Year ,(SUM(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity)) as sales, 
LAG(sum(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))
OVER(order by YEAR(Order_Date)) AS Previous_year_Sales,
round(((SUM(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))-
LAG(sum(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))
OVER(order by YEAR(Order_Date)))/LAG(sum(Unit_Price_USD*sd.Quantity) - SUM(Unit_Cost_USD*sd.Quantity))
OVER(order by YEAR(Order_Date))*100,2) as profit_percent
from sales sd join product pd 
on sd.ProductKey=pd.ProductKey GROUP BY 
    YEAR(Order_Date);

    

    

    



