WITH GenreSales AS (
    SELECT
        g.name AS genre,
        EXTRACT(YEAR FROM i.invoice_date) AS year,
        SUM(il.quantity) AS total_tracks_sold
    FROM
        invoice_line il
    JOIN
        invoice i ON il.invoice_id = i.invoice_id
    JOIN
        track t ON il.track_id = t.track_id
    JOIN
        genre g ON t.genre_id = g.genre_id
    GROUP BY
        g.name, year
),
FilteredGenres AS (
    SELECT
        genre,
        total_tracks_sold AS tracks_sold_2023
    FROM
        GenreSales
    WHERE
        year = 2023 AND total_tracks_sold >= 10
),
PreviousYearSales AS (
    SELECT
        gs.genre,
        gs.tracks_sold_2023,
        gs2022.total_tracks_sold AS tracks_sold_2022
    FROM
        FilteredGenres gs
    JOIN
        GenreSales gs2022 ON gs.genre = gs2022.genre AND gs2022.year = 2022
)
SELECT
    genre,
    tracks_sold_2023,
    tracks_sold_2022,
    tracks_sold_2023 - tracks_sold_2022 AS decrease_in_sales
FROM
    PreviousYearSales
ORDER BY
    decrease_in_sales
LIMIT 1;
