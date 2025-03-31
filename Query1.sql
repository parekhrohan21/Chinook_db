SELECT COUNT(*) AS non_managers_count
FROM employee
WHERE employee_id NOT IN (
    SELECT DISTINCT reports_to
    FROM employee
    WHERE reports_to IS NOT NULL
);