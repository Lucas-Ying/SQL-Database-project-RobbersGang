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

CREATE TABLE Robbers
(
	RobberId serial,
	NickName varchar(255) NOT NULL,
	Age integer,
	NoYears integer,
	PRIMARY KEY (RobberId),
	CONSTRAINT non_negative CHECK (Age >= 0),
	CONSTRAINT NYs_not_larger_than_Age CHECK (NoYears <= Age)
);

CREATE TABLE Skills
(
	SkillId serial,
	Description varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (SkillId)
);

CREATE TABLE HasSkills
(
	RobberId integer,
	SkillId integer,
	Preference integer NOT NULL,
	Grade varchar(2) NOT NULL,
	PRIMARY KEY (RobberId, SkillId),
	FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId),
	FOREIGN KEY (SkillId) REFERENCES Skills(SkillId),
	CONSTRAINT preference_range CHECK (Preference >= 1 AND Preference <= 3),
	CONSTRAINT grade_range CHECK (Grade ~ '[A-C][\+\-]?')
);

CREATE TABLE HasAccounts
(
	RobberId integer,
	BankName varchar(255),
	City varchar(255),
	PRIMARY KEY	(RobberID, BankName, City),
	FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId),
	FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City)
);

CREATE TABLE Accomplices
(
	RobberId integer,
	BankName varchar(255),
	City varchar(255),
	RobberyDate date,
	Share numeric,
	PRIMARY KEY	(RobberID, BankName, City, RobberyDate),
	FOREIGN KEY (RobberId) REFERENCES Robbers(RobberId),
	FOREIGN KEY (BankName, City) REFERENCES Banks(BankName, City),
	CONSTRAINT non_negative CHECK (Share >= 0)
);