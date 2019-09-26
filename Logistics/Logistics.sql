/*
INFO 6210 Final Exam
*/

-- ***********************************    set 1,set2    **********************************


-- The DROP DATABASE statement is used to drop the database. IF EXISTS checks whether the database is existing or not
DROP DATABASE IF EXISTS Logistics;

-- Creates a new database Logistics
CREATE DATABASE Logistics;

-- USE selects the database in server
USE Logistics;

-- creating Tables for Database

-- Checking whether table Address exists and dropping it before creating, if exists already
DROP TABLE IF EXISTS `Address`;

-- Creating Table Address with all attributes and their datatypes and any constraints
-- Keys used - Primary Key:AddressID to uniquely identify table
CREATE TABLE `Address` (
`AddressID` int NOT NULL AUTO_INCREMENT,
`Street` varchar(255) default NULL,
`City`varchar(255) default NULL,
`State` varchar(50) DEFAULT NULL,
`Zip` varchar(10) DEFAULT '0',
PRIMARY KEY (`AddressID`)
);

-- shows list of index from table
-- SHOW INDEXES FROM Address;

-- To drop an index 
-- DROP INDEX IX_State ON Address;

-- creating an index on state column of Address table
CREATE INDEX IX_State ON Address(State);


-- Checking whether table Customer exists and dropping it before creating, if exists already
DROP TABLE IF EXISTS `Customer`;

-- Creating Table Customer with all attributes and their datatypes and any constraints
-- Keys used - Primary Key:CustomerID to uniquely identify table ; Foreign Key:AddressID to reference Address table
CREATE TABLE `Customer` (
`CustomerID` int NOT NULL AUTO_INCREMENT,
`CustomerName` varchar(255) NOT NULL DEFAULT '',
`AddressID` int NOT NULL DEFAULT '0',
`PhoneNum` varchar(100) DEFAULT '',
`Email` varchar(255) DEFAULT NULL,
PRIMARY KEY (`CustomerID`),
FOREIGN KEY (`AddressID`) REFERENCES Address(`AddressID`)
);


-- To drop an index 
-- DROP INDEX IX_CustomerName ON Customer;

-- creating an index on CustomerName column of Customer table
CREATE  INDEX IX_CustomerName ON Customer(CustomerName);


-- Checking whether table Driver exists and dropping it before creating, if exists already
DROP TABLE IF EXISTS `Driver`;


-- Creating Table Driver with all attributes and their datatypes and any constraints
-- Keys used - Primary Key:DriverID to uniquely identify table ; Foreign Key:AddressID to reference Address table
CREATE TABLE `Driver` (
  `DriverID` int NOT NULL AUTO_INCREMENT,
  `DriverName` varchar(255) NOT NULL DEFAULT '0',
  `AddressID` int NOT NULL DEFAULT '0',
  `DrivingLicenseNo` varchar(15) DEFAULT NULL,
  `PhoneNum` varchar(100) DEFAULT NULL,
  `EmergencyContactName` varchar(255) DEFAULT NULL,
  `EmergencyContactPhoneNo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DriverID`),
  FOREIGN KEY (`AddressID`) REFERENCES Address(`AddressID`)
);



-- Checking whether table Truck exists and dropping it before creating, if exists already
DROP TABLE IF EXISTS `Truck`;


-- Creating Table Truck with all attributes and their datatypes and any constraints
-- Keys used - Primary Key:TruckID to uniquely identify table 
CREATE TABLE `Truck` (
  `TruckID` int NOT NULL AUTO_INCREMENT,
  `RegistrationNo` varchar(15) DEFAULT NULL,
  `TypeDescription` varchar(255) DEFAULT NULL,
  `YearMade` int DEFAULT NULL,
  PRIMARY KEY (`TruckID`)
  );
  
-- To drop an index 
-- DROP INDEX IX_YearMade ON Truck;

-- creating an index on YearMade column of Truck table
CREATE  INDEX IX_YearMade ON Truck(YearMade);
  
  
-- Checking whether table Booking exists and dropping it before creating, if exists already
DROP TABLE IF EXISTS `Booking`;

-- Creating Table Booking with all attributes and their datatypes and any constraints
-- Keys used - Primary Key:BookingID to uniquely identify table ; Foreign Key:CustomerID,DriverID,TruckID to reference Customer,Driver,Truck tables respectively
CREATE TABLE `Booking` (
  `BookingID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL DEFAULT '0',
  `DriverID` int NOT NULL DEFAULT '0',
  `TruckID` int NOT NULL DEFAULT '0',
  `BookingDate` varchar(255),
  `FromDestination` varchar(255),
  `ToDestination` varchar(255),
  `EstDistanceInMiles` int default NULL,
  `Status` ENUM('Done','Processing') NOT NULL,
  PRIMARY KEY (`BookingID`),
  FOREIGN KEY (`CustomerID`) REFERENCES Customer(`CustomerID`),
  FOREIGN KEY (`DriverID`) REFERENCES Driver(`DriverID`),
  FOREIGN KEY (`TruckID`) REFERENCES Truck(`TruckID`)
) ;


-- To drop an index 
-- DROP INDEX IX_Status ON Booking;

-- creating an index on Status column of Booking table
CREATE  INDEX IX_Status ON Booking(Status);


-- Checking whether table InVoice exists and dropping it before creating, if exists already
DROP TABLE IF EXISTS `InVoice`;


-- Creating Table InVoice with all attributes and their datatypes and any constraints
-- Keys used - Primary Key:InvoiceID to uniquely identify table ; Foreign Key:BookingID to reference Booking table
CREATE TABLE `InVoice` (
  `InvoiceID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int NOT NULL DEFAULT '0',
  `MilesTravelled` int default NULL,
  `BillAmount` int default NULL,
  `Status` ENUM('Paid','Not Paid') NOT NULL,
  PRIMARY KEY (`InvoiceID`),
  FOREIGN KEY (`BookingID`) REFERENCES Booking(`BookingID`)
);


-- To drop an index 
-- DROP INDEX IX_Status_BillAmount ON InVoice;

-- creating a composite index on Status,BillAmount columns of InVoice table. 
-- It first arranges Status in Descending order and then BillAmount in Ascending order.
CREATE  INDEX IX_Status_BillAmount ON InVoice(`Status` DESC, `BillAmount` ASC);



-- Inserting values into tables


-- Inserting values into Address table
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (101,"Ap #293-1520 Aenean Ave","Frankfort","Kentucky","75640");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (102,"4936 Aliquet, Av.","Denver","CO","61423");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (103,"Ap #226-9495 Nunc St.","Birmingham","Alabama","35270");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (104,"Ap #336-1747 Est Street","Springdale","AR","71880");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (105,"8515 Aenean Road","Worcester","Massachusetts","67633");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (106,"P.O. Box 402, 1843 Libero. Street","Naperville","IL","52940");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (107,"P.O. Box 417, 9041 Lobortis, Av.","Columbia","Maryland","14558");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (108,"Ap #718-7355 Hendrerit Rd.","Annapolis","Maryland","34454");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (109,"4292 Montes, Av.","Biloxi","Mississippi","33251");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (110,"4493 Maecenas St.","College","Alaska","99755");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (111,"Ap #287-654 A, Street","Springfield","MO","20612");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (112,"381-3882 Semper Rd.","Cincinnati","OH","92955");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (113,"8204 Mi Rd.","Pocatello","ID","45524");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (114,"P.O. Box 514, 9202 Cursus St.","College","Alaska","99721");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (115,"433-1171 A, Av.","Lincoln","Nebraska","80586");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (116,"Ap #991-4142 Egestas. Avenue","Butte","Montana","42599");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (117,"433-3125 Integer St.","Iowa City","IA","28136");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (118,"232-803 Cursus, Rd.","Boise","Idaho","65878");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (119,"Ap #651-8226 Senectus St.","Duluth","MN","64417");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (120,"2271 Pede. Rd.","Covington","KY","88274");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (121,"9295 Phasellus Ave","Salt Lake City","Utah","34323");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (122,"977-5736 Lectus Av.","Honolulu","Hawaii","15998");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (123,"P.O. Box 346, 687 Auctor St.","Indianapolis","IN","79946");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (124,"3551 Luctus Rd.","Aurora","IL","21193");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (125,"6336 Nam Rd.","San Diego","CA","96312");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (126,"2281 Quam. St.","Austin","Texas","98716");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (127,"652-957 Nec Ave","Austin","Texas","83294");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (128,"446-1825 Libero. St.","Iowa City","IA","67726");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (129,"Ap #942-4910 Mauris Av.","Waterbury","Connecticut","34261");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (130,"3392 Metus. Street","Oklahoma City","OK","66720");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (131,"2750 Vitae Av.","Columbia","MO","84055"),(132,"808-2186 Tristique St.","Biloxi","Mississippi","36940"),(133,"675-7510 Egestas, Av.","West Valley City","UT","74481"),(134,"3501 Ac Street","Chattanooga","Tennessee","49001"),(135,"3960 Eu Street","San Francisco","California","94684"),(136,"P.O. Box 546, 7115 Lectus Road","Rutland","VT","85768"),(137,"200-405 Malesuada Ave","Denver","Colorado","71208"),(138,"P.O. Box 751, 6116 Etiam Rd.","Chandler","Arizona","85974"),(139,"P.O. Box 271, 2076 Varius Ave","Des Moines","Iowa","96366"),(140,"850-5436 A, St.","Owensboro","Kentucky","83392");
INSERT INTO `Address` (`AddressID`,`Street`,`City`,`State`,`Zip`) VALUES (141,"Ap #203-2326 Quisque Road","Cheyenne","Wyoming","31558"),(142,"933-9593 Proin Ave","Indianapolis","IN","45746"),(143,"P.O. Box 868, 3365 Quam Rd.","Missoula","MT","87069"),(144,"P.O. Box 282, 5220 Fermentum Av.","Henderson","NV","84337"),(145,"P.O. Box 409, 4089 Cras Ave","Montgomery","Alabama","35561"),(146,"Ap #657-1208 Lobortis Street","Allentown","Pennsylvania","82247"),(147,"Ap #845-9368 Cum Street","College","Alaska","99534"),(148,"5970 Turpis Rd.","Pike Creek","DE","29639"),(149,"123-2722 Tristique Av.","Portland","OR","18145"),(150,"4500 Leo. St.","Chicago","IL","66370");




-- Inserting values into Customer table
INSERT INTO `Customer` (`CustomerID`,`CustomerName`,`AddressID`,`PhoneNum`,`Email`) 
                        VALUES (1,"Grace",101,"(667) 582-5856","nibh@consectetuereuismod.co.uk");
INSERT INTO `Customer` VALUES (2,"Xander",102,"(170) 359-4138","lorem.auctor@elementum.net");
INSERT INTO `Customer` VALUES (3,"Tyrone",103,"(171) 135-5504","molestie@Donecporttitor.net");
INSERT INTO `Customer` VALUES (4,"Ivana",104,"(347) 970-8654","ante@id.net");
INSERT INTO `Customer` VALUES (5,"May",105,"(449) 999-3283","eget.volutpat.ornare@eratvolutpatNulla.org");
INSERT INTO `Customer` VALUES (6,"Karleigh",106,"(711) 518-9736","eu.ultrices.sit@in.edu");
INSERT INTO `Customer` VALUES (7,"Gwendolyn",107,"(905) 824-6938","velit@Inmi.ca");
INSERT INTO `Customer` VALUES (8,"Lillith",108,"(596) 768-2542","Nulla@quam.co.uk");
INSERT INTO `Customer` VALUES (9,"Darius",109,"(885) 468-5012","Integer@hendreritid.edu");
INSERT INTO `Customer` VALUES (10,"Colin",110,"(590) 252-8086","Donec.tempus@atauctor.com");
INSERT INTO `Customer` VALUES (11,"Merritt",111,"(911) 853-0865","lorem.semper.auctor@malesuadaIntegerid.co.uk");
INSERT INTO `Customer` VALUES (12,"Ivan",112,"(234) 172-1333","dolor@Aliquamadipiscinglobortis.com");
INSERT INTO `Customer` VALUES (13,"Channing",113,"(860) 156-3533","mauris.id@neccursusa.ca");
INSERT INTO `Customer` VALUES (14,"Angela",114,"(327) 264-9086","enim@adipiscing.ca");
INSERT INTO `Customer` VALUES (15,"Whoopi",115,"(936) 691-1464","Lorem.ipsum@libero.ca");
INSERT INTO `Customer` VALUES (16,"Callie",116,"(713) 160-9296","viverra@anteMaecenasmi.co.uk");
INSERT INTO `Customer` VALUES (17,"Hall",117,"(474) 908-6449","vel.est.tempor@elitpellentesquea.edu");
INSERT INTO `Customer` VALUES (18,"Yeo",118,"(728) 799-6173","vitae.posuere.at@enim.edu");
INSERT INTO `Customer` VALUES (19,"Sean",119,"(505) 528-8800","nisi.nibh.lacinia@Phasellus.edu");
INSERT INTO `Customer` VALUES (20,"Indira",120,"(390) 477-7320","tincidunt@gravidanon.com");
INSERT INTO `Customer` VALUES (21,"Alfreda",121,"(970) 477-4399","condimentum.Donec.at@id.net");
INSERT INTO `Customer` VALUES (22,"Nola",122,"(561) 922-2996","Pellentesque@uteros.edu");
INSERT INTO `Customer` VALUES (23,"Josephine",123,"(391) 251-3255","vel.pede.blandit@Integerin.com");
INSERT INTO `Customer` VALUES (24,"Thomas",124,"(948) 993-1095","Class.aptent.taciti@tincidunt.co.uk");
INSERT INTO `Customer` VALUES (25,"Callie",125,"(982) 994-4773","natoque@euismodin.net");
INSERT INTO `Customer` VALUES (26,"Emily",116,"(579) 679-8236","libero@consectetueradipiscing.net");
INSERT INTO `Customer` VALUES (27,"Quinn",107,"(276) 113-7361","mauris.id@metus.org");
INSERT INTO `Customer` VALUES (28,"Simon",118,"(493) 389-8265","sed@Cumsociisnatoque.co.uk");
INSERT INTO `Customer` VALUES (29,"Reagan",109,"(722) 258-5375","magna.tellus.faucibus@Donectemporest.org");
INSERT INTO `Customer` VALUES (30,"Hedy",120,"(467) 171-4051","nisl.arcu@Nullamvelitdui.net");



-- Insering values into Driver table
INSERT INTO `Driver` (`DriverID`,`DriverName`,`AddressID`,`DrivingLicenseNo`,`PhoneNum`,`EmergencyContactName`,`EmergencyContactPhoneNo`) 
                        VALUES (201,"Noelle",131,"ZK685206","(449) 984-9551","Hedda","(452) 346-7806");
INSERT INTO `Driver` VALUES (202,"Pascale",132,"CA706003","(906) 998-3950","Scarlet","(713) 911-8207");
INSERT INTO `Driver` VALUES (203,"Avye",133,"MM629033","(467) 408-7604","Tallulah","(425) 546-5060");
INSERT INTO `Driver` VALUES (204,"Daphne",134,"NA757032","(116) 174-3821","Sade","(628) 752-2235");
INSERT INTO `Driver` VALUES (205,"Bianca",135,"AX546455","(411) 272-9813","Amos","(218) 257-1684");
INSERT INTO `Driver` VALUES (206,"Simon",136,"GR639051","(891) 211-4357","Adam","(560) 222-1171");
INSERT INTO `Driver` VALUES (207,"Rae",137,"VO549205","(271) 265-4620","Shad","(715) 131-9708");
INSERT INTO `Driver` VALUES (208,"Cain",138,"OM200311","(352) 930-7944","Colleen","(265) 843-5293");
INSERT INTO `Driver` VALUES (209,"Reagan",139,"IB020387","(267) 795-8661","Ella","(730) 142-9011");
INSERT INTO `Driver` VALUES (210,"Kibo",140,"LA878642","(483) 915-8524","Len","(737) 938-7831");
INSERT INTO `Driver` VALUES (211,"Evan",141,"FE899029","(851) 806-0095","Emerson","(308) 398-1376");
INSERT INTO `Driver` VALUES (212,"Cathleen",142,"ZK735636","(411) 601-9998","Ignatius","(302) 337-5793");
INSERT INTO `Driver` VALUES (213,"Colt",143,"YW758288","(798) 303-6663","Sandra","(918) 763-2454");
INSERT INTO `Driver` VALUES (214,"Clementine",144,"WB427347","(613) 876-2042","Macy","(330) 983-9416");
INSERT INTO `Driver` VALUES (215,"Marshall",145,"QM768172","(449) 423-3932","Ferris","(564) 983-3719");
INSERT INTO `Driver` VALUES (216,"Denise",146,"EB031849","(303) 102-2640","Cecilia","(140) 127-6371");
INSERT INTO `Driver` VALUES (217,"Justine",147,"MM236627","(887) 201-8804","Jaden","(598) 270-2057");
INSERT INTO `Driver` VALUES (218,"Leilani",149,"MY032193","(847) 713-4620","Isaiah","(735) 497-9516");
INSERT INTO `Driver` VALUES (219,"Jana",148,"NE051394","(688) 526-3222","Hanae","(477) 942-7386");
INSERT INTO `Driver` VALUES (220,"George",150,"KQ423479","(790) 643-0834","Armando","(412) 938-8890");
INSERT INTO `Driver` VALUES (221,"Inga",133,"ZO598771","(244) 202-1177","Melvin","(406) 506-1481");
INSERT INTO `Driver` VALUES (222,"Germaine",139,"UI729396","(885) 926-8123","Charissa","(116) 648-1228");
INSERT INTO `Driver` VALUES (223,"Amelia",129,"CQ771343","(564) 200-5771","Dustin","(663) 770-7813");
INSERT INTO `Driver` VALUES (224,"Jelani",145,"SX059534","(959) 725-2771","Melvin","(111) 611-5038");
INSERT INTO `Driver` VALUES (225,"Martha",133,"YQ541318","(710) 923-2198","Unity","(235) 610-8915");
INSERT INTO `Driver` VALUES (226,"Gareth",126,"ZK654010","(415) 170-1955","Jade","(740) 595-6932");
INSERT INTO `Driver` VALUES (227,"Kaye",127,"YG341148","(108) 920-2915","Ignacia","(929) 528-2428");
INSERT INTO `Driver` VALUES (228,"Glenna",129,"JF330888","(413) 729-0997","Lyle","(897) 317-5379");
INSERT INTO `Driver` VALUES (229,"Wanda",128,"LQ025881","(566) 538-6369","Hall","(996) 563-3858");
INSERT INTO `Driver` VALUES (230,"Ira",130,"JP432946","(755) 416-5274","Vielka","(686) 114-6021");


-- Inserting values into Truck table
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (501,"523537","Specialized Trailer",2006);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (502,"029535","Lowboy Trailer",2003);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (503,"307016","Refrigerated (Reefer) Trailer",2002);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (504,"248862","Dry Van (Enclosed) Trailer",2007);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (505,"366442","Straight Truck",2010);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (506,"518136","Stretch RGN Trailer",2003);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (507,"691119","RGN (Removable Gooseneck) Trailer",2007);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (508,"626075","Refrigerated (Reefer) Trailer",2009);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (509,"330921","Conestoga Trailer",2005);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (510,"681975","Stretch RGN Trailer",2005);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (511,"997900","Stretch RGN Trailer",2006);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (512,"283937","Dry Van (Enclosed) Trailer",2007);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (513,"604209","Flatbed (Flat Bed) Trailer",2004);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (514,"661684","Conestoga Trailer",2010);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (515,"764697","Stretch RGN Trailer",2001);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (516,"114694","Lowboy Trailer",2004);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (517,"342058","Dry Van (Enclosed) Trailer",2007);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (518,"733846","Refrigerated (Reefer) Trailer",2003);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (519,"589502","Specialized Trailer",2003);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (520,"107672","Stretch RGN Trailer",2001);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (521,"642000","Flatbed (Flat Bed) Trailer",2001);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (522,"832004","Specialized Trailer",2007);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (523,"557337","Specialized Trailer",2001);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (524,"870553","Stretch RGN Trailer",2003);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (525,"230525","Conestoga Trailer",2010);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (526,"881562","Stretch RGN Trailer",2005);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (527,"468295","Conestoga Trailer",2009);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (528,"657160","Dry Van (Enclosed) Trailer",2004);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (529,"254314","Dry Van (Enclosed) Trailer",2003);
INSERT INTO `Truck` (`TruckID`,`RegistrationNo`,`TypeDescription`,`YearMade`) VALUES (530,"744380","Refrigerated (Reefer) Trailer",2004);


-- Inserting values into Booking table
INSERT INTO `Booking` (`BookingID`,`CustomerID`,`DriverID`,`TruckID`,`BookingDate`,`FromDestination`,`ToDestination`,`EstDistanceInMiles`,`Status`) 
                         VALUES (401,29,202,508,"2018-03-21 ","Rockingham","Venezia",446,"Done");
INSERT INTO `Booking` VALUES (402,20,212,521,"2018-12-14 ","Dawson Creek","Georgia",500,"Processing");
INSERT INTO `Booking` VALUES (403,18,210,515,"2020-04-03 ","Olinda","Levallois-Perret",198,"Done");
INSERT INTO `Booking` VALUES (404,11,222,526,"2018-07-02 ","Reana del Rojale","Lorient",329,"Processing");
INSERT INTO `Booking` VALUES (405,12,227,504,"2019-05-22 ","Chieti","Nevers",330,"Processing");
INSERT INTO `Booking` VALUES  (406,18,205,519,"2020-03-06 ","Langholm","Albisola Superiore",435,"Processing");
INSERT INTO `Booking` VALUES (407,10,230,508,"2019-01-24 ","Nashville","Hartlepool",397,"Done");
INSERT INTO `Booking` VALUES (408,13,225,525,"2019-03-18 ","Colina","Strathcona County",197,"Done");
INSERT INTO `Booking` VALUES (409,16,228,509,"2018-09-16 ","Marentino","Terrance",369,"Processing");
INSERT INTO `Booking` VALUES (410,4,218,530,"2020-01-26 ","Vanderhoof","Boston",333,"Processing");
INSERT INTO `Booking` VALUES (411,15,215,527,"2019-02-12 ","San Demetrio Corone","Kampenhout",278,"Done");
INSERT INTO `Booking` VALUES (412,18,229,523,"2020-02-06 ","Santarcangelo di Romagna","San Lazzaro di Savena",222,"Processing");
INSERT INTO `Booking` VALUES (413,26,229,513,"2019-09-09 ","Saint-Prime","Ham-sur-Heure-Nalinnes",118,"Processing");
INSERT INTO `Booking` VALUES (414,9,207,503,"2018-04-16 ","Corroy-le-Grand","La Ligua",166,"Processing");
INSERT INTO `Booking` VALUES (415,29,221,502,"2019-03-14 ","Eindhout","Portici",190,"Done");
INSERT INTO `Booking` VALUES (416,7,226,520,"2019-12-07 ","Corswarem","Diepenbeek",104,"Done");
INSERT INTO `Booking` VALUES (417,11,216,517,"2018-06-29 ","Koningshooikt","Lévis",381,"Processing");
INSERT INTO `Booking` VALUES (418,24,207,507,"2019-10-30 ","Wrexham","Codognè",211,"Done");
INSERT INTO `Booking` VALUES (419,12,217,512,"2018-08-02 ","Fontanafredda","Burin",317,"Processing");
INSERT INTO `Booking` VALUES (420,26,228,529,"2019-12-08 ","Borsbeek","Arras",197,"Done");
INSERT INTO `Booking` VALUES (421,2,202,513,"2018-09-10 ","Alto Biobío","Springdale",439,"Processing");
INSERT INTO `Booking` VALUES (422,20,225,518,"2019-12-02 ","Milestone","Butte",151,"Processing");
INSERT INTO `Booking` VALUES (423,1,207,511,"2019-01-14 ","Crescentino","Blankenberge",438,"Done");
INSERT INTO `Booking` VALUES (424,18,207,513,"2019-05-05 ","Dunfermline","Cardedu",438,"Done");
INSERT INTO `Booking` VALUES (425,7,220,504,"2019-10-30 ","Bollnäs","Gonnosfanadiga",489,"Processing");
INSERT INTO `Booking` VALUES (426,15,218,509,"2019-08-13 ","Paularo","Edmonton",488,"Processing");
INSERT INTO `Booking` VALUES (427,24,216,523,"2019-10-31 ","Stoke-on-Trent","Pretoro",161,"Done");
INSERT INTO `Booking` VALUES (428,10,204,509,"2019-01-19 ","Legal","Lions Bay",129,"Processing");
INSERT INTO `Booking` VALUES (429,2,209,504,"2018-12-20 ","Bonnyville","Lauder",321,"Done");
INSERT INTO `Booking` VALUES (430,19,223,521,"2020-01-06 ","Cincinnati","Elversele",436,"Done");



-- Inserting values into Invoice table
INSERT INTO `InVoice` (`InvoiceID`,`BookingID`,`MilesTravelled`,`BillAmount`,`Status`) VALUES (601,401,448,2240,"Paid");
INSERT INTO `InVoice` VALUES (602,402,500,2500,"Not Paid");
INSERT INTO `InVoice` VALUES (603,403,195,975,"Not Paid");
INSERT INTO `InVoice` VALUES (604,404,320,1600,"Paid");
INSERT INTO `InVoice` VALUES (605,405,330,1650,"Not Paid");
INSERT INTO `InVoice` VALUES (606,406,432,2160,"Not Paid");
INSERT INTO `InVoice` VALUES (607,407,398,1990,"Not Paid");
INSERT INTO `InVoice` VALUES (608,408,195,975,"Paid");
INSERT INTO `InVoice` VALUES (609,409,367,1835,"Not Paid");
INSERT INTO `InVoice` VALUES (610,410,333,1665,"Not Paid");
INSERT INTO `InVoice` VALUES (611,411,275,1375,"Paid");
INSERT INTO `InVoice` VALUES (612,412,222,1110,"Not Paid");
INSERT INTO `InVoice` VALUES (613,413,118,590,"Paid");
INSERT INTO `InVoice` VALUES (614,414,160,800,"Not Paid");
INSERT INTO `InVoice` VALUES (615,415,194,970,"Not Paid");
INSERT INTO `InVoice` VALUES (616,416,102,510,"Not Paid");
INSERT INTO `InVoice` VALUES (617,417,380,1900,"Not Paid");
INSERT INTO `InVoice` VALUES (618,418,209,1045,"Not Paid");
INSERT INTO `InVoice` VALUES (619,419,319,1595,"Paid");
INSERT INTO `InVoice` VALUES (620,420,199,995,"Paid");
INSERT INTO `InVoice` VALUES (621,421,440,2200,"Paid");
INSERT INTO `InVoice` VALUES (622,422,151,755,"Paid");
INSERT INTO `InVoice` VALUES (623,423,438,2190,"Paid");
INSERT INTO `InVoice` VALUES (624,424,435,2175,"Paid");
INSERT INTO `InVoice` VALUES (625,425,485,2425,"Not Paid");
INSERT INTO `InVoice` VALUES (626,426,482,2410,"Paid");
INSERT INTO `InVoice` VALUES (627,427,161,805,"Not Paid");
INSERT INTO `InVoice` VALUES (628,428,127,635,"Not Paid");
INSERT INTO `InVoice` VALUES (629,429,323,1615,"Not Paid");
INSERT INTO `InVoice` VALUES (630,430,435,2175,"Not Paid");


select `MilesTravelled`,`BillAmount` from InVoice where invoiceid=623;

UPDATE `InVoice` SET `MilesTravelled`= 435 ,  `BillAmount`=2175 WHERE invoiceID=623;

select `MilesTravelled`,`BillAmount` from InVoice where invoiceid=623;

-- check all the tables

SELECT * FROM Address;

SELECT * FROM Booking;

SELECT * FROM Customer;

SELECT * FROM Driver;

SELECT * FROM InVoice; 

SELECT * FROM Truck;




-- ***********************************    some select statements    **********************************
USE Logistics;

-- Alias
select  TruckID as t_id, -- use as to specify alias
            RegistrationNo as "Registration Number", -- use "" when there is space in alias. otherwise error
            TypeDescription "Descr", -- write alias directly after column name
            YearMade MadeIn -- even without ""
from Truck;


-- WHERE clause
-- Trucks made after year 2004
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where YearMade > 2004;


-- Logic operators in WHERE
 
-- OR
-- trucks made before 2004 or after 2006
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where YearMade < 2004 or YearMade>2006;
 
-- AND
-- trucks made before 2004 or after 2006 and of type Specialized trailer
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where (YearMade < 2004 or YearMade>2006) and TypeDescription='Specialized Trailer';
 
 


-- ***********************************    set 3    **********************************
-- ORDER BY
 
-- ASC: order by bill amount in ascending order 
select  invoiceID as i_id,
            bookingID as b_id,
            MilesTravelled,
            BillAmount,
            `Status`
from InVoice
order by BillAmount asc;
 
-- DESC: order by bill amount in ascending order 
select  invoiceID as i_id,
            bookingID as b_id,
            MilesTravelled,
            BillAmount,
            `Status`
from InVoice
order by BillAmount desc;


-- LIMIT
-- specifying how many rows to return
select  invoiceID as i_id,
            bookingID as b_id,
            MilesTravelled,
            BillAmount,
            `Status`
from InVoice
order by BillAmount desc
limit 10;
 
 
-- GROUP BY
 
-- Number of bookings are there for each status
select  `Status`,
            count(invoiceID) as total_bookings
from InVoice
group by `Status`;
 
 
-- more than one column in groupby
-- -- Number of bookings are there for each status and bill amount
select `Status`,
             BillAmount as bill,
            count(invoiceID) as total_bookings
from InVoice
group by `Status`,bill
order by `status`,bill;
 
 
-- HAVING clause
-- Finding all the bills greater than 1000 and ordering them by status
SELECT invoiceID,
             `Status`,
            BillAmount as bill
from InVoice
having bill > 1000
order by `Status`;

 
-- Finding all the bills greater than 2000 and having bill as 2175 and ordering them by status
-- Using Select – From – Where – Group By – Having - Order By – Limit 
-- without limit
select  `Status`,
           BillAmount as bill
from InVoice
where BillAmount > 2000
group by `Status`, bill
having bill = 2175
order by Status;

-- with limit
select  `Status`,
           BillAmount as bill
from InVoice
where BillAmount > 2000
group by `Status`, bill
having bill = 2175
order by Status
LIMIT 1;

-- ***********************************    set 4    **********************************

-- control flow functions
-- CASE: return the full state name instead of abbreviation in Address table
select addressId,
          state,
          CASE state WHEN  'CA' THEN 'California'
					          WHEN  'IL' THEN 'Illinois'
                              WHEN 'MO' THEN 'Missouri'
                              ELSE state END AS Abbreviation
from Address where state IN ('CA','IL','MO','IA','Texas');



-- IF/ELSE: return the billamounts in high bill and low bill group
select invoiceId,
          BillAmount,
          IF(BillAmount>=1600, "High Bill", "Low Bill") AS "Bill Level"
from Invoice
order by invoiceID;

-- CAST() function
-- coverts BookingDate column into date datatype
select bookingID, CAST(BookingDate AS date) bookdate FROM Booking;

-- String functions
-- REPEAT - to repeat customername 2 times from Customer table
select CustomerID,REPEAT(CustomerName, 2)
from Customer;

-- UPPER - to diaplay customername in uppercase
select CustomerID,
UPPER(CustomerName) AS UppercaseCustomerName
from Customer;

-- Numeric Functions
-- AVG - to return greatest bill amount
select AVG(BillAmount) From InVoice;


-- Date Functions
-- CURDATE - to find the current date of selection
select 
CURDATE() AS dateSelected,
invoiceID, BillAmount
from Invoice
where invoiceid = 613;


-- Aggregate Functions
select count(InVoiceId) From InVoice where `Status`="paid";
select avg(BillAmount) From InVoice;
select sum(BillAmount) From InVoice;
select min(BillAmount) From InVoice;
select max(BillAmount) From InVoice;


-- comparision function
-- BETWEEN
-- trucks made between 2004 and 2006 and of type Stretch RGN trailer
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where (YearMade between 2004 and 2006) and TypeDescription='Stretch RGN Trailer';


-- LIKE
 
-- TypeDescription of truck that starts from S
-- % percent sign for like
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where TypeDescription like "S%";
 
-- _ underscore can also be used
-- trucks made in year that starts with 200
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where YearMade like "200_";
 
 
-- IN
-- get the address rows where states are either IN,IL or CA
select AddressID as ad_id,
           street,
           city,
           state,
           zip
from Address 
where state in ("IN", "IL", "CA");

-- ANY
-- get the customer names of whose status of booking is done
select CustomerId,CustomerName
 from Customer where CustomerID = 
 ANY (select customerid from Booking where `Status`="Done");


-- Not Equal comparision operator
-- Trucks which are not made in 2004
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where YearMade <> 2004;


 
 
-- NOT
-- trucks made between 2004 and 2006 and not of type Stretch RGN trailer
select  TruckID as t_id,
            RegistrationNo as RegNo,
            TypeDescription,
            YearMade
from Truck
where (YearMade between 2004 and 2006) and not TypeDescription='Stretch RGN Trailer';



 
 
-- CONCAT
-- concat two rows from Customer table
select  concat(CustomerID, " _ ", CustomerName) as CustomerCred
from Customer order by CustomerID;


-- ***************************************************    Set 5     **************************************************************


-- INNER JOIN
select  DriverID,
            DriverName,
            d.AddressID as D_add,  
            a.AddressID as A_add,  
            City,
            Zip
from Driver d inner join address a    -- alias names can be used on tables
        on d.AddressID =  a.AddressID;
        
        
-- LEFT OUTER JOIN
select  DriverID,
            DriverName,
            d.AddressID as D_add,  
            a.AddressID as A_add,  
            City,
            Zip
from Driver d left join Address a    
        on d.AddressID =  a.AddressID;
        
        
-- RIGHT OUTER JOIN
select  DriverID,
            DriverName,
            d.AddressID as D_add,  
            a.AddressID as A_add,  
            City,
            Zip
from Driver d right join Address a    
        on d.AddressID =  a.AddressID;
        
        
-- FULL OUTER JOIN
select  DriverID,
            DriverName,
            d.AddressID as D_add,  
            a.AddressID as A_add,  
            City,
            Zip
from Driver d full join Address a    
        on d.AddressID =  a.AddressID;
        

-- CROSS JOIN
select DriverID,
           d.AddressID as D_add,
           a.AddressID as A_add
from Driver d CROSS JOIN Address a;

--   SOME JOIN OPERATIONS ON Logistics Database

-- Total bill amount that is obtaine by bookings which are in 'Done' status
SELECT b.BookingID as b_id, b.`Status`, i.billAmount 
FROM Booking b INNER JOIN InVoice i 
ON b.BookingID = i.BookingID
HAVING b.status = "Done";

--  Miles Travelled by Stretch RGN trailer trucks till now
SELECT b.BookingID,b.TruckID,t.TypeDescription,i.MilesTravelled
FROM ((TRUCK t INNER JOIN Booking b ON b.TruckID=t.TruckID) 
			INNER JOIN InVoice i ON b.BookingID=i.BookingID)
WHERE t.TypeDescription = "Stretch RGN Trailer";



-- ****************************************   Set 6   ************************************

-- No.of bookings done for each truck which is made after 2006
SELECT TruckID,Count(BookingID) FROM Booking WHERE 
TruckID IN (SELECT TruckID FROM TRUCK WHERE YearMade>2006)
GROUP BY TruckID;


-- Driver Name who has driven longes miles
 SELECT DriverName FROM Driver WHERE
 DriverID = (SELECT DriverID FROM Booking WHERE 
 BookingID = (SELECT BookingID FROM InVoice WHERE 
 MilesTravelled = (SELECT MAX(MilesTravelled) FROM InVoice)));

-- Total BillAmount collected from Specialized Trailer trrucks
SELECT SUM(BillAmount) FROM InVoice WHERE 
BookingID IN (SELECT BookingID FROM Booking WHERE 
TruckID IN (SELECT TruckID FROM TRUCK WHERE TypeDescription="Conestoga Trailer"));
 
 -- Customer Name who has made highest bill amount
 SELECT CustomerName FROM Customer WHERE
 CustomerID = (SELECT CustomerID FROM Booking WHERE 
 BookingID = (SELECT BookingID FROM InVoice WHERE 
 BillAmount = (SELECT MAX(BillAmount) FROM InVoice)));
 
 
-- ****************************************** Set 7    ************************************
-- LogisticsAdmin
CREATE USER logisticsAdmin@localhost IDENTIFIED BY 'admin';

GRANT ALL ON Logistics.* TO logisticsAdmin@localhost;

SHOW grants FOR logisticsAdmin@localhost;

DROP USER logisticsAdmin@localhost;

GRANT ALL ON *.* TO logisticsAdmin@localhost;


-- LogisticsDeveloper
CREATE USER logisticsDeveloper@localhost IDENTIFIED BY 'developer';

GRANT INSERT, SELECT, UPDATE, DELETE ON Logistics.* TO  logisticsDeveloper@localhost;

SHOW grants FOR logisticsDeveloper@localhost;

DROP USER logisticsDeveloper@localhost;


-- LogisticsTester
CREATE USER logisticsTester@localhost IDENTIFIED BY 'tester';

GRANT SELECT, UPDATE ON Logistics.* TO  logisticsTester@localhost;

SHOW grants FOR logisticsTester@localhost;

DROP USER logisticsTester@localhost;


-- LogisticsUser
CREATE USER logisticsUser@localhost IDENTIFIED BY 'user';

GRANT SELECT ON Logistics.Booking TO  logisticsUser@localhost;
GRANT SELECT ON Logistics.InVoice TO  logisticsUser@localhost;

SHOW grants FOR logisticsUser@localhost;

REVOKE ALL PRIVILEGES ON Logistics.Booking FROM logisticsUser@localhost;
SHOW grants FOR logisticsUser@localhost;

DROP USER logisticsUser@localhost;




-- ANother Way of creating roles and granting privileges

CREATE ROLE 'admin', 'developer', 'Tester', 'User';
GRANT ALL ON Logistics.* TO admin;
GRANT INSERT, SELECT, UPDATE, DELETE ON Logistics.* TO  developer;
GRANT SELECT, UPDATE ON Logistics.* TO  Tester;
GRANT SELECT ON Logistics.Booking TO  User;
GRANT SELECT ON Logistics.InVoice TO  User;

GRANT admin TO logisticsAdmin@localhost;
GRANT developer TO logisticsDeveloper@localhost;
GRANT Tester TO logisticsTester@localhost;
GRANT User TO logisticsUser@localhost;


--   *************************************************   Set 8    ************************************************

-- Procedure to find no.of bookings based on status
DROP PROCEDURE IF EXISTS proc_bookings;
DELIMITER $$
CREATE PROCEDURE proc_bookings(IN `StatusValue` varchar(255), OUT total INT)
BEGIN
    
	select count(*)  into total from booking
    where `Status`=`StatusValue`;
    
END $$
DELIMITER ;

CALL proc_bookings("Processing",@total);
select @total;


-- Procedure to find  Truck details
DELIMITER $$
DROP PROCEDURE IF EXISTS findTruckDetails $$
CREATE PROCEDURE findTruckDetails(IN id INT, OUT t VARCHAR(20), OUT y INT)
BEGIN
	DECLARE cur CURSOR FOR
    SELECT TypeDescription, YearMade
    FROM Truck
    WHERE TruckID = id;

	DECLARE EXIT HANDLER FOR NOT FOUND
    SELECT 'Sorry; this ID was not found' AS 'Error Message';

	OPEN cur;
	FETCH cur INTO t, y;
	CLOSE cur;
END; $$
DELIMITER ;

CALL findTruckDetails(501,@t,@y); 
select @t,@y;

CALL findTruckDetails(1004,@t,@y); 


-- Procedure to find the state of customer
DROP PROCEDURE IF EXISTS proc_customerState;
DELIMITER $$
CREATE PROCEDURE proc_customerState(IN custID INT, OUT customerState varchar(255))
BEGIN
    
	select state  into customerState from Address
    where AddressID = (select AddressID from Customer where CustomerID = custID);
    
END $$
DELIMITER ;

CALL proc_customerState(24,@customerState);
select @customerState;
           

--   *************************************************   Set 9    ************************************************

-- lock and unlock
LOCK TABLES Truck READ;

select * from Truck;

Truncate Truck;

select * from customer;

UNLOCK TABLES;

-- commit, savepoint, rollback 
SET autocommit = OFF; 

INSERT INTO Truck VALUES(500,"681921","Conestoga Trailer",2007);
COMMIT;

select * from Truck;
------------------
UPDATE Truck SET YearMade=2006 WHERE TruckID=500;
SAVEPOINT A;

select * from Truck;

UPDATE Truck SET YearMade=2005 WHERE TruckID=500;
SAVEPOINT B;

select * from Truck;

UPDATE Truck SET YearMade=2003 WHERE TruckID=500;
SAVEPOINT C;

select * from Truck;
------------------
ROLLBACK TO B;
 
select * from Truck;

ROLLBACK TO A;

select * from Truck;


SET autocommit = ON;


--   *************************************************   Set 10    ************************************************
-- backup table for invoice in which values are inserted through a trigger when any row is deleted from invoice
CREATE TABLE invoice_backup (
  `InvoiceID` int NOT NULL AUTO_INCREMENT,
  `BookingID` int NOT NULL DEFAULT '0',
  `MilesTravelled` int default NULL,
  `BillAmount` int default NULL,
  `Status` ENUM('Paid','Not Paid') NOT NULL,
  PRIMARY KEY (`InvoiceID`),
  FOREIGN KEY (`BookingID`) REFERENCES Booking(`BookingID`)
);

-- Trigger for invoice_backup table on InVoice
DELIMITER $$
CREATE TRIGGER tr_invoice_backup
BEFORE DELETE 
ON InVoice
FOR EACH ROW
BEGIN
	INSERT INTO invoice_backup
    VALUES (OLD.InvoiceID, OLD.BookingID, 
    OLD.MilesTravelled, OLD.BillAmount, OLD.Status);
END;
$$

INSERT INTO InVoice VALUES 
('600','401','448','2240', 'Paid');

DELETE FROM InVoice WHERE InvoiceID=600;

-- SELECT * FROM invoice;
SELECT * FROM invoice_backup;
----------------------
-- log table for customer in which values are inserted through a trigger when any row is updated from customer
CREATE TABLE customer_log (
`CustomerID` int NOT NULL AUTO_INCREMENT,
`CustomerName` varchar(255) NOT NULL DEFAULT '',
`OldAddressID` int NOT NULL DEFAULT '0',
`NewAddressID` int NOT NULL DEFAULT '0',
`PhoneNum` varchar(100) DEFAULT '',
`Email` varchar(255) DEFAULT NULL,
PRIMARY KEY (`CustomerID`),
FOREIGN KEY (`OldAddressID`) REFERENCES Address(`AddressID`),
FOREIGN KEY (`NewAddressID`) REFERENCES Address(`AddressID`)
);
  
-- creating the trigger
DELIMITER $$
CREATE TRIGGER tr_customer_update
	AFTER UPDATE
	ON Customer
	FOR EACH ROW
BEGIN
	INSERT INTO customer_log
    (CustomerID,OldAddressID,NewAddressID)
    VALUES (OLD.CustomerID, OLD.AddressID,
    NEW.AddressID);
END;
$$

-- update Customer table
UPDATE Customer SET AddressID = '148' WHERE CustomerID=1;
-- check Customer table
SELECT * FROM Customer;
-- check customer_log table
SELECT * FROM customer_log;
-------------------
-- estimated bill table for booking in which values are inserted through a trigger when any row is inserted in  booking
CREATE TABLE est_bill(
BookingID INT,
EstDistanceInMiles INT,
EstBillAmount INT,
PRIMARY KEY (BookingID)
);

-- creating the trigger
DELIMITER $$
CREATE TRIGGER tr_estBill_insert
	AFTER INSERT
	ON Booking
	FOR EACH ROW
BEGIN
	INSERT INTO est_bill
    VALUES (NEW.BookingID, NEW.EstDistanceInMiles,
    NEW.EstDistanceInMiles*5);
END;
$$

INSERT INTO Booking VALUES (431,27,214,511,"2018-09-10","MileStone","Pretoro",300,"Processing");

select * from Booking;
select * from est_bill;


--   *************************************************   Set 11    ************************************************

-- This view collects the invoice details for which the bill amount is above the average value.
CREATE VIEW InvoicesAboveAverageBill 
AS
SELECT InVoiceID, BookingID, BillAmount
FROM InVoice
WHERE BillAmount > (SELECT AVG(BillAmount) FROM InVoice);

SELECT * FROM InvoicesAboveAverageBill;

-- This view list the top five customers who make highest bill amounts.
CREATE VIEW TopFiveCustomers
AS
 SELECT Customer.customerName,InVoice.billamount 
 FROM ((Customer 
 JOIN Booking ON Booking.customerID = Customer.customerID)
 JOIN Invoice ON Booking.bookingID = Invoice.BookingID)
 ORDER BY InVoice.BillAmount DESC 
 LIMIT 5;
 
 SELECT * FROM TopFiveCustomers;
 
 
 -- This view finds the error in estimated distance in miles from Booking table and Invoice table
 CREATE VIEW EstimationError
 AS
 SELECT Booking.BookingID, 
                Driver.DriverName,
                Booking.EstDistanceInMiles, 
                InVoice.MilesTravelled, 
                (Booking.EstDistanceInMiles)-(InVoice.MilesTravelled) AS ErrorInEstimation
FROM ((Driver 
JOIN Booking ON Booking.DriverID = Driver.DriverID)
JOIN InVoice ON InVoice.BookingID = Booking.BookingID)
ORDER BY ErrorInEstimation;

SELECT * FROM EstimationError;

 
 
 









