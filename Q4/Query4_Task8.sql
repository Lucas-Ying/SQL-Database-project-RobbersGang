/* Task 8 */
SELECT RobberID, NickName, Age - NoYears AS NoYearsNotInPrision
FROM Robbers
WHERE NoYears > Age / 2;