-- queries.sql
-- SQL query script for the LibTrack database

USE library_db;

-- Part 2.3 — Data Manipulation

-- 3 UPDATE statements
-- 1. Update a member's registration date
UPDATE Members
SET RegistrationDate = '2023-01-01'
WHERE MemberID = 1;

-- 2. Mark a loan as returned
UPDATE Loans
SET ReturnDate = '2023-03-05'
WHERE LoanID = 2;

-- 3. Update an author's nationality
UPDATE Authors
SET Nationality = 'South African'
WHERE AuthorID = 1;

-- 2 DELETE statements
-- 1. Delete a member with no active loans (e.g., MemberID 5 has returned their only book)
DELETE FROM Members
WHERE MemberID = 5 AND MemberID NOT IN (SELECT MemberID FROM Loans WHERE ReturnDate IS NULL);

-- 2. Delete an old loan record (e.g., the oldest returned loan)
DELETE FROM Loans
WHERE LoanID = 1;

-- 1 referential integrity violation demonstration (commented out)
-- Attempt to delete an author who has associated books (should fail with ON DELETE RESTRICT)
-- DELETE FROM Authors WHERE AuthorID = 1;

-- Part 2.4 — SELECT Queries

-- Basic SELECT: Retrieve all records from a table
SELECT * FROM Books;

-- Basic SELECT with WHERE, ORDER BY, LIMIT
-- Select book titles published after 2000, sorted by publication year, limited to the first 3
SELECT Title, PublicationYear
FROM Books
WHERE PublicationYear > 2000
ORDER BY PublicationYear ASC
LIMIT 3;

-- BETWEEN, LIKE, IN filters
-- Books published between 1950 and 1970
SELECT Title, PublicationYear
FROM Books
WHERE PublicationYear BETWEEN 1950 AND 1970;

-- Members whose names start with 'A'
SELECT FullName, Email
FROM Members
WHERE FullName LIKE 'A%';

-- Books in 'Fiction' or 'Autobiography' categories
SELECT B.Title, C.CategoryName
FROM Books B
JOIN Categories C ON B.CategoryID = C.CategoryID
WHERE C.CategoryName IN ('Fiction', 'Autobiography');

-- INNER JOIN across 2 tables
-- Titles of books and names of their authors
SELECT B.Title, A.FirstName, A.LastName
FROM Books B
INNER JOIN Authors A ON B.AuthorID = A.AuthorID;

-- LEFT JOIN with explanation
-- All members and the books they have borrowed (including members who have not borrowed anything)
-- Explanation: LEFT JOIN returns all rows from the left table (Members) and matching rows from the right table (Loans).
-- If no match is found, the columns from the right table will be NULL.
SELECT M.FullName, B.Title, L.LoanDate, L.ReturnDate
FROM Members M
LEFT JOIN Loans L ON M.MemberID = L.MemberID
LEFT JOIN Books B ON L.BookID = B.BookID;

-- JOIN across 3 tables
-- Titles of books, their authors, and their categories
SELECT B.Title, A.FirstName, A.LastName, C.CategoryName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
JOIN Categories C ON B.CategoryID = C.CategoryID;

-- IS NULL / IS NOT NULL
-- Currently borrowed books (ReturnDate IS NULL)
SELECT M.FullName, B.Title, L.LoanDate
FROM Loans L
JOIN Members M ON L.MemberID = M.MemberID
JOIN Books B ON L.BookID = B.BookID
WHERE L.ReturnDate IS NULL;

-- Books that have been returned (ReturnDate IS NOT NULL)
SELECT M.FullName, B.Title, L.LoanDate, L.ReturnDate
FROM Loans L
JOIN Members M ON L.MemberID = M.MemberID
JOIN Books B ON L.BookID = B.BookID
WHERE L.ReturnDate IS NOT NULL;

-- Part 3 — Aggregate Functions

-- COUNT, MAX, MIN, AVG
-- Total number of books
SELECT COUNT(*) AS TotalBooks FROM Books;

-- Oldest and newest publication year
SELECT MIN(PublicationYear) AS OldestBook, MAX(PublicationYear) AS NewestBook FROM Books;

-- Average number of days a book is borrowed (for returned books)
SELECT AVG(DATEDIFF(ReturnDate, LoanDate)) AS AvgLoanDurationDays
FROM Loans
WHERE ReturnDate IS NOT NULL;

-- GROUP BY with aggregate functions
-- Number of books per category
SELECT C.CategoryName, COUNT(B.BookID) AS NumberOfBooks
FROM Categories C
LEFT JOIN Books B ON C.CategoryID = B.CategoryID
GROUP BY C.CategoryName;

-- Number of loans per member
SELECT M.FullName, COUNT(L.LoanID) AS NumberOfLoans
FROM Members M
LEFT JOIN Loans L ON M.MemberID = L.MemberID
GROUP BY M.FullName;

-- HAVING to filter grouped results
-- Categories with more than 2 books
SELECT C.CategoryName, COUNT(B.BookID) AS NumberOfBooks
FROM Categories C
JOIN Books B ON C.CategoryID = B.CategoryID
GROUP BY C.CategoryName
HAVING NumberOfBooks > 2;

-- Full summary report combining JOIN + GROUP BY + HAVING (from README)
-- Members who have borrowed more than 3 books
SELECT 
    m.FullName, 
    COUNT(l.LoanID) AS BooksBorrowed
FROM Members m
INNER JOIN Loans l ON m.MemberID = l.MemberID
GROUP BY m.MemberID, m.FullName
HAVING BooksBorrowed > 3
ORDER BY BooksBorrowed DESC;
