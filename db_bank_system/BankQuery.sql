-->RELATIONAL DATABASE FOR A SPECIFIC BANK CUSTOMER MANAGEMENT

CREATE TABLE BRANCH(
BranchId int IDENTITY(1,1) PRIMARY KEY,
Branch varchar (8) not null,
AreaCode int not null,
)

INSERT INTO BRANCH(Branch,AreaCode)
VALUES ('MIRPUR',1216),
        ('UTTARA',1230),
        ('GULSHAN',1213),
        ('TEJGAON',1215),
        ('NEW YORK',212),
        ('DELHI',11)
        
SELECT * FROM BRANCH


CREATE TABLE CUSTOMER(
CustomerId int IDENTITY(1,1) PRIMARY KEY,
BranchId int not null FOREIGN KEY REFERENCES BRANCH(BranchId),
LastName varchar(20) not null,
FirstName varchar(20) not null,
DOB DATE NOT NULL,
Phone varchar(11) not null,
Address varchar(200) not null,
)

INSERT INTO CUSTOMER (BranchId,LastName ,FirstName, Address,Phone,DOB) 
VALUES (1,'Khan', 'Rahim', 'Gulshan', '01677515829','1980-5-12'),
       (2,'Rahman', 'Kahim', 'Dhanmondi','01912584949','1995-7-30'),
       (3,'Mehedi', 'Hashim', 'Gulshan', '01816789544','2000-6-6'),
       (4,'Noor', 'Abdun', 'BARIDHARA', '01789799991','1987-01-31'),
       (5,'Sikder', 'Mahima', 'MIRPUR-1',  '01650000000','1990-3-20'),
       (6,'Zaman', 'Rafik', 'MIRPUR-10', '01743382897','1996-12-17'),
       (3,'Hariet', 'Jacob', 'DHANMONDI', '91569329866','2001-1-19'),
       (4,'Parveen', 'Irin', 'BASHUNDHARA', '56238237200','1992-1-1'),
       (6,'Paul', 'Mac', 'Gulshan', '09353213436','1965-12-31'),
       (4,'Pattrick', 'Robert', 'GULISTHAN', '01223355697','1999-4-24'),
       (1,'Khan', 'Asad', 'BARIDHARA', '01454599074','1980-12-19'),
       (2,'Davidson', 'Peter', 'MIRPUR-1', '83245632945','2000-11-23')

SELECT * FROM CUSTOMER
-->DROP TABLE CUSTOMER
-->TRUNCATE TABLE CUSTOMER


CREATE TABLE ACCOUNT(
AccountNumber int IDENTITY(1000,1) PRIMARY KEY,
CustomerId int not null FOREIGN KEY REFERENCES CUSTOMER(CustomerId),
Balance numeric(11,2),
AccountOpen DATE NOT NULL,
AccountClose Date,
)

INSERT INTO ACCOUNT(CustomerId,Balance,AccountOpen)
VALUES (1,4000.00,'2015-01-08'),
       (2,765000.00,'2014-02-01'),
       (3,10000.00,'2018-07-23'),
       (4,20500.50,'2017-04-11'),
       (5,10560.05,'2016-09-09'),
       (6,100500.00,'2016-11-08'),
       (7,45700.60,'2014-03-16'),
       (8,70100.00,'2018-02-15'),
       (9,89000.00,'2012-12-20'),
       (10,500000.50,'2017-05-22'),
       (11,10000.35,'2015-06-27'),
       (12,78900.75,'2013-08-02')

-->drop table ACCOUNT
-->TRUNCATE TABLE ACCOUNT
SELECT * FROM ACCOUNT

CREATE TABLE TRANSACTIONTYPE(
TransactiontypeId int IDENTITY(1,1) PRIMARY KEY,
Transactiontype varchar(20),
)

INSERT INTO TRANSACTIONTYPE(Transactiontype)
values('deposit'),
      ('withdraw')


CREATE TABLE TRANSACTIONS(
TransactionsId int IDENTITY(1,1) PRIMARY KEY,
AccountNumber int not null FOREIGN KEY REFERENCES ACCOUNT(AccountNumber),
TransactiontypeId int not null FOREIGN KEY REFERENCES TRANSACTIONTYPE(TransactiontypeId),
Amount numeric(9,2),
TransactionDate DATE,
)
-->drop table TRANSACTIONS

INSERT INTO TRANSACTIONS(AccountNumber,TransactiontypeId,Amount,TransactionDate)
VALUES (1000,1,4000.00,'2015-01-08'),
       (1001,2,65000.00,'2014-02-01'),
       (1002,2,6000.00,'2018-07-23'),
       (1003,2,2500.50,'2017-04-11'),
       (1004,1,1500.05,'2016-09-09'),
       (1005,1,10500.00,'2016-11-08'),
       (1006,2,5000.60,'2014-03-16'),
       (1007,2,30000.00,'2018-02-15'),
       (1008,1,9000.00,'2012-12-20'),
       (1009,1,50000.50,'2017-05-22'),
       (1010,2,3000.35,'2015-06-27'),
       (1011,1,78900.75,'2013-08-02')
        

-->TRUNCATE TABLE TRANSACTIONS
SELECT * FROM TRANSACTIONS

-->TO UPDATE ACCOUNT AFTER WITHDRAWAL
UPDATE ACCOUNT SET Balance=(Balance-4000.00) WHERE Balance>4000.00 and AccountNumber='1008'

-->TO UPDATE ACCOUNT AFTER DEPOSIT 
UPDATE ACCOUNT SET Balance=(Balance+4000.00) WHERE  AccountNumber='1008'

-->CUSTOMER AND BRANCH DETAILS
SELECT CUSTOMER.CustomerId,LastName,FirstName,DOB,Phone,Address,Branch,AreaCode
FROM BRANCH INNER JOIN CUSTOMER ON BRANCH.BranchId=CUSTOMER.BranchId


-->CUSTOMERS WHOSE AGE GREATER THAN 18
SELECT * FROM CUSTOMER WHERE DATEDIFF(YEAR,DOB,GETDATE())>18

-->CUSTOMER LIST ORDER BY FIRST NAME AND ADDRESS
SELECT * FROM CUSTOMER ORDER BY FirstName,Address


-->TOP 3 RECORDS OF CUSTOMER TABLE
SELECT TOP 3* FROM CUSTOMER 

-->select customer who have opened account on 2015 and have account in mirpur branch
SELECT CUSTOMER.CustomerId,LastName,FirstName,DOB,Phone,Address FROM BRANCH INNER JOIN CUSTOMER ON BRANCH.BranchId=CUSTOMER.BranchId
inner join ACCOUNT on CUSTOMER.CustomerId=ACCOUNT.CustomerId WHERE Branch='MIRPUR' AND AccountOpen IN(SELECT AccountOpen FROM ACCOUNT WHERE (YEAR(AccountOpen)=2015)) 

-->CUSTOMER SEARCH and show balance
SELECT CUSTOMER.CustomerId,BranchId,LastName,FirstName,DOB,Phone,Address,ACCOUNT.AccountNumber,Balance,AccountOpen
 FROM CUSTOMER inner join ACCOUNT on CUSTOMER.CustomerId=ACCOUNT.CustomerId WHERE FirstName LIKE 'J%'
 
-->SHOW CUSTOMERS WHO HAVE ACCOUNT IN UTTARA
SELECT CUSTOMER.CustomerId,LastName,FirstName,DOB,Phone,Address FROM BRANCH INNER JOIN CUSTOMER ON BRANCH.BranchId=CUSTOMER.BranchId WHERE BRANCH='UTTARA'

-->CUSTOMER WHO HAVE ACCOUNT IN DELHI OR BIRTHDAY IN DECEMBER
SELECT CUSTOMER.CustomerId,LastName,FirstName,Phone,Address
FROM BRANCH INNER JOIN CUSTOMER ON BRANCH.BranchId=CUSTOMER.BranchId WHERE Branch='DELHI' OR DOB LIKE '_____12___'

-->NUMBER OF  DISTINCT PLACES
SELECT COUNT(DISTINCT Address) FROM CUSTOMER

--> NUMBER OF CUSTOMER WHO HAVE WITHDRAW MONEY IN 2018
SELECT COUNT(TransactionsId) FROM TRANSACTIONS INNER JOIN TRANSACTIONTYPE ON TRANSACTIONS.TransactiontypeId=TRANSACTIONTYPE.TransactiontypeId
WHERE Transactiontype='WITHDRAW' AND TransactionDate LIKE ('2018%') 

-->SEARCH CUSTOMER BY FIRST NAME OR ADDRESS AND PHONE
SELECT * FROM CUSTOMER WHERE FirstName LIKE 'M%' AND Phone LIKE'09%' OR Address='GULSHAN'

-->CUSTOMER BALANCESHEET 
SELECT ACCOUNT.AccountNumber,CustomerId,Balance,TRANSACTIONS.TransactionDate,Amount,TRANSACTIONTYPE.Transactiontype 
FROM ACCOUNT INNER JOIN TRANSACTIONS ON ACCOUNT.AccountNumber=TRANSACTIONS.AccountNumber 
INNER JOIN TRANSACTIONTYPE ON TRANSACTIONS.TransactionsId=Transactiontype.TransactiontypeId WHERE CustomerId=2  

-->FIRST NAME STARTING WITH A OF CUSTOMER HAVING MAX BALANCE 
SELECT FirstName,MAX(Balance)AS 'MAX BALANCE' FROM CUSTOMER,ACCOUNT 
WHERE CUSTOMER.CustomerId=ACCOUNT.CustomerId GROUP BY FirstName HAVING  FirstName like'A%'


-->CUSTOMER WHO DOES NOT LIVE IN DHANMONDI AND DOB NOT IN 2001
SELECT * FROM CUSTOMER WHERE Address<>'DHANMONDI' 
UNION SELECT * FROM CUSTOMER WHERE DOB NOT LIKE ('2001%')

-->customer number at distinct area
SELECT COUNT(CustomerId) as 'NUMBER OF CUSTOMER',Address FROM CUSTOMER GROUP BY Address

-->CUSTOMERS IN DISTINCT BRANCH
SELECT DISTINCT(BranchId),COUNT(CustomerId)as'NO. OF CUSTOMER IN BRANCH' from CUSTOMER GROUP BY BranchId

-->NAME AND DAY OF DOB FROM CUSTOMER USING SCALAR FUNCTION
SELECT CUSTOMER.CustomerId,UPPER(FirstName)+'   '+LOWER(LastName) as 'NAME',DATEPART(DAY,DOB) AS'DOB', 
LEFT(Branch,3)as 'BRANCH'  FROM CUSTOMER INNER JOIN BRANCH ON CUSTOMER.BranchId=Branch.BranchId


-->customer who have balance more than 9000
SELECT * FROM CUSTOMER WHERE CustomerId>ANY(SELECT CustomerId FROM ACCOUNT WHERE Balance>'9000.00')