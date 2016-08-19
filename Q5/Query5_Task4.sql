/* Task 4 */
CREATE VIEW Q5Task4 AS
SELECT BankName, City, Security
FROM (
	SELECT BankName, City, Security, COUNT(RobberID) AS NoAccounts
	FROM (
		SELECT BankName, City, Security
		FROM Banks b
		WHERE NOT EXISTS (
			SELECT BankName, City
			FROM Robberies r
			WHERE Date > '2014-12-31' 
			AND Date < '2016-1-1' 
			AND b.BankName = r.BankName 
			AND b.City = r.City
		)
	) AS InPlan
	NATURAL JOIN (
		SELECT BankName, City
		FROM Plans
		WHERE PlannedDate > '2016-12-31' 
		AND PlannedDate < '2018-1-1'
	) AS Temp
	NATURAL JOIN HasAccounts
	GROUP BY BankName, City, Security
	ORDER BY NoAccounts DESC
) AS Result;

/* Show result */
SELECT * FROM Q5Task4;