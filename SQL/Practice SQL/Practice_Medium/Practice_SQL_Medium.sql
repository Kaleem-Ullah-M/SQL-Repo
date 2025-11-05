-- SQL PRACTICE 3 --
--Q1: WRITE THE PRODUCT FULL NAME, ITS PRICE AND THE DATE IT WAS RECIVED INTO INVENTRY.

SELECT CONCAT (P_DESCRIPT, ' (', P_CODE, ').') AS PRODUCT , P_PRICE AS PRICE, P_INDATE AS "RECIEVED DATE" FROM PRODUCT;

--Q2: WRITE INVOICE DATE, INVOICE NUMBER AND PAYMENT DUE DATES FOR ALL INVOICES.

SELECT INV_NUMBER AS "INVOICE NUMBER",INV_DATE AS "INVOICE DATE", DATEADD(DAY,45,INV_DATE) AS "DUE DATE" FROM INVOICE;

--Q3: WRITE THE CUSTOMER NAME ,INVOICE NUMBER AND PURCHASE DATE FOR EVERY INVOICE.

SELECT CONCAT(CUS_FNAME,' ',CUS_LNAME) AS "CUSTOMER NAME", INV_NUMBER AS "INVOICE NUMBER", INV_DATE AS "PURCHASE DATE" FROM CUSTOMER JOIN INVOICE ON 
CUSTOMER.CUS_CODE = INVOICE.CUS_CODE;

--Q4: WRITE THE CUSTOMER FIRST NAME, CUSTOMER LAST NAME AND CUSTOMER BALANCE FOR EACH CUSTOMER THAT HAS PLACED AN ORDER.

SELECT DISTINCT CUS_FNAME, CUS_LNAME, CUS_BALANCE FROM CUSTOMER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE ;

--Q5: WRITE A QUERY THAT DISPLAYS THE CUSTOMER FIRST NAME, CUSTOMER LAST NAME, CUSTOMER BALANCE , CUSTOMER INVOICE, PRODUCT CODE FOR EVERY PURCHASE.
-- INCLUDE CUSTOMERS THAT HAVE NOT PURCHASED ANYTHING. ORDER THE RESULTS BY CUSTOMER LAST NAME, CUSTOMER FIRST NAME , CUSTOMER INVOICE AND PRODUCT CODE.

SELECT CUS_FNAME, CUS_LNAME, CUS_BALANCE ,I.INV_NUMBER, P_CODE FROM LINE AS L 
JOIN INVOICE AS I ON L.INV_NUMBER = I.INV_NUMBER
RIGHT JOIN CUSTOMER AS C ON I.CUS_CODE = C.CUS_CODE
ORDER BY CUS_LNAME, CUS_FNAME, INV_NUMBER, P_CODE;

--Q6: Write a query to display the book number, title, and year for all books published in 2025.

SELECT BOOK_NUM,BOOK_TITLE, BOOK_YEAR FROM FACT.BOOK WHERE BOOK_YEAR = 2025;

--Q7: Write a query to display the book number, title and cost for all books in the “Database” subject.

SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST FROM FACT.BOOK WHERE BOOK_SUBJECT LIKE 'Database';

--Q8: Write a query to display the checkout number, book number, book title, and checkout date of all books checked out before April 8, 2025.

SELECT CHECK_NUM, B.BOOK_NUM, BOOK_TITLE, CHECK_OUT_DATE FROM FACT.BOOK AS B 
JOIN FACT.CHECKOUT AS C ON B.BOOK_NUM = C.BOOK_NUM  WHERE CHECK_OUT_DATE < '2025-04-08' ;

--Q9: Write a query to display the book number, title, year, and author last name of all books published after 2025 and on the subject of “Programming”.

SELECT B.BOOK_NUM, BOOK_TITLE, BOOK_YEAR, AU_LNAME FROM FACT.BOOK AS B 
JOIN FACT.WRITES AS W ON B.BOOK_NUM = W.BOOK_NUM 
JOIN FACT.AUTHOR AS A ON W.AU_ID = A.AU_ID WHERE BOOK_YEAR > 2025 AND BOOK_SUBJECT = 'Programming';

--Q10: Write a query to display the book number, title, subject, and cost for all books that are on the subjects of “Middleware” or “Cloud”,
-- and that cost more than $70.

SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT , BOOK_COST FROM FACT.BOOK WHERE BOOK_SUBJECT IN ('Middleware','Cloud') AND BOOK_COST > 70;

--Q11: Write a query to display the author ID, first name, last name, and year of birth for all authors born in the decade of the 1980.

SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR FROM FACT.AUTHOR WHERE AU_BIRTHYEAR BETWEEN 1980 AND 1990; 

--Q12: Write a query to display the book number, title, and author name (first and last) for all books that contain the word “Database” in the title.
-- Sort the results by book title.

SELECT B.BOOK_NUM, BOOK_TITLE AS TITLE, CONCAT(AU_FNAME, AU_LNAME) AS "AUTHOR NAME" FROM FACT.AUTHOR AS A 
JOIN FACT.WRITES AS W ON A.AU_ID = W.AU_ID JOIN FACT.BOOK AS B ON W.BOOK_NUM = B.BOOK_NUM WHERE BOOK_TITLE LIKE '%Database%';

--Q13: Write a query to display the patron ID, patron first and last name, and check out date for all patrons that are students,
-- including students that have never checked out a book. (73 rows)

SELECT P.PAT_ID, PAT_FNAME, PAT_LNAME, CHECK_OUT_DATE FROM FACT.PATRON AS P 
LEFT JOIN FACT.CHECKOUT AS C ON P.PAT_ID = C.PAT_ID WHERE PAT_TYPE LIKE 'Student';  

--Q14: Write a query to display the patron ID, first and last name, and patron type for all patrons whose last name begins with the letter “C”.
-- Sort the results by patron type, last name, and then first name.

SELECT * FROM FACT.PATRON WHERE PAT_LNAME LIKE'C%' ORDER BY PAT_TYPE, PAT_LNAME, PAT_FNAME;

--Q15:  Write a query to display the author ID, first and last name of all authors whose year of birth is unknown.

SELECT AU_ID, AU_FNAME, AU_LNAME FROM FACT.AUTHOR WHERE AU_BIRTHYEAR IS NULL;

--Q16:  Write a query to display the author ID, first and last name of all authors whose year of birth is known.
-- Sort the results by author last name and then by first name.

SELECT AU_ID, AU_FNAME, AU_LNAME FROM FACT.AUTHOR WHERE AU_BIRTHYEAR IS NOT NULL ORDER BY AU_LNAME, AU_FNAME;

--Q17:  Write a query to display the checkout number, book number, patron ID, check out date, 
-- and due date for all checkouts that have not been returned yet. Sort the results by book number.

SELECT CHECK_NUM, B.BOOK_NUM, B.PAT_ID , CHECK_OUT_DATE, CHECK_DUE_DATE FROM FACT.BOOK AS B JOIN FACT.CHECKOUT AS C ON B.BOOK_NUM = C.BOOK_NUM
WHERE CHECK_IN_DATE IS NULL;

--Q18: Write a query to display the author ID, first name, last name, and year of birth for all authors whose last name starts with either “B” or “D”.
-- Also limit the results to authors born before 1980. Sort the results in descending order by year of birth, and then in ascending order by last name.

SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR FROM FACT.AUTHOR WHERE (AU_LNAME LIKE 'B%' OR AU_LNAME LIKE 'D%') AND AU_BIRTHYEAR < 1980
ORDER BY  AU_BIRTHYEAR DESC, AU_LNAME;

/* Q19: Write a query to display the patron ID, full name (first and last), patron type,
book title, book subject, and book cost for checkouts. Limit the results to:
• faculty that checked out books in the “Database” subject
• students that checked out either books in the “Middleware” subject or that
cost more than $80
Sort the results by patron type, then by last name and first name. (13 rows) */

SELECT P.PAT_ID, CONCAT(PAT_FNAME,PAT_LNAME) AS "FULL NAME", PAT_TYPE, BOOK_TITLE, BOOK_SUBJECT, BOOK_COST FROM FACT.PATRON AS P 
LEFT JOIN FACT.CHECKOUT AS C ON P.PAT_ID = C.PAT_ID 
LEFT JOIN FACT.BOOK AS B ON C.BOOK_NUM = B.BOOK_NUM
WHERE (PAT_TYPE = 'FACULTY' AND BOOK_SUBJECT = 'DATABASE')
OR (PAT_TYPE = 'STUDENT' AND BOOK_SUBJECT = 'MIDDLEWARE' OR BOOK_COST > 80)
ORDER BY PAT_TYPE, PAT_LNAME,PAT_FNAME;

--Q20: Write a query to display the author ID, first and last name, book number, and book title of all books in the subject “Cloud”.
-- Sort the results by book title and then by author last name.

SELECT A.AU_ID, AU_FNAME,AU_LNAME, B.BOOK_NUM, BOOK_TITLE FROM FACT.AUTHOR AS A 
JOIN FACT.WRITES AS W ON A.AU_ID = W.AU_ID 
JOIN FACT.BOOK AS B ON W.BOOK_NUM = B.BOOK_NUM
WHERE BOOK_SUBJECT = 'CLOUD' ORDER BY BOOK_TITLE , AU_LNAME;

--Q21: Write a query to display the author ID, author last name, book title, checkout date, and patron last name
-- for all the books written by authors with the last name “Bruer” that have ever been checked out by patrons with the last name “Miles”.

SELECT AUTHOR.AU_ID, AU_LNAME, BOOK_TITLE, CHECK_OUT_DATE, PAT_LNAME FROM FACT.AUTHOR 
JOIN FACT.WRITES ON AUTHOR.AU_ID = WRITES.AU_ID 
JOIN FACT.BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM 
JOIN FACT.CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM
JOIN FACT.PATRON ON PATRON.PAT_ID =CHECKOUT.PAT_ID
WHERE AU_LNAME = 'BRUER' AND PAT_LNAME = 'MILES';


--Q22: Write a query to display the patron ID, first and last name of all patrons that have never checked out any book.
-- Sort the result by patron’s last name then first name. (27 rows)

SELECT PATRON.PAT_ID,PAT_FNAME, PAT_LNAME FROM FACT.PATRON 
LEFT JOIN FACT.CHECKOUT ON PATRON.PAT_ID = CHECKOUT.PAT_ID 
WHERE CHECKOUT.PAT_ID IS NULL
ORDER BY PAT_LNAME, PAT_FNAME;

--Q23: Write a query to display the book number and title of books that have never been checked out by any patron. Sort the results by book title.

SELECT BOOK.BOOK_NUM, BOOK_TITLE FROM FACT.BOOK LEFT JOIN FACT.CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM WHERE CHECKOUT.BOOK_NUM IS NULL
ORDER BY BOOK_TITLE;





