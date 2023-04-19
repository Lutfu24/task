CREATE DATABASE Store

USE Store

CREATE TABLE Categories(
	Id int primary key identity,
	Name nvarchar(50) NOT NULL UNIQUE
)

CREATE TABLE Products(
	Id int primary key identity,
	ProductCode nvarchar(50) NOT NULL UNIQUE,
	CategoryId int foreign key references Categories(Id)
)

CREATE TABLE Stock(
	Id int primary key identity,
	CreatedDate datetime2 default GETDATE(),
	Count int not null,
	ProductId int foreign key references Products(Id)
)

CREATE TABLE Sizes(
	Id int primary key identity,
	Letter nvarchar(5) NOT NULL,
	Min int NOT NULL,
	Max int NOT NULL
)

ALTER TABLE Stock
DROP COLUMN Size


INSERT INTO Categories
VALUES('T-shirt'),
	('Jeans'),
	('Shoes'),
	('Jacket')


INSERT INTO Products
VALUES('424sfdlj12ads', 2),
	('dals05490fvl434', 3)


INSERT INTO Stock (Count, ProductId)
VALUES(3, 1),
	(1, 2)


CREATE VIEW select_product_info
AS
SELECT p.ProductCode, c.Name, s.CreatedDate, s.Count FROM Products p
join Categories c
ON c.Id = p.CategoryId
join Stock s
ON s.ProductId = p.Id

SELECT * FROM select_product_info

CREATE PROCEDURE dp_check_size_data
AS
BEGIN
	SELECT * FROM select_product_info
END

CREATE FUNCTION ProductCount
BEGIN
	DECLARE result
	SELECT * FROM select_product_info
	WHERE select_product_info.Count = result
	RETURN result
END

CREATE TRIGGER select_info

BEGIN
	SELECT * FROM select_product_info
END