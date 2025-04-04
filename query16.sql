WITH YearlyTrackSales AS (
    SELECT
        EXTRACT(YEAR FROM invoice_date) AS year,
        COUNT(track_id) AS total_tracks_sold
    FROM
        invoice_line il
    JOIN
        invoice i ON il.invoice_id = i.invoice_id
    GROUP BY
        year
),
AdjustedTrackSales AS (
    SELECT
        year,
        COALESCE(NULLIF(total_tracks_sold, 0), 1) AS adjusted_tracks_sold
    FROM
        YearlyTrackSales
)
SELECT
    a1.year AS year_x,
    a2.year AS year_x_plus_1,
    a2.adjusted_tracks_sold / a1.adjusted_tracks_sold AS growth_ratio
FROM
    AdjustedTrackSales a1
JOIN
    AdjustedTrackSales a2 ON a1.year = a2.year - 1;
