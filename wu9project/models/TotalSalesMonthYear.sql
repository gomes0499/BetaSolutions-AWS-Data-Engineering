SELECT
    d.Year,
    d.Month,
    SUM(fs.TotalAmount) as TotalSales
FROM factsales fs
JOIN dimdates d ON fs.DateID = d.DateID
GROUP BY d.Year, d.Month;
