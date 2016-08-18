/* Task 1 */
SELECT BankName, Security 
FROM Banks 
WHERE City = 'Chicago' AND NoAccounts > 9000;

/* Task 2 */
SELECT DISTINCT BankName
FROM HasAccounts
WHERE HasAccounts.RobberID IN (
	SELECT RobberID 
	FROM Robbers
	WHERE NickName = 'Calamity Jane'
);

/* Task 3 */
SELECT BankName, City
FROM Banks b
WHERE NOT EXISTS (
	SELECT BankName
	FROM Banks
	WHERE City = 'Chicago' AND b.BankName = BankName
)
ORDER BY NoAccounts;

/* Task 4 */
SELECT BankName, City
FROM Robberies
ORDER BY Date
LIMIT 1;

/* Task 5 */
SELECT a.RobberID, NickName, SUM(Share) AS Earnings
FROM Accomplices a
JOIN Robbers r on a.RobberID = r.RobberID
GROUP BY a.RobberID, r.NickName
HAVING SUM(Share) > 30000
ORDER BY Earnings DESC;

/* Task 6 */
SELECT s.Description, r.RobberID, r.NickName
FROM Skills s
JOIN HasSkills hs on s.SkillID = hs.SkillID
JOIN Robbers r on hs.RobberID = r.RobberID
ORDER BY s.Description, r.RobberID;

/* Task 7 */
SELECT RobberID, NickName, NoYears
FROM Robbers
WHERE NoYears > 3;

/* Task 8 */
SELECT RobberID, NickName, Age - NoYears AS NoYearsNotInPrision
FROM Robbers
WHERE NoYears > Age / 2;