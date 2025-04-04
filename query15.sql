WITH YearlyRevenue AS (
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        EXTRACT(YEAR FROM i.invoice_date) AS year,
        SUM(i.total) AS total_revenue
    FROM
        employee e
    JOIN
        customer c ON e.employee_id = c.support_rep_id
    JOIN
        invoice i ON c.customer_id = i.customer_id
    GROUP BY
        e.employee_id, e.first_name, e.last_name, year
),
RankedRevenue AS (
    SELECT
        year,
        employee_id,
        first_name,
        last_name,
        total_revenue,
        RANK() OVER (PARTITION BY year ORDER BY total_revenue DESC) AS revenue_rank
    FROM
        YearlyRevenue
)
SELECT
    employee_id,
    first_name,
    last_name,
    COUNT(*) AS wins
FROM
    RankedRevenue
WHERE
    revenue_rank = 1
GROUP BY
    employee_id, first_name, last_name
ORDER BY
    wins DESC
LIMIT 3;
