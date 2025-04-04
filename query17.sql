WITH MetalTracks AS (
    SELECT
        i.invoice_date,
        il.quantity
    FROM
        invoice_line il
    JOIN
        invoice i ON il.invoice_id = i.invoice_id
    JOIN
        track t ON il.track_id = t.track_id
    JOIN
        genre g ON t.genre_id = g.genre_id
    WHERE
        g.name = 'Metal'
)
SELECT
    (SUM(CASE WHEN EXTRACT(YEAR FROM invoice_date) = 2024 THEN quantity ELSE 0 END) -
     SUM(CASE WHEN EXTRACT(YEAR FROM invoice_date) = 2023 THEN quantity ELSE 0 END)) * 100.0 /
     NULLIF(SUM(CASE WHEN EXTRACT(YEAR FROM invoice_date) = 2023 THEN quantity ELSE 0 END), 0) AS growth_percentage
FROM
    MetalTracks;
