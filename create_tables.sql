create table Banks
(
	BankName varchar(255),
	City varchar(255),
	NoAccounts integer,
	Security varchar(255),
	primary key (BankName, City),
	constraint 
)

create table Robberies
(
	BankName varchar(255),
	City varchar(255),
	Date date,
	Amount integer,
	primary key (BankName, City, Date),
	foreign key (BankName, City) references Banks(BankName, City)
)

create table Plans
(
	BankName varchar(255),
	City varchar(255),
	NoRobbers integer,
	PlannedDate date,
	primary key (BankName, City, PlannedDate),
	foreign key	(BankName, City) references Banks(BankName, City)
)

create table Robbers
(
	RobberId serial,
	NickName varchar(255),
	Age integer,
	NoYears integer,
	primary key (RobberId)
)

create table Skills
(
	SkillId serial,
	Description varchar(255),
	primary key (SkillId)
)

create table HasSkills
(
	RobberId integer,
	SkillId integer,
	Preference varchar(255),
	Grade varchar(255),
	primary key (RobberId, SkillId),
	foreign key (RobberId) references Robbers(RobberId),
	foreign key (SkillId) references Skills(SkillId)
)

create table HasAccounts
(
	RobberId integer,
	BankName varchar(255),
	City varchar(255),
	foreign key (RobberId) references Robbers(RobberId),
	foreign key (BankName, City) references Banks(BankName, City)
)

create table Accomplices
(
	RobberId integer,
	BankName varchar(255),
	City varchar(255),
	RobberyDate date,
	Share integer,
	foreign key (RobberId) references Robbers(RobberId),
	foreign key (BankName, City) references Banks(BankName, City)
)