CREATE DATABASE IF NOT EXISTS marketplace_db;
USE marketplace_db;

DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS TransactionItem;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS GuestUser;
DROP TABLE IF EXISTS RegisteredUser;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;

-- 1. CATEGORY (Independent table)
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    CONSTRAINT PK_Category PRIMARY KEY (CategoryID)
);

-- 2. PRODUCT (Depends on Category)
CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT,
    CategoryID INT,
    Name VARCHAR(150) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Description TEXT,
    DateAdded DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Product PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) 
        REFERENCES Category(CategoryID) 
        ON DELETE SET NULL
);

-- 3. INVENTORY (Weak entity / Depends on Product)
CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_Inventory PRIMARY KEY (InventoryID),
    CONSTRAINT FK_Inventory_Product FOREIGN KEY (ProductID) 
        REFERENCES Product(ProductID) 
        ON DELETE CASCADE
);

-- 4. USER SUPERTYPE (Independent table)
CREATE TABLE User (
    UserID INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    CONSTRAINT PK_User PRIMARY KEY (UserID)
);

-- 5. REGISTERED USER SUBTYPE (Inherits from User)
CREATE TABLE RegisteredUser (
    RegisteredUserID INT,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CONSTRAINT PK_RegisteredUser PRIMARY KEY (RegisteredUserID),
    CONSTRAINT FK_RegisteredUser_User FOREIGN KEY (RegisteredUserID) 
        REFERENCES User(UserID) 
        ON DELETE CASCADE
);

-- 6. GUEST USER SUBTYPE (Inherits from User)
CREATE TABLE GuestUser (
    GuestUserID INT,
    SessionToken VARCHAR(255) NOT NULL,
    CONSTRAINT PK_GuestUser PRIMARY KEY (GuestUserID),
    CONSTRAINT FK_GuestUser_User FOREIGN KEY (GuestUserID) 
        REFERENCES User(UserID) 
        ON DELETE CASCADE
);

-- 7. TRANSACTION (Depends on User)
CREATE TABLE Transaction (
    TransactionID INT AUTO_INCREMENT,
    UserID INT NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Transaction PRIMARY KEY (TransactionID),
    CONSTRAINT FK_Transaction_User FOREIGN KEY (UserID) 
        REFERENCES User(UserID) 
        ON DELETE RESTRICT
);

-- 8. TRANSACTION ITEM (Junction table linking Transaction and Product)
CREATE TABLE TransactionItem (
    ReceiptID INT AUTO_INCREMENT,
    TransactionID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    PriceAtPurchase DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_TransactionItem PRIMARY KEY (ReceiptID),
    CONSTRAINT FK_TxItem_Transaction FOREIGN KEY (TransactionID) 
        REFERENCES Transaction(TransactionID) 
        ON DELETE CASCADE,
    CONSTRAINT FK_TxItem_Product FOREIGN KEY (ProductID) 
        REFERENCES Product(ProductID) 
        ON DELETE RESTRICT
);

-- 9. REVIEW (Junction table linking User and Product)
CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_Review PRIMARY KEY (ReviewID),
    CONSTRAINT FK_Review_User FOREIGN KEY (UserID) 
        REFERENCES User(UserID) 
        ON DELETE CASCADE,
    CONSTRAINT FK_Review_Product FOREIGN KEY (ProductID) 
        REFERENCES Product(ProductID) 
        ON DELETE CASCADE
);