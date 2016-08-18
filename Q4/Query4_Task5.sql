/* Task 5 */
SELECT a.RobberID, NickName, SUM(Share) AS Earnings
FROM Accomplices a
JOIN Robbers r on a.RobberID = r.RobberID
GROUP BY a.RobberID, r.NickName
HAVING SUM(Share) > 30000
ORDER BY Earnings DESC;