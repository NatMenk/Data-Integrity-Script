//* Requirements
1. Create PRIMARY KEY constraints for all tables in the database: */

USE NarnesAndBobleBooks
GO

ALTER TABLE Books
	ADD CONSTRAINT PK_Books_BookID PRIMARY KEY (BookID)

ALTER TABLE Authors
	ADD CONSTRAINT PK_Authors_AuthorID PRIMARY KEY (AuthorID)

ALTER TABLE Customers
	ADD CONSTRAINT PK_Customers_CustomerID PRIMARY KEY (CustomerID)

ALTER TABLE Publishers
	ADD CONSTRAINT PK_Publishers_PublisherID PRIMARY KEY (PublisherID)

ALTER TABLE BookOrderDetails
	ADD CONSTRAINT PK_BookOrderDetails_OrderDetailsID PRIMARY KEY (OrderDetailsID)

ALTER TABLE BookOrders
	ADD CONSTRAINT PK_BookOrders_OrderID PRIMARY KEY (OrderID)

/*2. Create FOREIGN Key constraints between all the tables. They should be defined as follows:*/

ALTER TABLE Books
	ADD CONSTRAINT FK_Book_Publisher FOREIGN KEY (PublisherID)
		REFERENCES Publishers(PublisherID)
ALTER TABLE Books
	ADD CONSTRAINT FK_Book_Author FOREIGN KEY (AuthorID)
		REFERENCES Authors (AuthorID)

ALTER TABLE BookOrderDetails
	ADD CONSTRAINT FK_Book_BookOrderDetails FOREIGN KEY (BookID)
		REFERENCES Books (BookID)

ALTER TABLE BookOrders
	ADD CONSTRAINT FK_Customer_BookOrders FOREIGN KEY (CustomerID)
		REFERENCES Customers (CustomerID)

ALTER TABLE BookOrderDetails
	ADD CONSTRAINT FK_BO_BOD FOREIGN KEY (OrderID)
		REFERENCES BookOrders (OrderID)

/*3. Add the following default constraints to the database:*/

ALTER TABLE Books
	ADD CONSTRAINT DF_Books_BookPrice DEFAULT (0.00) FOR BookPrice,
	    CONSTRAINT DF_Books_QuantityInStock DEFAULT (0) FOR QuantityInStock,  
		CONSTRAINT DF_Books_ReleaseDate DEFAULT (GETDATE()) FOR ReleaseDate

ALTER TABLE Publishers
    ADD CONSTRAINT DF_Publisher_Country DEFAULT ('CAN') FOR PublisherCountry


ALTER TABLE BookOrders
	ADD CONSTRAINT DF_BookOrders_DateofOrder DEFAULT (GETDATE()) FOR DateOfOrder,
	    CONSTRAINT DF_BookOrders_DateofDelivery DEFAULT (DATEADD (DAY, 5, GETDATE())) FOR DateOfDelivery

/*4. Add a UNIQUE constraint to ensure that a book’s ISBN number is always unique. */

ALTER TABLE Books
	ADD CONSTRAINT UQ_Books_ISBN UNIQUE (ISBN)

/*5.  Add a CHECK constraint to the BookOrders table that makes sure the DateOfOrder is not higher than the DateOfDelivery date */

ALTER TABLE BookOrders
	ADD CONSTRAINT CK_BookOrders_DateofOrder  CHECK (DateOfOrder < DATEADD (DAY, 5, GETDATE()))

/*6. Add a CHECK constraint to the Books table to ensure the QuantityInStock field is never less than zero */

ALTER TABLE Books
	ADD CONSTRAINT CK_Books_QuantityInStock  CHECK (QuantityInStock >= 0)