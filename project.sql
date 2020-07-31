DROP TABLE IF EXISTS Authentications;
CREATE TABLE Authentications (
	AuthenticationID SERIAL PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	Username VARCHAR(255) NOT NULL UNIQUE,
	Email VARCHAR(255) NOT NULL UNIQUE,
	Password VARCHAR(255) NOT NULL,
	SALT VARCHAR(255),
	Verification INT DEFAULT 0
);

DROP TABLE IF EXISTS Locations;
CREATE TABLE Locations(
	LocationID SERIAL PRIMARY KEY,
	Campus VARCHAR(255) NOT NULL
);
INSERT INTO locations(campus) VALUES ('University of Washington Tacoma'),('Univeristy of Washington Seattle'),('University of Washington Bothell');

DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments(
	DepartmentID SERIAL PRIMARY KEY,
	DepartmentName VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Locations_Departments;
CREATE TABLE Locations_Departments(
	LocationDepartmentID SERIAL PRIMARY KEY,
	LocationID INT,
	DepartmentID INT,
	FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

DROP TABLE IF EXISTS Instructors;
CREATE TABLE Instructors(
	InstructorID SERIAL PRIMARY KEY,
	InstructorName VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Instructors_Locations_Departments;
CREATE TABLE Instructors_Locations_Departments(
	InstructorLocationDepartmentID SERIAL PRIMARY KEY,
	InstructorID INT,
	LocationDepartmentID INT,
	FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
	FOREIGN KEY (LocationDepartmentID) REFERENCES Locations_Departments(LocationDepartmentID)

);

DROP TABLE IF EXISTS Courses;
CREATE TABLE Courses(
	CourseID SERIAL PRIMARY KEY,
	CourseNumber VARCHAR(50) NOT NULL,
	CourseName VARCHAR(255) NOT NULL,
	DepartmentID INT,	
	FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

DROP TABLE IF EXISTS Topics;
CREATE TABLE Topics(
	TopicID SERIAL PRIMARY KEY,
	CourseID INT,
	Description VARCHAR(255) NOT NULL,
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

DROP TABLE IF EXISTS Difficulties;
CREATE TABLE Difficulties(
	DifficultyID SERIAL PRIMARY KEY,	
	Description VARCHAR(255) NOT NULL
);
INSERT INTO difficulties(description) VALUES ('Easy'),('Moderate'),('Intermediate'),('Difficult'),('Extreme');

DROP TABLE IF EXISTS Types;
CREATE TABLE Types(
	TypeID SERIAL PRIMARY KEY,	
	Description VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Formats;
CREATE TABLE Formats(
	FormatID SERIAL PRIMARY KEY,	
	Description VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS Answers;
CREATE TABLE Answers(
	AnswerID SERIAL PRIMARY KEY,	
	TextAnswer VARCHAR(255) NOT NULL,
	ImageAnswer VARCHAR(255)
);

DROP TABLE IF EXISTS Questions;
CREATE TABLE Questions(
	QuestionID SERIAL PRIMARY KEY,
	TopicID INT,
	DifficultyID INT,
	TypeID INT,
	FormatID INT,
	TextQuestion VARCHAR(255) NOT NULL,
	Draft VARCHAR(255),
	FOREIGN KEY (TopicID) REFERENCES Topics(TopicID),
	FOREIGN KEY (DifficultyID) REFERENCES Difficulties(DifficultyID),
	FOREIGN KEY (TypeID) REFERENCES Types(TypeID),
	FOREIGN KEY (FormatID) REFERENCES Formats(FormatID)
);

DROP TABLE IF EXISTS Answers_Questions;
CREATE TABLE Answers_Questions(
	AnswerQuestionID SERIAL PRIMARY KEY,
	AnswerID INT,
	QuestionID INT,
	FOREIGN KEY (AnswerID) REFERENCES Answers(AnswerID),
	FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);