WITH MonthlyRevenue AS (
    SELECT
        DATE_FORMAT(invoice_date, '%Y-%m') AS year_month,
        SUM(total) AS total_revenue
    FROM
        invoice
    GROUP BY
        year_month
),
RevenueIncrease AS (
    SELECT
        year_month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY year_month) AS previous_month_revenue
    FROM
        MonthlyRevenue
)
SELECT
    year_month
FROM
    RevenueIncrease
WHERE
    (total_revenue - previous_month_revenue) / previous_month_revenue * 100 >= 40;
