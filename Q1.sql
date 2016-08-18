/* Banks */
CREATE TABLE Banks
(
	BankName varchar(255),
	City varchar(255),
	NoAccounts integer NOT NULL,
	Security varchar(255) NOT NULL,
	PRIMARY KEY (BankName, City),
	CONSTRAINT non_negative CHECK (NoAccounts >= 0),
	CONSTRAINT city_range CHECK (City IN ('Chicago', 'Evanston', 'Deerfield')),
	CONSTRAINT security_range CHECK (Security IN ('excellent', 'very good', 'good', 'weak'))
);

/* Robberies */
CREATE TABLE Robberies
(
	BankName varchar(255),
	City varchar(255),
	Date date,
	Amount numeric,
	PRIMARY KEY (BankName, City, Date),
	FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City),
	CONSTRAINT non_negative CHECK (Amount >= 0)
);

/* Plans */
CREATE TABLE Plans
(
	BankName varchar(255),
	City varchar(255),
	NoRobbers integer NOT NULL,
	PlannedDate date,
	PRIMARY KEY (BankName, City, PlannedDate),
	FOREIGN KEY	(BankName, City) REFERENCES Banks(BankName, City),
	CONSTRAINT non_negative CHECK (NoRobbers >= 0)
);

/* Robbers */
CREATE TABLE Robbers
(
	RobberID serial,
	NickName varchar(255) NOT NULL,
	Age integer,
	NoYears integer,
	PRIMARY KEY (RobberID),
	CONSTRAINT non_negative CHECK (Age >= 0 AND NoYears >= 0),
	CONSTRAINT NYs_not_larger_than_Age CHECK (NoYears <= Age)
);

/* Skills */
CREATE TABLE Skills
(
	SkillID serial,
	Description varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (SkillID)
);

/* HasSkills */
CREATE TABLE HasSkills
(
	RobberID integer,
	SkillID integer,
	Preference integer NOT NULL,
	Grade varchar(2) NOT NULL,
	PRIMARY KEY (RobberID, SkillID),
	FOREIGN KEY (RobberID) REFERENCES Robbers(RobberID),
	FOREIGN KEY (SkillID) REFERENCES Skills(SkillID),
	CONSTRAINT preference_range CHECK (Preference >= 1 AND Preference <= 3),
	CONSTRAINT grade_range CHECK (Grade ~ '[A-C][\+\-]?')
);

/* HasAccounts */
CREATE TABLE HasAccounts
(
	RobberID integer,
	BankName varchar(255),
	City varchar(255),
	PRIMARY KEY	(RobberID, BankName, City),
	FOREIGN KEY (RobberID) REFERENCES Robbers(RobberID),
	FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City)
);

/* Accomplices */
CREATE TABLE Accomplices
(
	RobberID integer,
	BankName varchar(255),
	City varchar(255),
	RobberyDate date,
	Share numeric,
	PRIMARY KEY	(RobberID, BankName, City, RobberyDate),
	FOREIGN KEY (RobberID) REFERENCES Robbers(RobberID),
	FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City),
	CONSTRAINT non_negative CHECK (Share >= 0)
);