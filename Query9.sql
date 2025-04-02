-- SELECT
--     (COUNT(DISTINCT pt.track_id) * 100.0 / COUNT(DISTINCT t.track_id)) 
--     AS percentage_in_playlists
-- FROM
--     track t
-- LEFT JOIN
--     playlist_track pt ON t.track_id = pt.track_id;


Select Count(Distinct pt.track_id)
From playlist_track pt
Join track t on pt.track_id = t.track_id
Where t.composer is not null
Group by t.composer
Order by Count(pt.track_id) desc
Limit 1;
