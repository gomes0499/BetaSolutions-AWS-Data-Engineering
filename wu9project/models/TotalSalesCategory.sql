SELECT
    p.CategoryID,
    p.CategoryName,
    SUM(fs.TotalAmount) as TotalSales
FROM factsales fs
JOIN dimproducts p ON fs.ProductID = p.ProductID
GROUP BY p.CategoryID, p.CategoryName;
