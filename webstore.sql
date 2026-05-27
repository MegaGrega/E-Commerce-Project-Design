# CREATE DATABASE webstore;
USE webstore;

CREATE TABLE Category (
	CategoryID INT AUTO_INCREMENT PRIMARY KEY
    # fk ?
);

CREATE TABLE Product (
	ProductID INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (ProductID) REFERENCES Category(CategoryID)
);

CREATE TABLE Inventory (
	InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (InventoryID) REFERENCES Product(ProductID)
);

CREATE TABLE `User` (
	UserID INT AUTO_INCREMENT PRIMARY KEY
    # fk ?
);

CREATE TABLE `Transaction` (
	TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (TransactionID) REFERENCES `User`(UserID)
);

CREATE TABLE TransactionItem (
	RecordID INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (RecordID) REFERENCES Product(ProductID),
    FOREIGN KEY (RecordID) REFERENCES `Transaction`(TransactionID)
);

CREATE TABLE Review (
	ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (ReviewID) REFERENCES `User`(UserID),
    FOREIGN KEY (ReviewID) REFERENCES Product(ProductID)
);

CREATE TABLE GuestUser (
	GuestUserID INT AUTO_INCREMENT PRIMARY KEY
    # fk ?
);

CREATE TABLE RegisteredUser (
	RegisteredUserID INT AUTO_INCREMENT PRIMARY KEY
    # fk ?
);