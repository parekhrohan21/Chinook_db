SELECT
    t.composer,
    COUNT(pt.track_id) AS appearances
FROM
    playlist_track pt
JOIN
    track t ON pt.track_id = t.track_id
WHERE
    t.composer IS NOT NULL
GROUP BY
    t.composer
ORDER BY
    appearances DESC
LIMIT 1;
