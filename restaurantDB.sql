DROP DATABASE IF EXISTS RestaurantDB;
CREATE DATABASE RestaurantDB;
USE RestaurantDB;
CREATE TABLE waiter (
  CPR INT NOT NULL PRIMARY KEY,
  email VARCHAR(100),
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL
);
CREATE TABLE position (
  positionID INT NOT NULL PRIMARY KEY,
  position VARCHAR(100) NOT NULL
);
CREATE TABLE `restaurant_table` (
  tableID INT NOT NULL PRIMARY KEY,
  seats INT(2) NOT NULL,
  table_status INT(1),
  positionID INT NOT NULL,
  FOREIGN KEY (positionID) REFERENCES position (positionID)
);
CREATE TABLE table_has_waiter (
  tableID INT NOT NULL,
  CPR INT NOT NULL,
  `date` VARCHAR(50) NOT NULL,
  start_time VARCHAR(10) NOT NULL,
  end_time VARCHAR(10),
  FOREIGN KEY (tableID) REFERENCES restaurant_table (tableID),
  FOREIGN KEY (CPR) REFERENCES waiter (CPR),
  CONSTRAINT PK_table_has_waiter PRIMARY KEY(tableID, CPR)
);
CREATE TABLE menu_item(
  menu_itemID INT NOT NULL PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  photo VARCHAR(500)
);
CREATE TABLE allergy (
  allergyID INT NOT NULL PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  icon VARCHAR(500)
);
CREATE TABLE menu_item_has_allergy(
  menu_itemID INT NOT NULL,
  allergyID INT NOT NULL,
  FOREIGN KEY (menu_itemID) REFERENCES menu_item (menu_itemID),
  FOREIGN KEY (allergyID) REFERENCES allergy(allergyID),
  CONSTRAINT PK_menu_item_has_allergy PRIMARY KEY (menu_itemID, allergyID)
);
CREATE TABLE rank (
  rankID INT NOT NULL PRIMARY KEY,
  rank_name VARCHAR(25)
);
CREATE TABLE `user` (
  userID INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(25) NOT NULL,
  rankID INT NOT NULL,
  FOREIGN KEY (rankID) REFERENCES rank (rankID)
);
CREATE TABLE reservation (
  reservationID INT NOT NULL PRIMARY KEY,
  `date` VARCHAR(100) NOT NULL,
  start_time NUMERIC(10) NOT NULL,
  end_time NUMERIC(10),
  countdown NUMERIC(10),
  reservation_status INT NOT NULL,
  persons INT(3),
  notes VARCHAR(1000),
  userID INT NOT NULL,
  FOREIGN KEY (userID) REFERENCES user (userID)
);
CREATE TABLE table_has_reservation (
  tableID INT NOT NULL,
  reservationID INT NOT NULL,
  FOREIGN KEY (tableID) REFERENCES restaurant_table (tableID),
  FOREIGN KEY (reservationID) REFERENCES reservation (reservationID),
  CONSTRAINT PK_table_has_reservation PRIMARY KEY (tableID, reservationID)
);
CREATE TABLE reservation_has_allergy (
  reservationID INT NOT NULL,
  allergyID INT NOT NULL,
  FOREIGN KEY (reservationID) REFERENCES reservation (reservationID),
  FOREIGN KEY (allergyID) REFERENCES allergy (allergyID),
  CONSTRAINT PK_reservation_has_allergy PRIMARY KEY (reservationID, allergyID)
);
CREATE TABLE reservation_preorder (
  reservationID INT NOT NULL,
  menu_itemID INT NOT NULL,
  FOREIGN KEY (reservationID) REFERENCES reservation (reservationID),
  FOREIGN KEY (menu_itemID) REFERENCES menu_item (menu_itemID),
  CONSTRAINT PK_reservation_preoder PRIMARY KEY (reservationID, menu_itemID)
);