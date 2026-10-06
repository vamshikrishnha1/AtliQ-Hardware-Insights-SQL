/*
Q10. Get the Top 3 products in each division that have a high
	 total_sold_quantity in the fiscal_year 2021? 
     
     The final output contains these fields:
	 - division
	 - product_code
	 - product
	 - total_sold_quantity
	 - rank_order
*/

WITH cte1 AS 
	(
	SELECT 
		p.division,
        p.product_code,
        CONCAT(p.product, " - ", p.variant) AS product,
        SUM(fsm.sold_quantity) AS total_sold_quantity        
	FROM 
		dim_product p
	LEFT JOIN
		fact_sales_monthly fsm
			USING (product_code)
	WHERE 
		fsm.fiscal_year = 2021
	GROUP BY
		1,2,3
	),
cte2 AS
    (
    SELECT 
        *,
        DENSE_RANK() OVER (PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order
    FROM 
        cte1
    )
SELECT *
FROM cte2
WHERE rank_order <=3; 