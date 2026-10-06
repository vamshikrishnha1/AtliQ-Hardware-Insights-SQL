/*
Q4. Which segment had the most increase in unique products in 2021 vs 2020? 
	
    The final output contains these fields
	 - segment
	 - product_count_2020
	 - product_count_2021
	 - difference
*/

SELECT
	p.segment,
	COUNT(DISTINCT CASE WHEN fsm.fiscal_year = 2020 THEN fsm.product_code END) AS product_count_2020,
    COUNT(DISTINCT CASE WHEN fsm.fiscal_year = 2021 THEN fsm.product_code END) AS product_count_2021,
    COUNT(DISTINCT CASE WHEN fsm.fiscal_year = 2021 THEN fsm.product_code END) - COUNT(DISTINCT CASE WHEN fsm.fiscal_year = 2020 THEN fsm.product_code END) AS difference
FROM 
	dim_product p
LEFT JOIN
	fact_sales_monthly fsm
     USING(product_code)
GROUP BY 
	p.segment
ORDER BY 
	difference DESC
;