# Chinook_db

Here I perform basic SQL tasks to understand better about data analysis
---

# Chinook Database Analysis and Tasks

## Description of the Chinook Database

The Chinook database is a sample database that models a digital media store, similar to iTunes. It contains information about artists, albums, tracks, customers, invoices, and employees. The database is designed to support queries related to sales, customer behaviour, and inventory management.

### Key Tables:
- **Artist**: Contains information about artists.
- **Album**: Contains information about albums, including the artist ID.
- **Track**: Contains information about individual tracks, including the album ID and genre ID.
- **Customer**: Contains information about customers.
- **Invoice**: Contains information about invoices, including the customer ID.
- **InvoiceLine**: Contains information about individual tracks sold, including the invoice ID and track ID.
- **Employee**: Contains information about employees.
- **Genre**: Contains information about music genres.

## Tasks Performed

### 1. Calculating Revenue Growth
- **Task**: Determine the year-months where the total revenue at Chinook was greater than the previous month by at least 40%.
- **Approach**: Calculated total revenue per month and identified months with a 40% or greater increase compared to the previous month.

### 2. Identifying Loyal Customers
- **Task**: Identify customers considered "loyal" based on their average invoice total in the last 6 months exceeding their average invoice total prior to the last 6 months.
- **Approach**: Calculated average invoice totals for each customer for the specified periods and compared them to determine loyalty.

### 3. Genre Sales Analysis
- **Task**: Determine the genre that experienced the greatest decrease in sales from the previous year among those that sold at least 10 tracks in 2023.
- **Approach**: Calculated the number of tracks sold per genre for the specified years and identified the genre with the greatest decrease in sales.

### 4. Database Normalisation
- **Task**: Identify an aspect of the first normal form (1NF) that is not satisfied by the Chinook database.
- **Approach**: Discussed the presence of repeating groups within tables and how they violate the atomicity requirement of 1NF.

### 5. Atomising Data
- **Task**: Provide a solution to atomise data in a scenario where the composer field contains multiple names separated by a comma.
- **Approach**: Suggested creating a separate table for composers and using a foreign key to establish a many-to-many relationship between composers and tracks.

## SQL Queries

### Example Query: Loyal Customers
```sql
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
```

### Example Query: Genre Sales Decrease
```sql
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
```

## Conclusion

This README provides an overview of the tasks performed on the Chinook database, including SQL queries and approaches used to analyse and normalise the data. The Chinook database serves as a valuable resource for practising SQL queries and understanding database normalisation principles.

---
