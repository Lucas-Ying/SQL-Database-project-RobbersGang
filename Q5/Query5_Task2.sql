/* Task 2 */
CREATE VIEW Q5Task2 AS
SELECT Security, COUNT(*) AS NoRobberies, AVG(Amount) AS Average
FROM (
	SELECT Security, Amount
	FROM Banks
	NATURAL JOIN Robberies
) AS Instances
GROUP BY Security;

/* Show result */
SELECT * FROM Q5Task2;