SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(fs.TotalAmount) as TotalSales
FROM factsales fs
JOIN dimcustomers c ON fs.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
