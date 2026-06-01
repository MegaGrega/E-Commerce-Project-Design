SELECT 
    u.UserID,
    u.FirstName,
    u.LastName,
    COUNT(DISTINCT t.TransactionID) AS OrderCount
FROM User u
JOIN Transaction t ON u.UserID = t.UserID
WHERE t.TransactionDate >= '2026-05-01 00:00:00' 
  AND t.TransactionDate < '2026-06-01 00:00:00'
GROUP BY u.UserID, u.FirstName, u.LastName
ORDER BY OrderCount DESC;