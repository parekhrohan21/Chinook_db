SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    e.employee_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    COUNT(i.invoice_id) AS purchase_count
FROM
    customer c
JOIN
    invoice i ON c.customer_id = i.customer_id
JOIN
    employee e ON c.support_rep_id = e.employee_id
GROUP BY
    c.customer_id, c.first_name, c.last_name, e.employee_id, e.first_name, e.last_name
ORDER BY
    purchase_count DESC;
