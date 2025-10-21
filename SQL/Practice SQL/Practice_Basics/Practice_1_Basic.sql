CREATE SCHEMA FACT;

GO

SELECT * FROM sys.schemas;

SELECT * INTO STU873DB.FACT.AUTHOR FROM STARTERDB.FACT.AUTHOR;
SELECT * INTO STU873DB.FACT.BOOK FROM STARTERDB.FACT.BOOK;
SELECT * INTO STU873DB.FACT.CHECKOUT FROM STARTERDB.FACT.CHECKOUT;
SELECT * INTO STU873DB.FACT.PATRON FROM STARTERDB.FACT.PATRON;
SELECT * INTO STU873DB.FACT.WRITES FROM STARTERDB.FACT.WRITES;
SELECT * FROM FACT.AUTHOR;
SELECT * FROM FACT.BOOK;
SELECT * FROM FACT.CHECKOUT;
SELECT * FROM FACT.PATRON;
SELECT * FROM FACT.WRITES;

-- Q1: Write a query that displays the book title, cost and year of publication for every book in the system. --
SELECT BOOK_TITLE, BOOK_COST, BOOK_YEAR FROM FACT.BOOK;

-- Q2: Write a query that displays the first and last name of every patron. --
SELECT PAT_FNAME AS "First Name", PAT_LNAME AS "Last Name" FROM FACT.PATRON;

-- Q3: Write a query to display the checkout number, check out date, and due date foR every book that has been checked out. --
SELECT CHECK_NUM, CHECK_OUT_DATE AS "Checked Out", CHECK_DUE_DATE AS "Due Date" FROM FACT.CHECKOUT;

-- Q4: Write a query to display the book number, book title, and year of publication for every book. --
SELECT BOOK_NUM, BOOK_TITLE AS "TITLE", BOOK_YEAR AS "Year Published" FROM FACT.BOOK;

--Q5: Write a query to display the different years that books have been published in Include each year only once. --
SELECT DISTINCT(BOOK_YEAR) FROM FACT.BOOK; 

-- Q6: Write a query to display the different subjects that FACT has books on. Include each subject only once. --
SELECT DISTINCT(BOOK_SUBJECT) FROM FACT.BOOK;

/* Q7: Write a query to display the patron ID, book number, and days kept for each checkout.
 The days kept is the difference from the date on which the book is returned to the date it was checked out. */
SELECT PAT_ID AS PATRON, BOOK_NUM AS BOOK,  DATEDIFF(DAY,CHECK_OUT_DATE, CHECK_IN_DATE) AS "Days Kept" FROM FACT.CHECKOUT;

-- Q8: Write a query to display the book number, title, and cost of each book. --
SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST AS "Replacement Cost" FROM FACT.BOOK;

--Q9: Write a query to display the patron ID, patron full name, and patron type for each patron. --
SELECT PAT_ID, CONCAT(PAT_FNAME,PAT_LNAME) AS "Patron Name", PAT_TYPE FROM FACT.PATRON;

--Q10: Write a query to display the book number, title with year, and subject for each book. --
SELECT BOOK_NUM, CONCAT(BOOK_TITLE, ' (', BOOK_YEAR,')') AS BOOK, BOOK_SUBJECT FROM FACT.BOOK;

--Q11: Write a query to display the months during with a checkout was made. Display each month with a checkout only once. --
SELECT DISTINCT(FORMAT(CHECK_OUT_DATE, 'MMMM')) AS MONTH FROM FACT.CHECKOUT;

/* 
Q12: The library plans to retire all physical book copies by 2030. Write a query to display the book number, the age the book will be in 2030,
and the cost per year for the book each year until 2030. Round the cost per year to 3 decimal places but leave it as a numeric value.
*/
SELECT BOOK_NUM AS book, (2030 - BOOK_YEAR) AS "Age at retirement" ,ROUND( BOOK_COST/ (2030 - BOOK_YEAR),3) AS "Cost per year" FROM FACT.BOOK; 