SELECT g.name AS genre_name, SUM(il.quantity) AS tracks_sold
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name
ORDER BY tracks_sold;