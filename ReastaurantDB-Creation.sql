
DROP DATABASE IF EXISTS Restaurant;
CREATE DATABASE Restaurant;
USE Restaurant;

CREATE TABLE waiter (
  CPR varchar(12) NOT NULL PRIMARY KEY,
  email varchar(100) ,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  phone varchar(20) NOT NULL
);   

CREATE TABLE allergy (
  allergyID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  icon varchar(500) 
);


CREATE TABLE category (
  categoryID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL
);

CREATE TABLE unit (
  unitID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) 
);

CREATE TABLE ingredient (
  ingredientID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  stock decimal(10,2),
  categoryID int(11),
  unitID int(11),
  FOREIGN KEY (categoryID) REFERENCES category(categoryID),
  FOREIGN KEY (unitID) REFERENCES unit (unitID)
);

CREATE TABLE menu_item (
  menu_itemID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  photo varchar(500) 
);


CREATE TABLE menu_item_has_allergy (
  menu_itemID int(11) NOT NULL,
  allergyID int(11) NOT NULL,
  FOREIGN KEY (menu_itemID) REFERENCES menu_item(menu_itemID),
  FOREIGN KEY (allergyID) REFERENCES allergy (allergyID),
  CONSTRAINT PK_menu_item_has_allergy PRIMARY KEY (menu_itemID, allergyID)
);



CREATE TABLE menu_item_has_ingredient (
  inputID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  menu_itemID int(11) NOT NULL,
  ingredientID int(11) NOT NULL,
  qty int(5) NOT NULL,
  ingredint_unitID int (11) NOT NULL,
  FOREIGN KEY (ingredint_unitID) REFERENCES unit (unitID),
  FOREIGN KEY (menu_itemID) REFERENCES menu_item (menu_itemID),
  FOREIGN KEY (ingredientID) REFERENCES ingredient (ingredientID)
);


CREATE TABLE position (
  positionID int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  position varchar(100) NOT NULL
);

CREATE TABLE rank (
  rankID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  rank_name varchar(25) 
);

CREATE TABLE `user` (
  userID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  email varchar(100) ,
  phone varchar(25) NOT NULL,
  rankID int(11) NOT NULL,
  FOREIGN KEY (rankID) REFERENCES rank (rankID)
);

CREATE TABLE restaurant_table (
  tableID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  seats int(2) NOT NULL,
  table_status int(1) ,
  positionID int(11) NOT NULL,
  FOREIGN KEY (`positionID`) REFERENCES `position` (`positionID`)
);

CREATE TABLE reservation (
  reservationID int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date` date NOT NULL,
  start_time time NOT NULL,
  end_time time ,
  countdown decimal(10,0) ,
  reservation_status int(11) NOT NULL,
  persons int(3) ,
  notes varchar(1000) ,
  userID int(11) NOT NULL,
  FOREIGN KEY (userID) REFERENCES `user` (userID)
);


CREATE TABLE reservation_has_allergy (
  inputID int(11) NOT NULL AUTO_INCREMENT,
  reservationID int(11) NOT NULL,
  allergyID int(11) NOT NULL,
  FOREIGN KEY (reservationID) REFERENCES reservation (reservationID),
  FOREIGN KEY (allergyID) REFERENCES allergy (allergyID),
  CONSTRAINT PK_reservation_has_allergy PRIMARY KEY (inputID,reservationID,allergyID)
);



CREATE TABLE reservation_preorder (
  preorderID int(11) NOT NULL AUTO_INCREMENT,
  reservationID int(11) NOT NULL,
  menu_itemID int(11) NOT NULL,
  FOREIGN KEY (reservationID) REFERENCES reservation (reservationID),
  FOREIGN KEY (menu_itemID) REFERENCES menu_item (menu_itemID),
  CONSTRAINT PK_reservation_preorder PRIMARY KEY (preorderID, reservationID, menu_itemID)

) ;




CREATE TABLE table_has_reservation (
  linkID int(11) NOT NULL AUTO_INCREMENT,
  tableID int(11) NOT NULL,
  reservationID int(11) NOT NULL,
  FOREIGN KEY (tableID) REFERENCES restaurant_table (tableID),
  FOREIGN KEY (reservationID) REFERENCES reservation (reservationID),
  CONSTRAINT PK_table_has_reservation PRIMARY KEY (linkID ,tableID ,reservationID)
);


CREATE TABLE table_has_waiter (
  shiftID int(11) NOT NULL AUTO_INCREMENT,
  tableID int(11) NOT NULL,
  CPR varchar(12) NOT NULL,
  date date NOT NULL,
  start_time time NOT NULL,
  end_time time,
  FOREIGN KEY (tableID) REFERENCES restaurant_table (tableID),
  FOREIGN KEY (CPR) REFERENCES waiter (CPR),
  CONSTRAINT PK_table_has_waiter PRIMARY KEY (shiftID,tableID,CPR)
);






