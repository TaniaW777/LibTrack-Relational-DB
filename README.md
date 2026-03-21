# LibTrack: High-Integrity Library Management

<div align="center">
  <p><strong>CS27 Final Project | Scenario 4</strong></p>
  <p><i>A technical transition from manual data chaos to a normalized relational architecture.</i></p>
  <br />
</div>

---

## The Engineering Team (Group 1)

| Role              | Name                  |
| :---------------- | :-------------------- |
| <kbd>Project Lead</kbd> | **ZABRE Tania** |
| Database Architect| **ZONGO Aïda**        |
| Database Architect| **SAWADOGO Asseta**   |
| Database Architect| **KINI Jacob**        |
| Database Architect| **ILBOUDO Balkissa**  |
| Database Architect| **YAMEOGO Cedric**    |
| Database Architect| **NASSA Didier**      |

<p align="right">
  <strong>Supervised by:</strong> Instructor Kweyakie Afi Blebo <br>
  <strong>Institution:</strong> Burkina Institute of Technology (BIT)
</p>

---

## Project Vision: "Solving Data Entropy"

> Manual library management often suffers from three critical failures: **redundancy**, **data inconsistency**, and **inefficient retrieval**.
> <br /><br />
> **LibTrack** solves this by imposing a "Single Source of Truth." Our solution ensures that every transaction is validated through strict referential integrity.

---

## Technical Specifications & Key Design Decisions

Our approach to building LibTrack was guided by a rigorous adherence to database normalization principles and thoughtful design choices to ensure data integrity, efficiency, and scalability.

### The Normalization Journey (3NF)

We rigorously decomposed the data structures to achieve **Third Normal Form (3NF)**, systematically addressing common database anomalies:

*   **1NF**: Eliminated repeating groups, ensuring each column contains atomic values.
*   **2NF**: Removed partial functional dependencies, where non-key attributes were dependent on only part of a composite primary key.
*   **3NF**: Eliminated transitive dependencies, preventing non-key attributes from depending on other non-key attributes, thereby mitigating update anomalies.

### Relational Integrity & Constraints

To enforce data consistency and prevent invalid data entries, we implemented robust relational integrity rules:

*   **Referential Integrity**: Ensured through the implementation of `FOREIGN KEY` constraints, with `ON DELETE RESTRICT` to prevent accidental deletion of parent records that have dependent child records.
*   **Validation**: Utilized `UNIQUE` constraints on critical fields such as **ISBN** (for books) and **Email** (for members) to prevent duplicate entries and maintain data uniqueness.

### Key Design Decisions

Several deliberate design choices underpin the robustness and semantic correctness of the LibTrack database:

*   **Surrogate Keys**: `INT AUTO_INCREMENT` primary keys were used for all tables (e.g., `LoanID`, `MemberID`, `BookID`). This approach provides more stable and efficient primary keys compared to natural keys like ISBN or Email, which can be subject to change or complex composite structures.
*   **NULL for ReturnDate**: The `ReturnDate` column in the `Loans` table is explicitly designed to allow `NULL` values. This semantically correct decision indicates that a book has been borrowed but has not yet been returned, providing a clear status for active loans.
*   **UNIQUE on Members.Email**: A `UNIQUE` constraint on the `Email` column in the `Members` table prevents duplicate member registrations, ensuring each member has a distinct identifier within the system.
*   **Loans as a Bridge Table**: The `Loans` table serves as a crucial bridge (or junction) table, resolving the many-to-many (M:N) relationship between `Members` and `Books`. This design transforms a complex relationship into clean, transactional records, facilitating efficient tracking of borrowing activities.
*   **Categories Extracted to 3NF**: The `Categories` table was extracted as a separate entity to achieve 3NF. This eliminates transitive dependencies between `BookID` and `CategoryDescription`, ensuring that category information is managed independently and consistently across all books.

---

## Database Schema and Content

LibTrack is built upon a well-structured relational schema designed to manage library operations efficiently. Below are the details of the tables, sample data, and various data manipulation and query examples.

### Part 2.1 — Tables Created

The database consists of five interconnected tables, each with specific constraints to maintain data integrity:

| Table      | Description                                     | Primary Key |
| :--------- | :---------------------------------------------- | :---------- |
| `Authors`  | Stores information about book authors           | `AuthorID`  |
| `Categories` | Classifies books into different genres          | `CategoryID`|
| `Books`    | Contains details about each book in the library | `BookID`    |
| `Members`  | Manages library member information              | `MemberID`  |
| `Loans`    | Records borrowing transactions for books        | `LoanID`    |

**Detailed Table Structure:**

*   `Authors` — Designed with `NOT NULL` and `AUTO_INCREMENT` for `AuthorID`.
*   `Categories` — Features a `UNIQUE` constraint on `CategoryName` to prevent duplicate categories.
*   `Books` — Includes `FOREIGN KEY` constraints linking to `Authors.AuthorID` and `Categories.CategoryID`.
*   `Members` — Enforces a `UNIQUE` constraint on `Email` for distinct member identification.
*   `Loans` — Contains `FOREIGN KEY` constraints referencing `Books.BookID` and `Members.MemberID`. `ReturnDate` is explicitly designed to allow `NULL` values for active loans.

### Part 2.2 — Sample Data

To provide a realistic and comprehensive demonstration of the database functionality, LibTrack is populated with diverse sample data:

*   **11 Authors** from various African and international literary traditions.
*   **5 Categories** (Fiction, Dystopian, Magical Realism, Historical, Autobiography) to classify books.
*   **11 Books** with realistic ISBN numbers, covering a range of genres and authors.
*   **11 Members** each with unique email addresses, simulating a typical library user base.
*   **12 Loan records**, including both returned books and active loans, to test loan management.

### Part 2.3 — Data Manipulation

The project demonstrates fundamental SQL Data Manipulation Language (DML) operations:

*   **3 UPDATE statements**: Showcasing modifications to member registration dates, loan return dates, and author nationalities.
*   **2 DELETE statements**: Illustrating the removal of a member with no outstanding loans and an old loan record.
*   **1 Referential Integrity Violation Demonstration**: A commented-out example to illustrate how `ON DELETE RESTRICT` prevents invalid data operations.

### Part 2.4 — SELECT Queries

A comprehensive set of `SELECT` queries is provided to demonstrate data retrieval capabilities:

*   **Basic SELECT**: With `WHERE` clauses for filtering, `ORDER BY` for sorting, and `LIMIT` for pagination.
*   **Filtering**: Examples using `BETWEEN`, `LIKE`, and `IN` operators for flexible data selection.
*   **INNER JOIN**: Across 2 tables to combine related data.
*   **LEFT JOIN**: With detailed explanation of its behavior in retrieving all records from the left table.
*   **JOIN across 3 tables**: To retrieve complex, interconnected information.
*   **IS NULL / IS NOT NULL**: For handling and identifying records with missing or present data.

### Part 3 — Aggregate Functions

Advanced analytical capabilities are demonstrated through aggregate functions and grouping:

*   **COUNT, MAX, MIN, AVG**: Examples of common aggregate functions to summarize data.
*   **GROUP BY**: Used with aggregate functions to categorize and summarize data based on specific attributes.
*   **HAVING**: To filter grouped results based on aggregate conditions.
*   **Full Summary Report**: A complex query combining `JOIN`, `GROUP BY`, and `HAVING` to generate insightful management reports.

---

## Deployment & Installation

Setting up the LibTrack database is a straightforward process, designed for quick deployment and testing.

1.  **Initialize**: Execute `schema.sql` to build the table infrastructure. This script creates all necessary tables with their defined columns, primary keys, foreign keys, and constraints.
2.  **Seed**: Run `data_population.sql` to inject 10 realistic records per entity. This populates the database with sample data, allowing immediate testing and demonstration of functionalities.
3.  **Analyze**: Use `queries.sql` to generate management reports. This file contains various `SELECT` queries, including complex ones, to analyze the populated data.

### How to Import the Database (phpMyAdmin)

For users preferring a graphical interface, the database can be easily imported using phpMyAdmin:

1.  Open **phpMyAdmin** in your browser.
2.  Click on the **Import** tab at the top.
3.  Click **Choose File** and select `library_db.sql` (or the combined `schema.sql` and `data_population.sql` if provided as a single dump).
4.  Leave the format as **SQL**.
5.  Click **Go**.
6.  The `library_db` database will be created automatically with all 5 tables and data.

---

## Management Reporting (Complex Query Example)

LibTrack enables powerful management reporting through complex SQL queries. An example demonstrating the retrieval of members who have borrowed more than 3 books is shown below:

```sql
SELECT 
    m.FullName, 
    COUNT(l.LoanID) AS BooksBorrowed
FROM Members m
INNER JOIN Loans l ON m.MemberID = l.MemberID
GROUP BY m.MemberID, m.FullName
HAVING BooksBorrowed > 3
ORDER BY BooksBorrowed DESC;
```

---

## Video Walkthrough

A comprehensive 5–10 minute video demonstration is available on YouTube, providing a visual guide through the LibTrack project:

*   Scenario overview and schema explanation.
*   Live MySQL demo in phpMyAdmin.
*   Walkthrough of at least 3 key queries, highlighting their functionality and results.

> Link: *https://youtu.be/Ud_e9wNkoHY*

---

## Submission

This project is submitted via Microsoft Forms by the Group Leader.

> Form link: https://forms.cloud.microsoft/r/JjA4ZiaS2g

---

<div align="center"> <br /> <sub>© 2026 Burkina Institute of Technology - Engineering Excellence</sub> </div>
