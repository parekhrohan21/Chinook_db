SELECT 
    mt.Name AS Media_Type,
    SUM(il.Quantity) AS Total_Tracks_Sold
FROM 
    invoice_line il
JOIN 
    track t ON il.track_id = t.track_id
JOIN 
    media_type mt ON t.Media_Type_Id = mt.Media_Type_Id
GROUP BY 
    mt.Media_Type_Id, mt.Name
ORDER BY 
    Total_Tracks_Sold ASC
LIMIT 1;