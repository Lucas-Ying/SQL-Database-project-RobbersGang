/* Task 3 */
CREATE VIEW Q5Task3 AS
SELECT Security, Skill, NickName
FROM (
	SELECT Security, Description AS Skill, NickName, COUNT(*) AS NoSkills
	FROM Accomplices
	NATURAL JOIN Banks
	NATURAL JOIN HasSkills
	NATURAL JOIN Skills
	NATURAL JOIN Robbers
	GROUP BY Security, Skill, NickName
	ORDER BY NoSkills DESC
) AS Temp;

/* Show result */
SELECT * FROM Q5Task3;