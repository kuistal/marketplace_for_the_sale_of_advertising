-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: marketplace_for_the_sale_of_advertising_v2
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adspaces`
--

DROP TABLE IF EXISTS `adspaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adspaces` (
  `AdSpaceID` int NOT NULL AUTO_INCREMENT,
  `SellerID` int DEFAULT NULL,
  `Title` varchar(255) NOT NULL,
  `Description` text,
  `Price` decimal(10,2) NOT NULL,
  `Status` enum('available','unavailable') NOT NULL,
  PRIMARY KEY (`AdSpaceID`),
  KEY `SellerID` (`SellerID`),
  CONSTRAINT `adspaces_ibfk_1` FOREIGN KEY (`SellerID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adspaces`
--

LOCK TABLES `adspaces` WRITE;
/*!40000 ALTER TABLE `adspaces` DISABLE KEYS */;
INSERT INTO `adspaces` VALUES (1,3,'Ad Space 1','Description for Ad Space 1',50.00,'available'),(2,3,'Ad Space 2','Description for Ad Space 2',75.00,'unavailable'),(3,6,'Ad Space 3','Description for Ad Space 3',60.00,'available'),(4,6,'Ad Space 4','Description for Ad Space 4',85.00,'unavailable'),(5,6,'adSpace','baner',20.00,'available');
/*!40000 ALTER TABLE `adspaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!50001 DROP VIEW IF EXISTS `orderdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orderdetails` AS SELECT 
 1 AS `OrderID`,
 1 AS `UserID`,
 1 AS `BuyerName`,
 1 AS `AdSpaceID`,
 1 AS `AdSpaceTitle`,
 1 AS `OrderDate`,
 1 AS `Amount`,
 1 AS `Status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `AdSpaceID` int DEFAULT NULL,
  `OrderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Amount` decimal(10,2) NOT NULL,
  `Status` enum('pending','completed','cancelled') NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `BuyerID` (`UserID`),
  KEY `AdSpaceID` (`AdSpaceID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`AdSpaceID`) REFERENCES `adspaces` (`AdSpaceID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,'2024-06-05 17:09:41',50.00,'completed'),(2,2,1,'2024-06-05 17:09:41',50.00,'pending'),(3,1,1,'2024-06-05 17:09:49',50.00,'completed'),(4,2,1,'2024-06-05 17:09:49',50.00,'pending'),(5,1,1,'2024-06-05 17:21:33',50.00,'pending'),(6,1,1,'2024-06-05 17:21:39',50.00,'pending'),(7,1,1,'2024-06-05 17:22:13',50.00,'pending'),(8,1,1,'2024-06-05 17:23:37',50.00,'pending'),(9,1,1,'2024-06-05 17:26:01',50.00,'pending'),(10,1,1,'2024-06-05 17:26:33',52.00,'pending'),(11,1,1,'2024-06-05 17:26:36',52.00,'pending'),(12,1,2,'2024-06-05 17:31:24',25.00,'pending');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UpdateAdSpaceStatusAfterOrder` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    UPDATE AdSpaces
    SET Status = 'unavailable'
    WHERE AdSpaceID = NEW.AdSpaceID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `AdSpaceID` int DEFAULT NULL,
  `AuthorID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` text,
  `CreateDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `AdSpaceID` (`AdSpaceID`),
  KEY `AuthorID` (`AuthorID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`AdSpaceID`) REFERENCES `adspaces` (`AdSpaceID`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`AuthorID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `reviews_chk_1` CHECK (((`Rating` >= 1) and (`Rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,1,5,'Great ad space!','2024-06-05 17:09:56'),(2,2,2,4,'Good ad space','2024-06-05 17:09:56'),(3,1,4,4,'Nice ad space!','2024-06-05 19:01:38'),(4,3,1,5,'Excellent ad space!','2024-06-05 19:01:38'),(5,3,2,2,'Not satisfied','2024-06-05 19:01:38');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int DEFAULT NULL,
  `TransactionDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Amount` decimal(10,2) NOT NULL,
  `Type` enum('debit','credit') NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,'2024-06-05 17:19:25',50.00,'debit'),(2,2,'2024-06-05 17:19:25',50.00,'debit'),(3,7,'2024-06-05 17:22:13',50.00,'debit'),(4,8,'2024-06-05 17:23:37',100.00,'debit'),(5,9,'2024-06-05 17:26:01',50.00,'debit'),(6,10,'2024-06-05 17:26:33',52.00,'debit'),(7,11,'2024-06-05 17:26:36',52.00,'debit'),(8,12,'2024-06-05 17:31:24',25.00,'debit');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `UserType` enum('buyer','seller') NOT NULL,
  `CreateDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `Balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'buyer1','buyer1@example.com','hash1','buyer','2024-06-05 17:09:16',100.00),(2,'buyer2','buyer2@example.com','hash2','buyer','2024-06-05 17:09:16',200.00),(3,'seller1','seller1@example.com','hash3','seller','2024-06-05 17:09:16',300.00),(4,'buyer3','Buyer3@lwkmdw.ru','hash3','seller','2024-06-05 18:32:56',0.00),(5,'buyer3','buyer3@example.com','hash4','buyer','2024-06-05 19:00:10',150.00),(6,'seller2','seller2@example.com','hash5','seller','2024-06-05 19:00:10',350.00),(7,'Buyer6','Buyer6@email.ru','hash6','buyer','2024-06-05 19:07:59',200.00),(8,'seller3','seller3@mail.ru','42dfdc43286935904c9554be0fa5706c736c3ad95b0a44a547ee4fd0b11fe618','seller','2024-06-06 12:11:42',325.00);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'marketplace_for_the_sale_of_advertising_v2'
--

--
-- Dumping routines for database 'marketplace_for_the_sale_of_advertising_v2'
--
/*!50003 DROP FUNCTION IF EXISTS `GetAverageRating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GetAverageRating`(p_AdSpaceID INT) RETURNS decimal(3,2)
    DETERMINISTIC
BEGIN
    DECLARE v_AvgRating DECIMAL(3,2);

    SELECT AVG(Rating) INTO v_AvgRating
    FROM Reviews
    WHERE AdSpaceID = p_AdSpaceID;

    RETURN v_AvgRating;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateAdSpace` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateAdSpace`(
    IN p_SellerID INT,
    IN p_Title VARCHAR(255),
    IN p_Description TEXT,
    IN p_Price DECIMAL(10, 2),
    IN p_Status ENUM('available', 'unavailable')
)
BEGIN
    DECLARE v_AdSpaceID INT;

    -- Проверка существования продавца с указанным ID и типом 'seller'
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = p_SellerID AND UserType = 'seller') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seller does not exist or is not a seller';
    ELSE
        -- Вставка новой рекламной площадки
        INSERT INTO AdSpaces (SellerID, Title, Description, Price, Status)
        VALUES (p_SellerID, p_Title, p_Description, p_Price, p_Status);

        -- Получение ID созданной рекламной площадки
        SET v_AdSpaceID = LAST_INSERT_ID();

        -- Возвращение ID созданной рекламной площадки
        SELECT v_AdSpaceID AS AdSpaceID;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateOrderWithExceptionHandling` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateOrderWithExceptionHandling`(
    IN p_UserID INT,
    IN p_AdSpaceID INT,
    IN p_Amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_OrderID INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error occurred, the transaction has been rolled back.' AS message;
    END;

    START TRANSACTION;

    -- Создание заказа
    INSERT INTO Orders (UserID, AdSpaceID, OrderDate, Amount, Status) 
    VALUES (p_UserID, p_AdSpaceID, NOW(), p_Amount, 'pending');

    -- Получение ID созданного заказа
    SET v_OrderID = LAST_INSERT_ID();

    -- Создание транзакции
    INSERT INTO Transactions (OrderID, TransactionDate, Amount, Type) 
    VALUES (v_OrderID, NOW(), p_Amount, 'debit');

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUser`(
    IN p_Username VARCHAR(255),
    IN p_Email VARCHAR(255),
    IN p_Password VARCHAR(255),
    IN p_UserType ENUM('buyer', 'seller'),
    IN p_Balance DECIMAL(10, 2)
)
BEGIN
    DECLARE v_UserID INT;

    -- Проверка на уникальность Email
    IF EXISTS (SELECT 1 FROM Users WHERE Email = p_Email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    ELSE
        -- Вставка нового пользователя с хешированным паролем
        INSERT INTO Users (Username, Email, PasswordHash, UserType, Balance, CreateDate)
        VALUES (p_Username, p_Email, SHA2(p_Password, 256), p_UserType, p_Balance, NOW());

        -- Получение ID созданного пользователя
        SET v_UserID = LAST_INSERT_ID();

        -- Возвращение ID созданного пользователя
        SELECT v_UserID AS UserID;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `orderdetails`
--

/*!50001 DROP VIEW IF EXISTS `orderdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orderdetails` AS select `o`.`OrderID` AS `OrderID`,`o`.`UserID` AS `UserID`,`u`.`Username` AS `BuyerName`,`a`.`AdSpaceID` AS `AdSpaceID`,`a`.`Title` AS `AdSpaceTitle`,`o`.`OrderDate` AS `OrderDate`,`o`.`Amount` AS `Amount`,`o`.`Status` AS `Status` from ((`orders` `o` join `users` `u` on((`o`.`UserID` = `u`.`UserID`))) join `adspaces` `a` on((`o`.`AdSpaceID` = `a`.`AdSpaceID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-09 15:29:01
