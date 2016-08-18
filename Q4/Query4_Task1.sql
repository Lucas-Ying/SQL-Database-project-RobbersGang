/* Task 1 */
SELECT BankName, Security 
FROM Banks 
WHERE City = 'Chicago' AND NoAccounts > 9000;