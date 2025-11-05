-- SQL BASIC QUERY 2 --


-- Q1: WRITE A QUERY THAT DISPLAYS THE INVOICE NUMBER,LINE NUMBER , PRODUCT CODE AND LINE TOTAL FOR EVERY INVOICE DETAIL LINE.
SELECT INV_NUMBER AS INVOICE, LINE_NUMBER AS LINE ,P_CODE AS PRODUCT ,LINE_UNITS * LINE_PRICE AS "LINE TOTAL" FROM LINE;

-- Q2: SELECT THE STATE OF VENDOR BUT DISPLAY THE STATE ONLY ONCE.
SELECT DISTINCT(V_STATE) FROM VENDOR;

-- Q3: Write a query to display the author last name, author first name, and book number for each book written by that author.
SELECT AU_LNAME, AU_FNAME, WRITES.BOOK_NUM FROM FACT.AUTHOR JOIN FACT.WRITES ON AUTHOR.AU_ID = WRITES.AU_ID;

-- Q4: Write a query to display the author id, book number, title and year for each book.
SELECT AU_ID, BOOK.BOOK_NUM, BOOK_TITLE, BOOK_YEAR FROM FACT.BOOK JOIN FACT.WRITES ON WRITES.BOOK_NUM =BOOK.BOOK_NUM ;

-- Q5: Write a query to display the author name (last name then first name separated by a comma and space), book title and subject for each book.
SELECT CONCAT(AU_LNAME, ', ',AU_FNAME) AS AUTHOR_NAME, BOOK_TITLE, BOOK_SUBJECT 
FROM FACT.AUTHOR JOIN FACT.WRITES ON  AUTHOR.AU_ID = WRITES.AU_ID
JOIN FACT.BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM;

-- Q6: Write a query to display the checkout number, book number, patron id, checkout date and due date for every checkout that has ever occurred
-- in the system. Sort the results by checkout date in descending order.
SELECT CHECK_NUM,BOOK_NUM, PAT_ID, FORMAT(CHECK_OUT_DATE, 'MMM dd,yyyy') AS "DATE OUT", FORMAT(CHECK_DUE_DATE,'MM/dd/yyyy') AS "DATE DUE" 
FROM FACT.CHECKOUT ORDER BY CHECK_OUT_DATE DESC;

-- Q7: Write a query to display the book title, year, and subject for every book.
-- Sort the results by book subject in ascending order, year in descending order, and then title in ascending order.
SELECT BOOK_TITLE, BOOK_YEAR, BOOK_SUBJECT FROM FACT.BOOK ORDER BY BOOK_SUBJECT ,BOOK_YEAR DESC, BOOK_TITLE ;

-- Q8: Write a query to display the patron id, book number, patron first name and last name, and book title for all currently checked out books.
-- Sort the output by patron last name and book title.
SELECT PATRON.PAT_ID, BOOK_NUM, PAT_FNAME, PAT_LNAME, BOOK_TITLE FROM FACT.BOOK JOIN FACT.PATRON ON BOOK.PAT_ID = PATRON.PAT_ID 
ORDER BY PAT_LNAME, BOOK_TITLE;

-- Q9: Write a query to display the patron id, last name, and book title of all patrons and the books that are currently checked out.
-- Be sure to include patrons that do not currently have a book checked out. Sort the results by patron’s last name in ascending order then by book title.
SELECT PATRON.PAT_ID,PAT_LNAME,BOOK_TITLE  FROM FACT.PATRON LEFT JOIN FACT.BOOK ON PATRON.PAT_ID = BOOK.PAT_ID
ORDER BY PAT_LNAME, BOOK_TITLE;  

-- Q10: Write a query to display the patron’s full name, book title, and check out date of every checkout that has ever been recorded.
-- Include patrons that have never checked out a book. Sort the results by the patron last name, then first name, both in ascending order.

SELECT CONCAT(PAT_LNAME,', ',PAT_FNAME) AS FULL_NAME, BOOK_TITLE ,CHECK_OUT_DATE 
FROM FACT.PATRON LEFT JOIN FACT.CHECKOUT ON CHECKOUT.PAT_ID = PATRON.PAT_ID
LEFT JOIN FACT.BOOK ON CHECKOUT.BOOK_NUM = BOOK.BOOK_NUM ORDER BY PAT_LNAME,PAT_FNAME;

-- Q11: Write a query to display the book number, book title, book subject, and check out date of every checkout of every book in the system.
-- Include books that have never been checked out. Sort the result by the check out date and then the book number.
SELECT BOOK.BOOK_NUM,BOOK_TITLE,BOOK_SUBJECT,FORMAT(CHECK_OUT_DATE,'MMMM dd, yyyy') AS CHECKED_OUT FROM FACT.BOOK LEFT JOIN FACT.CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM
ORDER BY CHECK_OUT_DATE, BOOK_NUM;