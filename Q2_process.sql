/*insert into banks*/
\copy Banks FROM data/banks_16.data

/*insert into robberis*/
\copy Robberies FROM data/robberies_16.data

/*insert into plans*/
\copy Plans(BankName, City, PlannedDate, NoRobbers) FROM data/plans_16.data

/*insert into robbers*/
\copy Robbers(Nickname, Age, NoYears) FROM data/robbers_16.data

/*create a tempery hasSkills table*/
CREATE TABLE TempHasSkills
(
	Nickname varchar(255) NOT NULL,
	Skill varchar(255) NOT NULL,
	Preference integer NOT NULL,
	Grade varchar(2) NOT NULL,
	primary key (Nickname, Skill)
);

/*insert hasSkills.data into TempHasSkills*/
\copy TempHasSkills FROM data/hasskills_16.data

/*initialise Skills table using TempHasSkills table*/
INSERT INTO Skills (description)
	SELECT DISTINCT Skill
	FROM TempHasSkills;

/*initialise HasSkills table using temp2*/
INSERT INTO HasSkills
	SELECT RobberId, SkillId, Preference, Grade 
	FROM TempHasSkills
	JOIN Robbers ON TempHasSkills.NickName = Robbers.NickName
	JOIN Skills ON TempHasSkills.skill = Skills.description;

/*Drop the three temp tables*/
DROP TABLE TempHasSkills;

/*create a tempery hasAccounts table*/
CREATE TABLE TempHasAccounts
(
	Nickname varchar(255) NOT NULL,
	BankName varchar(255) NOT NULL,
	City varchar(255) NOT NULL,
	primary key (Nickname, BankName, City)
);

/*insert into hasSkills to TempHasSkills*/
\copy TempHasAccounts FROM data/hasaccounts_16.data

/*initialise HasAccounts table using temp*/
INSERT INTO HasAccounts
	SELECT RobberId, BankName, City
	FROM TempHasAccounts
	JOIN Robbers ON TempHasAccounts.NickName = Robbers.NickName;

/*Drop the two temp tables*/
DROP TABLE TempHasAccounts;

/*create a tempery Accomplices table*/
CREATE TABLE TempAccomplices
(
	NickName	varchar(255) NOT NULL,
	BankName	varchar(255) NOT NULL,
	City		varchar(255) NOT NULL,
	RobberyDate	date NOT NULL,
	Share		real,
	primary key (Nickname, BankName, City, RobberyDate)
);

/*insert into hasSkills to TempHasSkills*/
\copy TempAccomplices FROM data/accomplices_16.data

/*Create temp to convert all robber names to ids*/
CREATE TABLE Temp AS
	SELECT RobberID, BankName, City, RobberyDate, Share FROM TempAccomplices JOIN Robbers ON TempAccomplices.Nickname = Robbers.Nickname;

/*initialise Accomplices table using temp*/
INSERT INTO Accomplices
	SELECT * FROM Temp;

/*Drop the two temp tables*/
DROP TABLE Temp;
DROP TABLE TempAccomplices;
