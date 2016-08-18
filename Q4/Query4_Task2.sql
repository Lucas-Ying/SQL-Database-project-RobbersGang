/* Task 2 */
SELECT DISTINCT BankName
FROM HasAccounts
WHERE HasAccounts.RobberID IN
(SELECT RobberID 
	FROM Robbers
	WHERE NickName = 'Calamity Jane');