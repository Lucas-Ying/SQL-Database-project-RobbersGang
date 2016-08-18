/* Task 5 */
CREATE VIEW Q5Task5 AS
SELECT City, AVG(Average) AS Average
FROM (
	SELECT BankName, City, RobberyDate AS Date, AVG(Share) AS Average
	FROM Accomplices
	GROUP BY BankName, City, Date
	ORDER BY City, Date
) AS Result
GROUP BY City;

/* Show result */
SELECT * FROM Q5Task5;