-- Validation: Product Popularity by Time Range
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    c.Name AS CategoryName,
    SUM(ti.Quantity) AS TotalQuantitySold,
    SUM(ti.Quantity * ti.PriceAtPurchase) AS TotalRevenue
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID
LEFT JOIN TransactionItem ti ON p.ProductID = ti.ProductID
LEFT JOIN Transaction t ON ti.TransactionID = t.TransactionID
WHERE t.TransactionDate BETWEEN '2026-01-01 00:00:00' AND '2026-05-29 09:44:36'
GROUP BY p.ProductID, p.Name, c.Name
ORDER BY TotalQuantitySold DESC;