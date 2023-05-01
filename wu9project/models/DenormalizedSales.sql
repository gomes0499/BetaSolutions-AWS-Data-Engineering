CREATE TABLE denormalized_sales AS (
    SELECT
        fs.SalesID,
        fs.CustomerID,
        fs.ProductID,
        fs.DateID,
        fs.Quantity,
        fs.TotalAmount,
        dc.FirstName,
        dc.LastName,
        dc.Email,
        dc.Gender,
        dc.DateOfBirth,
        dc.RegistrationDate,
        dc.AgeGroup,
        dc.Address,
        dc.City,
        dc.State,
        dc.Country,
        dc.ZipCode,
        dp.ProductName,
        dp.CategoryID,
        dp.CategoryName,
        dp.Brand,
        dp.Description,
        dp.Price,
        dp.ImageURL,
        dd.Date,
        dd.Day,
        dd.Month,
        dd.Year,
        dd.Quarter,
        dd.Weekday
    FROM
        factsales fs
    JOIN dimcustomers dc ON fs.CustomerID = dc.CustomerID
    JOIN dimproducts dp ON fs.ProductID = dp.ProductID
    JOIN dimdates dd ON fs.DateID = dd.DateID
);
