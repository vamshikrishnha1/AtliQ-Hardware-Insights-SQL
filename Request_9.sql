/*
Q9. Which channel helped to bring more gross sales in the fiscal year 2021
	 and the percentage of contribution? 
     
     The final output contains these fields: 
	 - channel
	 - gross_sales_mln
	 - percentage
*/

WITH cte1 AS (
		SELECT 
			c.channel,
			SUM(fgp.gross_price * fsm.sold_quantity)/1000000 AS gross_sales_mn
		FROM dim_customer c
		INNER JOIN 
			fact_sales_monthly fsm
				USING(customer_code)
		INNER JOIN
			fact_gross_price fgp
				ON fgp.product_code = fsm.product_code
					AND 
					fgp.fiscal_year = fsm.fiscal_year
		WHERE 
			fsm.fiscal_year = 2021
		GROUP BY 
			c.channel
			)
SELECT
	channel,
    ROUND(gross_sales_mn,2) AS gross_sales_mn,
    ROUND((gross_sales_mn *100)/ (SELECT SUM(gross_sales_mn) FROM cte1),2) AS percentage
FROM 
	cte1
ORDER BY 
	2 DESC
;
    