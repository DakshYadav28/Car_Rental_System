create database Car_Rental_System;

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL, -- Use a secure hashing method
    PhoneNumber NVARCHAR(15),
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME,
	PaymentDetails NVARCHAR(255)
);

CREATE TABLE Cars (
    CarID INT PRIMARY KEY IDENTITY,
    Make NVARCHAR(50) NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    Year INT,
    Location NVARCHAR(100) NOT NULL,
    PricePerDay DECIMAL(10, 2) NOT NULL,
    AvailabilityStatus NVARCHAR(20) DEFAULT 'Available' -- e.g., 'Available', 'Reserved'
);

CREATE TABLE CarImages (
    ImageID INT PRIMARY KEY IDENTITY,
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    ImageUrl NVARCHAR(255) NOT NULL
);

CREATE TABLE CarSpecifications (
    SpecificationID INT PRIMARY KEY IDENTITY,
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    Specification NVARCHAR(255) NOT NULL
);

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY IDENTITY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    PickupDate DATETIME NOT NULL,
    DropoffDate DATETIME NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Active', -- e.g., 'Active', 'Cancelled', 'Completed'
    TotalPrice DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY,
    ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50), -- e.g., 'Credit Card', 'PayPal'
    PaymentStatus NVARCHAR(20) DEFAULT 'Completed' -- e.g., 'Pending', 'Completed', 'Failed'
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    CarID INT FOREIGN KEY REFERENCES Cars(CarID),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText NVARCHAR(1000),
    ReviewDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Admins (
    AdminID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL, -- Securely hashed
    Role NVARCHAR(50) DEFAULT 'Admin' -- e.g., 'Admin', 'SuperAdmin'
);