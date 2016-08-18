/* Task 1 */
CREATE VIEW Q5Task1 AS
SELECT Nickname
FROM Robbers
NATURAL JOIN (
	SELECT RobberID, Earnings
	FROM (
		SELECT RobberID, COUNT(RobberID) AS NoAccomplices, SUM(Share) AS Earnings
		FROM Accomplices
		GROUP BY RobberID
	) AS TempRobbers
	WHERE NoAccomplices > (
		SELECT AVG(NoAccomplices) AS Average
		FROM (
			SELECT RobberID, COUNT(RobberID) AS NoAccomplices
			FROM Accomplices
			GROUP BY RobberID
		) AS Average
	)
) AS FinalRobbers
WHERE NoYears = 0
ORDER BY Earnings DESC;

/* Show result */
SELECT * FROM Q5Task1;