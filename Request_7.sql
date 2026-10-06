/*
Q7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . 
	This analysis helps to get an idea of low and high-performing months and take strategic decisions.
    
	The final report contains these columns:
	 - Month
	 - Year
	 - Gross sales Amount
*/

SELECT
YEAR(fsm.date) AS "Year",
MONTH(fsm.date) AS "Month",
ROUND(SUM(fsm.sold_quantity * fgp.gross_price)/1000000,2) AS "Gross Sales Amount (Mn)"
FROM
	dim_customer c
INNER JOIN	
	fact_sales_monthly fsm
		USING(customer_code)
INNER JOIN
	fact_gross_price fgp
		ON fgp.product_code = fsm.product_code
         AND 
			fgp.fiscal_year = fsm.fiscal_year
WHERE 
	customer = "Atliq Exclusive"
GROUP BY
	1,2
ORDER BY
	1,2
;

	