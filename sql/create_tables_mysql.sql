DROP TABLE IF EXISTS Membership;
DROP TABLE IF EXISTS Librarian;
DROP TABLE IF EXISTS MembershipType;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS UserCategory;

CREATE TABLE UserCategory (
    Category_ID VARCHAR(10) NOT NULL,
    Category_Name VARCHAR(100) NOT NULL,
    PRIMARY KEY (Category_ID)
);

CREATE TABLE Users (
    User_ID VARCHAR(10) NOT NULL,
    Category_ID VARCHAR(10),
    First_Name VARCHAR(30) NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    Address VARCHAR(200),
    DOB DATE,
    Phone_Number VARCHAR(20),
    PRIMARY KEY (User_ID),

    CONSTRAINT FK_User_Category
    FOREIGN KEY (Category_ID)
        REFERENCES UserCategory(Category_ID)
);

CREATE TABLE MembershipType (
    Type_ID VARCHAR(10) NOT NULL,
    Type_Name VARCHAR(100),
    Price DECIMAL(10,2),
    DurationWeeks INT,
    PRIMARY KEY (Type_ID)
);

CREATE TABLE Librarian (
    Employee_ID VARCHAR(10) NOT NULL,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    Phone_Number VARCHAR(20),
    PRIMARY KEY (Employee_ID)
);

CREATE TABLE Membership (
    Membership_ID VARCHAR(10) NOT NULL,
    User_ID VARCHAR(10) NOT NULL,
    Type_ID VARCHAR(10) NOT NULL,
    Employee_ID VARCHAR(10) NOT NULL,
    Membership_Date DATE,

    PRIMARY KEY (Membership_ID),

    CONSTRAINT FK_Membership_User
    FOREIGN KEY (User_ID)
        REFERENCES Users(User_ID),

    CONSTRAINT FK_Membership_Type
    FOREIGN KEY (Type_ID)
        REFERENCES MembershipType(Type_ID),

    CONSTRAINT FK_Membership_Librarian
    FOREIGN KEY (Employee_ID)
        REFERENCES Librarian(Employee_ID)
);

CREATE INDEX IDX_User_Category
ON Users(Category_ID);

CREATE INDEX IDX_Membership_User
ON Membership(User_ID);

CREATE INDEX IDX_Membership_Type
ON Membership(Type_ID);

CREATE INDEX IDX_Membership_Librarian
ON Membership(Employee_ID);