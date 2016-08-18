/* Task 6 */
SELECT s.Description, r.RobberID, r.NickName
FROM Skills s
JOIN HasSkills hs on s.SkillID = hs.SkillID
JOIN Robbers r on hs.RobberID = r.RobberID
ORDER BY s.Description, r.RobberID;