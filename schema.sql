-- schema.sql
-- Script for creating the LibTrack database

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Nationality VARCHAR(100)
);

-- Categories Table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    PublicationYear INT,
    AuthorID INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE RESTRICT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE RESTRICT
);

-- Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE RESTRICT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE RESTRICT,
    CHECK (ReturnDate IS NULL OR ReturnDate > LoanDate) -- Ensures return date is after loan date
);
