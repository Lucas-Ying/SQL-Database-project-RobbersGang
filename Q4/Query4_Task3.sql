/* Task 3 */
SELECT BankName, City
FROM Banks b
WHERE NOT EXISTS (
	SELECT BankName
	FROM Banks
	WHERE City = 'Chicago' AND b.BankName = BankName
)
ORDER BY NoAccounts;