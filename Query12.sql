WITH EmployeeSales AS (
    SELECT
        e.employee_id,
        SUM(i.total) AS total_sales
    FROM
        employee e
    JOIN
        customer c ON e.employee_id = c.support_rep_id
    JOIN
        invoice i ON c.customer_id = i.customer_id
    GROUP BY
        e.employee_id
)
SELECT
    (MAX(total_sales) - MIN(total_sales)) * 100.0 / MIN(total_sales) AS percentage_difference
FROM
    EmployeeSales;
