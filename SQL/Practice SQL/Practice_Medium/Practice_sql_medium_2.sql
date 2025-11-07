-- PRACTICE SQL 4: 

-- Q1: WRITE A QUERY THAT DISPLAYS THE NUMBER OF CUSTOMERS THAT HAVE A BALANCE OF $0.00.

SELECT COUNT(*) AS CUS_NUMER FROM CUSTOMER WHERE CUS_BALANCE = 0;

-- Q2: WRITE A QUERY THAT DISPLAYS THE LARGEST CUSTOMER BALANCE AND THE AVERAGE CUSTOMER BALANCE.

SELECT FORMAT(MAX(CUS_BALANCE),'C') AS LARGEST_CUS_BALANCE, FORMAT(AVG(CUS_BALANCE), 'C') AS AVG_BALANCE FROM CUSTOMER;

-- Q3: WRITE A QUERY TO DISPLAY HOW MANY DIFFERENT CUSTOMERS HAVE PLACED AN ORDER.

SELECT COUNT(DISTINCT CUS_CODE ) AS "CUSOTMER NUMBER" FROM INVOICE;

-- Q4: WRITE A QUERY THAT DISPLAYS THE CUSTOMER CODE AND THE LAST NAME, AND THE NUMBER OF ORDERS THAT THE CUSTOMER HAS PLACED, FOR CUSTOMERS
-- THAT HAVE PLACED ATLEAST ONE ORDER. SORT THE RESULT BY CUSTOMER CODE.

SELECT I.CUS_CODE ,CUS_LNAME AS "CUSTOMER NAME", COUNT(INV_NUMBER) AS "NUMBER OF ORDERS" FROM INVOICE I JOIN CUSTOMER C ON I.CUS_CODE = C.CUS_CODE 
GROUP BY I.CUS_CODE , CUS_LNAME ORDER BY CUS_CODE;

-- Q5: WRITE A QUERY TO DISPLAY THE CUSTOMER CODE AND THE LAST NAME AND THE NUMBER OF ORDERS THAT THE CUSTOMER HAS PLACED 
-- AND THE CUSTOMER BALANCE. SORT THE RESULT BY CUSTOMER CODE.

SELECT C.CUS_CODE, CUS_LNAME,COUNT(INV_NUMBER) AS "NUMBER OF ORDERS" , CUS_BALANCE FROM CUSTOMER C JOIN INVOICE I ON C.CUS_CODE = I.CUS_CODE
GROUP BY C.CUS_CODE,CUS_LNAME,CUS_BALANCE 
ORDER BY C.CUS_CODE;

-- Q6: WRITE A QUERY TO DISPLAY THE VENDOR CODE VENDOR NAME AND AVERAGE PRICE OF PRODUCT FROM EACH VENDOR. LIMIT THE RESULT TO VENDORS THAT 
-- PROVIDE MORE THAN 1 DISCOUNT GREATOR THAN 0. SORT THE OUTPUT BY THE AVERAGE PRODUCT PRICE IN ASCENDING ORDER.

SELECT V.V_CODE, V_NAME, AVG(P_PRICE) 
FROM VENDOR V 
JOIN PRODUCT P ON V.V_CODE = P.V_CODE 
WHERE P_DISCOUNT != 0 
GROUP BY V.V_CODE, V_NAME 
HAVING COUNT(P_DISCOUNT) > 1 
ORDER BY AVG(P_PRICE);

-- Q7: Write a query to display the number of books that are in the FACT system.

SELECT COUNT(*) FROM FACT.BOOK;

-- Q8: Write a query to display the number of different book subjects in the FACT system.

SELECT BOOK_SUBJECT, COUNT(*) FROM FACT.BOOK GROUP BY BOOK_SUBJECT;

-- Q9: Write a query to display the highest book cost in the system.

SELECT MAX(BOOK_COST) FROM FACT.BOOK;

-- Q10: Write a query to display the number of different patrons that have ever checked out a book.

SELECT COUNT(*) FROM FACT.PATRON WHERE PAT_ID IN (SELECT PAT_ID FROM FACT.CHECKOUT);
-- OR 
SELECT COUNT(DISTINCT PAT_ID) FROM FACT.CHECKOUT;

-- Q11: Write a query to display the subject and the number of books in each subject. Sort the results by book subject.

SELECT BOOK_SUBJECT, COUNT(BOOK_NUM) AS BOOK_QUANTITY FROM FACT.BOOK GROUP BY BOOK_SUBJECT ORDER BY BOOK_SUBJECT;

-- Q12: Write a query to display the author ID and the number of books written by that author. Sort the results in descending order 
-- by the number of books written, then in ascending order by author id.

SELECT A.AU_ID, COUNT(BOOK_NUM) FROM FACT.AUTHOR A JOIN FACT.WRITES W ON A.AU_ID = W.AU_ID GROUP BY A.AU_ID ORDER BY COUNT(BOOK_NUM) DESC ,A.AU_ID ;

-- Q13: Write a query to display the number of checkouts that have occurred in each month. Sort the results by the number of 
-- checkouts in the month in descending order.

SELECT FORMAT(CHECK_OUT_DATE, 'MMMM'), COUNT(*) AS NUMBER_OF_CHECKOUT FROM FACT.CHECKOUT 
GROUP BY FORMAT(CHECK_OUT_DATE, 'MMMM')  ORDER BY COUNT(*) DESC; 

-- Q14: Write a query to display the total value of all books in the library.

SELECT FORMAT(SUM(BOOK_COST), 'C') AS TOTAL_COST FROM FACT.BOOK;

-- Q15: Write a query to display the book number and the number of times each book has been checked out. 
-- Do not include books that have never been checked out. Sort the results by the number of times checked out in descending order,
-- then by book number in ascending order.

SELECT BOOK_NUM , COUNT(BOOK_NUM) FROM FACT.CHECKOUT GROUP BY BOOK_NUM ORDER BY COUNT(BOOK_NUM) DESC , BOOK_NUM ;

-- Q16: Write a query to display the book number, title, patron ID, last name, and patron type for all books currently checked out to a patron. 
-- Sort the results by book title.

SELECT BOOK_NUM, BOOK_TITLE,P.PAT_ID,PAT_LNAME,PAT_TYPE FROM FACT.BOOK B JOIN FACT.PATRON P ON B.PAT_ID = P.PAT_ID ORDER BY BOOK_TITLE;

-- Q17:  Write a query to display the book number, title, and number of times each book has been checked out. 
-- Include books that have never been checked out. Sort the results in descending order by the number times checked out, then by title.

SELECT B.BOOK_NUM, BOOK_TITLE, COUNT(C.BOOK_NUM) AS NUM_CHECK_OUT_TIMES FROM FACT.CHECKOUT C RIGHT JOIN FACT.BOOK B ON C.BOOK_NUM = B.BOOK_NUM 
GROUP BY B.BOOK_NUM, BOOK_TITLE ORDER BY COUNT(C.BOOK_NUM) DESC , BOOK_TITLE ;

-- Q18: Write a query to display the book number, title, and number of times each book has been checked out. Limit the results to books 
-- that have been checked out more than 5 times. Sort the results in descending order by the number of times checked out, and then by title.

SELECT B.BOOK_NUM, BOOK_TITLE, COUNT(C.BOOK_NUM) AS NUM_CHECK_OUT_TIMES FROM FACT.CHECKOUT C RIGHT JOIN FACT.BOOK B ON C.BOOK_NUM = B.BOOK_NUM
GROUP BY B.BOOK_NUM, BOOK_TITLE HAVING COUNT(C.BOOK_NUM) > 5 ORDER BY COUNT(C.BOOK_NUM) DESC , BOOK_TITLE ;

/* 
Q19: Write a query to display the author ID, first name, last name, the number of books written by that author, and the average cost of those books.
Limit the results to include only books that are on the subjects “Cloud” and “Programming”. Also, limit the results to only authors
that have written more than one book in those subjects. Sort the results by the number of books written in descending order and then in
ascending order by average cost, and then in ascending order by author last name.
*/

SELECT  A.AU_ID , AU_FNAME, AU_LNAME, COUNT(W.BOOK_NUM) AS NUMBER_BOOKS, AVG(BOOK_COST) FROM FACT.AUTHOR A 
JOIN FACT.WRITES W ON A.AU_ID = W.AU_ID 
JOIN FACT.BOOK B ON W.BOOK_NUM = B.BOOK_NUM 
WHERE BOOK_SUBJECT IN ('Cloud', 'Programming') 
GROUP BY BOOK_SUBJECT, A.AU_ID , AU_FNAME, AU_LNAME 
HAVING COUNT(W.BOOK_NUM) > 1
ORDER BY COUNT(W.BOOK_NUM) DESC, AVG(BOOK_COST), AU_LNAME;

/*
Q20:  Write a query to display the patron ID, last name, number of times that patron has ever checked out a book, and the number of different books
the patron has ever checked out. For example, if a given patron has checked out the same book twice, that would count as 2 checkouts but only 1 book.
Limit the results to only patrons that have made at least 3 checkouts. Sort the results in descending order by number of books,
then in descending order by number of checkouts, then in ascending order by patron ID.
*/

SELECT P.PAT_ID,PAT_LNAME, COUNT(C.PAT_ID) AS NUMBER_OF_CHECKOUTS, COUNT(DISTINCT BOOK_NUM) AS TYPE_OF_BOOK 
FROM FACT.PATRON P JOIN FACT.CHECKOUT C ON P.PAT_ID = C.PAT_ID
GROUP BY P.PAT_ID, PAT_LNAME
HAVING COUNT(C.PAT_ID) >= 3
ORDER BY COUNT(DISTINCT BOOK_NUM) DESC , COUNT(C.PAT_ID) DESC, P.PAT_ID; 

-- Q21:  Write a query to display the book number, title, and cost of books that cost more than the average book cost. Sort the results by the book title

SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST FROM FACT.BOOK WHERE BOOK_COST > (SELECT AVG(BOOK_COST) FROM FACT.BOOK)
ORDER BY BOOK_TITLE;

-- Q22: Write a query to display the book number, title, and cost of any book that has a cost lower than the cost of the 
-- cheapest book on the subject of Programming.

SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST 
FROM FACT.BOOK 
WHERE BOOK_COST < (SELECT MIN(BOOK_COST) 
				   FROM FACT.BOOK
				   WHERE BOOK_SUBJECT = 'Programming');

-- Q23: Without using any type of JOIN, write a query to display the patron ID, first name and last name of every patron that has 
-- never checked out any book. Sort the results by the patron last name and then first name.

SELECT PAT_ID, PAT_FNAME, PAT_LNAME 
FROM FACT.PATRON 
WHERE PAT_ID NOT IN (SELECT DISTINCT PAT_ID FROM FACT.CHECKOUT)
ORDER BY PAT_LNAME, PAT_FNAME;

-- Q24: Without using any type of JOIN, write a query to display the book number and title of the books that have never been checked out.
-- Sort the results by book title.

SELECT BOOK_NUM, BOOK_TITLE 
FROM FACT.BOOK
WHERE BOOK_NUM NOT IN (SELECT DISTINCT BOOK_NUM FROM FACT.CHECKOUT)
ORDER BY BOOK_TITLE;

-- Q25: Write a query to display the author ID, first and last name for all authors that have never written a book with the subject “Programming”.
-- Sort the results by author last name.

SELECT DISTINCT W.AU_ID, AU_FNAME, AU_LNAME 
FROM FACT.AUTHOR A
JOIN FACT.WRITES W ON A.AU_ID = W.AU_ID
WHERE BOOK_NUM  IN  (SELECT BOOK_NUM FROM FACT.BOOK WHERE BOOK_SUBJECT != 'Programming');

-- Q26: Write a query to display the book number, title, subject, average cost of books within that subject, and the difference 
-- between each book’s cost and the average cost of books in that subject. Sort the results by book title.
 
SELECT BOOK_NUM, BOOK_TITLE, B.BOOK_SUBJECT, FORMAT(BOOK_CAT.AVG_COST, 'C') AS AVG_COST, FORMAT (B.BOOK_COST - BOOK_CAT.AVG_COST, 'C') AS DIFF    
FROM FACT.BOOK B
JOIN (SELECT BOOK_SUBJECT, AVG(BOOK_COST) AS AVG_COST FROM FACT.BOOK  GROUP BY BOOK_SUBJECT) AS BOOK_CAT 
ON B.BOOK_SUBJECT = BOOK_CAT.BOOK_SUBJECT
ORDER BY BOOK_TITLE;

-- Q27: Write a query to display the book number, title, subject, author last name, and the number of books written by that author.
-- Limit the results to books in the “Cloud” subject. Sort the results by book title and then author last name.


SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT, TABLE_A.AU_ID, AU_LNAME, NUM_OF_BOOKS 
FROM (SELECT B.BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT, AU_ID FROM FACT.BOOK B JOIN FACT.WRITES W ON B.BOOK_NUM = W.BOOK_NUM WHERE BOOK_SUBJECT = 'Cloud') AS TABLE_B
JOIN (SELECT W.AU_ID,AU_LNAME, COUNT(BOOK_NUM) AS NUM_OF_BOOKS FROM FACT.AUTHOR A JOIN FACT.WRITES W ON A.AU_ID = W.AU_ID GROUP BY W.AU_ID, AU_LNAME) AS TABLE_A
ON TABLE_B.AU_ID = TABLE_A.AU_ID
ORDER BY BOOK_TITLE, AU_LNAME;



-- Q28:  Write a query to display the lowest average cost of books within a subject and the highest average cost of books within a subject.

SELECT MIN(AVG_COST) AS LOW_AVG, MAX(AVG_COST) AS HIGH_AVG 
FROM (SELECT  AVG(BOOK_COST) AS AVG_COST  FROM FACT.BOOK GROUP BY BOOK_SUBJECT) AS TABLE_1;













