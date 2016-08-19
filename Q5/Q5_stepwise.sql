/*----------------- Task 1 -----------------*/
CREATE VIEW TempRobbers AS
SELECT RobberID, COUNT(*) AS NoAccomplices, SUM(Share) AS Earnings
FROM Accomplices
GROUP BY RobberID;

CREATE VIEW AvgNoAccomplices AS
SELECT AVG(NoAccomplices) AS Average
FROM TempRobbers;

CREATE VIEW ProcessedRobbers AS
SELECT RobberID, Earnings
FROM TempRobbers
JOIN AvgNoAccomplices ON NoAccomplices > Average;

CREATE VIEW Task1Final AS
SELECT NickName
FROM Robbers
NATURAL JOIN ProcessedRobbers
WHERE NoYears = 0
ORDER BY Earnings DESC;

/* Show result */
SELECT * FROM Task1Final;


/*----------------- Task 2 -----------------*/
CREATE VIEW BankWithRobbery AS
SELECT Security, Amount
FROM Banks
NATURAL JOIN Robberies;

CREATE VIEW Task2Final AS
SELECT Security, COUNT(*) AS NoRobberies, AVG(Amount) AS Average
FROM BankWithRobbery
GROUP BY Security;

/* Show result */
SELECT * FROM Task2Final;


/*----------------- Task 3 -----------------*/
CREATE VIEW Task3Temp1 AS
SELECT Security, Description AS Skill, NickName, COUNT(*) AS NoSkills
FROM Accomplices
NATURAL JOIN Banks
NATURAL JOIN HasSkills
NATURAL JOIN Skills
NATURAL JOIN Robbers
GROUP BY Security, Skill, NickName
ORDER BY NoSkills DESC;

CREATE VIEW Task3Final AS
SELECT Security, Skill, NickName
FROM Task3Temp1;

/* Show result */
SELECT * FROM Task3Final;


/*----------------- Task 4 -----------------*/
CREATE VIEW Robberies2015 AS
SELECT BankName, City
FROM Robberies
WHERE Date > '2014-12-31' AND Date < '2016-1-1';

CREATE VIEW Plans2017 AS
SELECT BankName, City
FROM Plans
WHERE PlannedDate > '2016-12-31' AND PlannedDate < '2018-1-1';

CREATE VIEW NotRobbed AS
SELECT BankName, City, Security
FROM Banks b
WHERE NOT EXISTS (
	SELECT *
	FROM Robberies2015 r
	WHERE b.BankName = r.BankName
	AND b.City = r.City
);

CREATE VIEW InPlan AS
SELECT BankName, City, Security, COUNT(RobberID) AS NoAccounts
FROM NotRobbed nr
NATURAL JOIN HasAccounts
NATURAL JOIN Plans2017
GROUP BY BankName, City, Security
ORDER BY NoAccounts DESC;

CREATE VIEW Task4Final AS
SELECT BankName, City, Security
FROM InPlan;

/* Show result */
SELECT * FROM Task4Final;


/*----------------- Task 5 -----------------*/
CREATE VIEW RobberiesAvg AS
SELECT BankName, City, RobberyDate AS Date, AVG(Share) AS Average
FROM Accomplices
GROUP BY BankName, City, Date
ORDER BY City, Date;

CREATE VIEW Task5Final AS
SELECT City, AVG(Average) AS Average
FROM RobberiesAvg
GROUP BY City;

/* Show result */
SELECT * FROM Task5Final;




















