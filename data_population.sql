-- data_population.sql
-- Script for inserting test data into the LibTrack database

USE library_db;

-- Insert data into the Authors table (11 authors)
INSERT INTO Authors (FirstName, LastName, Nationality) VALUES
("Chinua", "Achebe", "Nigerian"),
("Chimamanda Ngozi", "Adichie", "Nigerian"),
("Ngugi wa", "Thiong'o", "Kenyan"),
("Wole", "Soyinka", "Nigerian"),
("Nadine", "Gordimer", "South African"),
("Gabriel Garcia", "Marquez", "Colombian"),
("Toni", "Morrison", "American"),
("Virginia", "Woolf", "British"),
("Albert", "Camus", "French"),
("Haruki", "Murakami", "Japanese"),
("Maya", "Angelou", "American");

-- Insert data into the Categories table (10 categories to meet the requirement)
INSERT INTO Categories (CategoryName) VALUES
("Fiction"),
("Dystopian"),
("Magical Realism"),
("Historical"),
("Autobiography"),
("Science Fiction"),
("Fantasy"),
("Thriller"),
("Biography"),
("Poetry");

-- Insert data into the Books table (11 books)
INSERT INTO Books (Title, ISBN, PublicationYear, AuthorID, CategoryID) VALUES
("Things Fall Apart", "9780385474542", 1958, 1, 1), -- Chinua Achebe, Fiction
("Half of a Yellow Sun", "9780307275830", 2006, 2, 1), -- Chimamanda Ngozi Adichie, Fiction
("Weep Not, Child", "9780435908302", 1964, 3, 1), -- Ngugi wa Thiong'o, Fiction
("Death and the King's Horseman", "9780393314211", 1975, 4, 1), -- Wole Soyinka, Fiction
("July's People", "9780140062014", 1981, 5, 2), -- Nadine Gordimer, Dystopian
("One Hundred Years of Solitude", "9780060883287", 1967, 6, 3), -- Gabriel Garcia Marquez, Magical Realism
("Beloved", "9781400033416", 1987, 7, 1), -- Toni Morrison, Fiction
("Mrs Dalloway", "9780156628709", 1925, 8, 1), -- Virginia Woolf, Fiction
("The Stranger", "9780679720201", 1942, 9, 1), -- Albert Camus, Fiction
("Kafka on the Shore", "9781400079278", 2002, 10, 3), -- Haruki Murakami, Magical Realism
("I Know Why the Caged Bird Sings", "9780345514400", 1969, 11, 5); -- Maya Angelou, Autobiography

-- Insert data into the Members table (11 members)
INSERT INTO Members (FullName, Email, RegistrationDate) VALUES
("Alice Dupont", "alice.dupont@example.com", "2023-01-15"),
("Bob Martin", "bob.martin@example.com", "2023-02-20"),
("Claire Dubois", "claire.dubois@example.com", "2023-03-10"),
("David Moreau", "david.moreau@example.com", "2023-04-05"),
("Eve Lefevre", "eve.lefevre@example.com", "2023-05-12"),
("Frank Bernard", "frank.bernard@example.com", "2023-06-18"),
("Grace Thomas", "grace.thomas@example.com", "2023-07-25"),
("Henry Petit", "henry.petit@example.com", "2023-08-01"),
("Ivy Robert", "ivy.robert@example.com", "2023-09-09"),
("Jack Richard", "jack.richard@example.com", "2023-10-14"),
("Karen Durand", "karen.durand@example.com", "2023-11-21");

-- Insert data into the Loans table (12 records)
INSERT INTO Loans (MemberID, BookID, LoanDate, ReturnDate) VALUES
(1, 1, "2023-01-20", "2023-02-01"), -- Alice borrowed Things Fall Apart (returned)
(2, 2, "2023-02-25", NULL),       -- Bob borrowed Half of a Yellow Sun (active)
(3, 3, "2023-03-15", "2023-03-28"), -- Claire borrowed Weep Not, Child (returned)
(4, 4, "2023-04-10", NULL),       -- David borrowed Death and the King's Horseman (active)
(1, 5, "2023-05-01", "2023-05-15"), -- Alice borrowed July's People (returned)
(2, 6, "2023-06-01", NULL),       -- Bob borrowed One Hundred Years of Solitude (active)
(3, 7, "2023-07-01", "2023-07-14"), -- Claire borrowed Beloved (returned)
(4, 8, "2023-08-05", NULL),       -- David borrowed Mrs Dalloway (active)
(5, 9, "2023-09-01", "2023-09-10"), -- Eve borrowed The Stranger (returned)
(1, 10, "2023-10-01", NULL),      -- Alice borrowed Kafka on the Shore (active)
(2, 11, "2023-11-01", NULL),      -- Bob borrowed I Know Why the Caged Bird Sings (active)
(1, 2, "2023-12-01", NULL);      -- Alice borrowed Half of a Yellow Sun (active, 3rd loan for Alice)
