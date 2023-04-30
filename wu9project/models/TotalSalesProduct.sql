SELECT
    p.ProductID,
    p.ProductName,
    p.Brand,
    SUM(fs.TotalAmount) as TotalSales
FROM factsales fs
JOIN dimproducts p ON fs.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName, p.Brand;

