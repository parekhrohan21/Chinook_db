SELECT g.name AS genre_name, COUNT(il.track_id) AS tracks_sold
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;