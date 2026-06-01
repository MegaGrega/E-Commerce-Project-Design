WITH InactiveUsers AS (
    SELECT 
        u.UserID
    FROM User u
    LEFT JOIN Transaction t ON u.UserID = t.UserID
    GROUP BY u.UserID
    HAVING MAX(t.TransactionDate) < '2026-03-01 00:00:00' OR MAX(t.TransactionDate) IS NULL
)

SELECT 
    iu.UserID,
    u.FirstName,
    u.LastName,
    p.ProductID,
    p.Name AS ProductName,
    SUM(ti.Quantity) AS TotalQuantityPurchased
FROM InactiveUsers iu
JOIN User u ON iu.UserID = u.UserID
LEFT JOIN Transaction t ON iu.UserID = t.UserID
LEFT JOIN TransactionItem ti ON t.TransactionID = ti.TransactionID
LEFT JOIN Product p ON ti.ProductID = p.ProductID
GROUP BY iu.UserID, u.FirstName, u.LastName, p.ProductID, p.Name
ORDER BY iu.UserID ASC, TotalQuantityPurchased DESC;