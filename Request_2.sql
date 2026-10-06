/*
Q2. What is the percentage of unique product increase in 2021 vs. 2020? 

	The final output contains these fields: 
	 - unique_products_2020
	 - unique_products_2021
	 - percentage_chg
*/

SELECT
	COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END) AS "Unique Products - 2020",
    COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN product_code END) AS "Unique Products - 2021",
    ROUND( 
			(COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN product_code END) - COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END))
			* 100             
			/  NULLIF(COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN product_code END), 0), 2
        ) AS "% Change"
FROM 
	fact_sales_monthly
WHERE 
	fiscal_year IN (2020,2021)
;