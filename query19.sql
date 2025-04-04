WITH Last6Months AS (
    SELECT
        c.customer_id,
        AVG(i.total) AS avg_last_6_months
    FROM
        customer c
    JOIN
        invoice i ON c.customer_id = i.customer_id
    WHERE
        i.invoice_date >= '2023-11-07'
    GROUP BY
        c.customer_id
),
Prior6Months AS (
    SELECT
        c.customer_id,
        AVG(i.total) AS avg_prior_6_months
    FROM
        customer c
    JOIN
        invoice i ON c.customer_id = i.customer_id
    WHERE
        i.invoice_date < '2023-11-07'
    GROUP BY
        c.customer_id
)
SELECT
    COUNT(*) AS loyal_customers
FROM
    Last6Months l6
JOIN
    Prior6Months p6 ON l6.customer_id = p6.customer_id
WHERE
    l6.avg_last_6_months > p6.avg_prior_6_months;
