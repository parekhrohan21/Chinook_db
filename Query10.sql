SELECT
    COALESCE(t.composer, a.name) AS artist_composer,
    COUNT(t.track_id) AS track_count
FROM
    track t
JOIN
    album al ON t.album_id = al.album_id
JOIN
    artist a ON al.artist_id = a.artist_id
GROUP BY
    artist_composer
ORDER BY
    track_count DESC
LIMIT 1;
