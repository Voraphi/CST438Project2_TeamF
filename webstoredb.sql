-- MySQL dump 10.13  Distrib 5.5.62, for Linux (x86_64)
--
-- Host: localhost    Database: webstoredb
-- ------------------------------------------------------
-- Server version	5.5.62

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `cartId` mediumint(9) NOT NULL AUTO_INCREMENT,
  `itemId` mediumint(9) NOT NULL,
  `units` mediumint(9) NOT NULL,
  PRIMARY KEY (`cartId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemId` mediumint(9) NOT NULL AUTO_INCREMENT,
  `sellerId` mediumint(9) NOT NULL,
  `itemlink` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `itemname` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `unitsleft` mediumint(9) NOT NULL,
  `price` float(6,2) NOT NULL,
  `desc` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,1,'https://images.vans.com/is/image/Vans/EYEBWW-HERO?$583x583$','Some Vans','checkered black and white','shoes',8,49.99,'decent quality barely worn'),(2,1,'https://images.vans.com/is/image/Vans/D3HY28-HERO?$583x583$','Vans Shoes','classics','shoes',4,50.00,'great quality'),(3,2,'https://img.shopstyle-cdn.com/sim/c4/ca/c4cab75da6e5d5e5112685a16edf5ef3_best/tropical-animal-check-era.jpg','Tropical Vans','tropical','shoes',9,79.99,'brand new'),(4,3,'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAsHCBUOEQ0NDQ0NDQ0NEBANDQ0NDSEYDQ0PJxcpKScXJiUsMT8qLC4yLxomKj4rPTVDOkc6KjRBRkA4RjM5OjcBDAwMEA8RHQ8PFzchHSU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAOEA4QMBIgACEQEDEQH/xAAbAAEAAQUBAAAAAAAAAAAAAAAABgIDBAUHAf/EAEwQAAECAwMEDQgGCQMFAAAAAAABAgMEERIhMQYiMkEFBxNCUVJhcYGRobHwI2JygpKywdEUJDRzwuEWM0RTVGOToqNDg/ImZITS8f/EABgBAQADAQAAAAAAAAAAAAAAAAABAwQC/8QAIBEBAQACAgMBAQEBAAAAAAAAAAECAzEyESFRQRITIv/aAAwDAQACEQMRAD8A64AAAAAAAAAABq5/KCXlYm4x4+5xKI6zYVceZDaHMcq0SPOzKtfe1Ww9VmqIic+pcCccfN9uMr4npMImWcixaPmlb/48Sz12aHn6ayP8X/hf8jnTob0xS03zL7uVFw7VMSJJsfhmP8zN7FLZrn1xdl+OoplnI/xjf6T/AJBcs5HXOsTnY75HLJWQR613RjWOe+G10W0jXUoqqlEXCtOg3P6JPitasCakX751mKq5uOtFXhIuGM/UzO38Ttcs5BP21nsO+Q/TOR/jG/0n/I59FyRjq9rGTMm90NE3T6wua7pTk7UPImSz4as3SZk7Tl0WzCq512pETxUiY4/T+78dC/TOR/jG/wBJ/wAilctZBP2v/A/5HNZbYdq2rcyyzDVWusPVcLtaJS/kMhsSHAtJAhttN/1HtW1Xlct6Y6qnX+c+o/0vx0hmVMq5KpGfThWXeidqGXsdstBm7aS8VHqylpKKjm1wWinK4GyqKvlIjfRa1Ha0xW/sVCVZIR2pNWG5tti77S14VU5yw8ROOdt8JwACtaAAAAAAAAAAAAAAAAAAAAAPFOOvc6YiRo1WeUfullzlSJEtOVbk10OtbIupBjurZswojq8GacmZJ7k1yvsuwsue1Ua1qJSlUqi36y3X+qtnvw8iQ3suVHtv4yO7L+AofN1sVRjmuVNKuhiq8vCt/CV7q5G5lh2+8lFRG2elUp+RrpF6sdekJr3KrYcGE61uaKtFcqpVtaXUStargW8qp6bNVYv0eG9Gt3KDumc1LLXPcq6qaqXULMzKssRVZGc1zUtNsvrnJcl194Yy2rlo52+tOcq2rqJfjwGDOtREqmlvuYmY+uUXL3wz5+aYxGQ2LCY62+NEmYTlSNEtKq2Fqi4WrlvwSlNd1JmExGRKxXbksONDz1xRUXBKVv4TEiwroSqjXO3GG52alrQTClbw5lWMRdFrGd35CYFybKcmkY+bZDRjLUaznZrr0rVVROVeHHHUYLNj0fpq6L6TqtauqiYJ1HrnW2uhxFd5RbW6vcrrMVL0Vcbl0V4EVTKlLdL4NmzxXtc11NaKi4dS36iJP55LfPC6yTRiUVjPYS11mfsIu5zcpEtNajolmzxrsE6+wxXveuMOy3jOe1G9dS/LMcj4KvTRejmuZWy1yVpfdcqV1ajnO+k4S+fLpgPEwPTO1AAAAAAAAAAAAAAAAAAAAADX7PvsSs07+Wreu74nPYaojaetZJvlnFsSMdeFYbeuIhA4S3aFou1z0o232pm4NUvVzuM60axGNY6tbLW8Vptojnak/upZMGM1Va69rXF0VVRuqUue7XwFiZZVrtLBc7rKoL1Rb1aeRHrTG1a4x0hlTDlR7Up+rhss8ZzUaqJr5vyLMRe5nsl6beq7kqaLoMN2dSzVWouNUqt+Gsxoy3t5mO/tQiJrJhQ7eLODg0eYzZeVTiNa13HoYsKipSmdTN+Zkw3WFw+JFI2LHWEuX2fyKI8SjG6NrdGaejrr0mPCj8jjGn47ls03r07Djwny6rKurDhLxmMd2IXTE2Ifal5d3GhM7jLMzWAAAAAAAAAAAAAAAAAAAAANBlz9jcnGiQ07a/AhMs1Eskxy8eiS0JK6Uwz3XEOZdfvri7Dhn2cq3vudda6jXx7tTfWdXXzmY+ImcmaYcW+1e1u+zWl0V1iuRKtpZzSiIltKV4NFpkK1PDS0ty4e046jl7MOejYVhWu3ODBbZaxN0dmqla87eRaKYsJ7nrVUs4N7KGbHjUYyw+y2+G5trNucqpq1Vp1FtjPFnNIjqrsBFzVzrRlo13C71nFhjb97jy9BlQmJS/3VItQuQ4V2PepQjFtf26Nc7V2mXAZXjdiaizGVEdTlQjyl0LJx1ZSV+7abE1GSaoslL2cLPxNuZby1zgABCQAAAAAAAAAAAAAAAAAARbbBfSBLpwx+5jiKsW5tfHSSbbEcu4y33y+6pEWVp5xfrn/LNs7L9hKb0xlYqK69vs855Va4eLitzqq67WWK2PHZrz/ZpqSpSiUTD1nXl96+O0xY73WHLyKdoezGx6fQYM7Vzt3jzUNzd62j1oqdSlMqi2G8ZyG0mYKpk7sYvGiI53rMcvea+WalhtF1JmuOML5izKeKyIbOV3soZ8OClmqq7sQxYbF9L8PMZLFWlPGsVzF1qpq5eXUa+Ydn1zs2npYpW5C+9y/8TDfpXLZdfadxb8RIV0XI9V+hwrVm01XtdZ0bnKbo0WRn2RtEs0ixfeU3ply5rVjxAAEOgAAAAAAAAAAAAAAAAAAQ/bGXMlE8+J7pFYBKNsfCS54zvd+ZF5RUr45TRh1ZtnZebDv8cJW+EjG1Uraq13uaUxW1Q68uPDDi3f8At+XSa/ZCL5N/T7JmzLqWkNVsmq7k/wBnru+Z3+ITOblf+npFOJDlndbafiIzsfosrvU43LwE62RgU2EYziQoHvoQOQS+i+r8CvXxVmzmNtAYmKePF5esqiVLUNukXFW5vjAlyoVmkYb6Irq5vq17DMWvaYr1zr1c3zm0tc5MRU8yJX6qtbl3aNy7435H8ifsz/voneSAzZ9q1Y9YAA5dAAAAAAAAAAAAAAAAAAAhe2Qv2H/f/CRqWS8ke2SudIejM/gI7JONGHWM2fasxd7UoenjoLjkraoWXupdvhHLCmmmtnnVRjP5nc1Vv7DZzGBrosFVdC85V7k8dJZ+IdM2ah02KVOLCgO6ntU53ATPcdO2ah12OipwS6O6kRfgc0hMpFcnFKtV9VZt5jZw1qjS49KlqXL1dI6rhbVKIYr20XGzjnO3plRF5LJiPff4XVwazqIqcZDp9Xip/Pid+JIiPZEfZ4vLGc7rRCQmbPtWrHrAAHLoAAAAAAAAAAAAAAAAAAEJ2yNKR5o/e0j0m1Kkh2yFz5H0Y/ew0Mk3x0mjDrGbPtWVgnGLT2JV3vGSlKdBjRd8I5rXzK3YlvF0qnGf+JK95XMJVCmUh+XlU89PaVyL8EO7wicup7KN+pzDf+2ie4cthLV715UOtTjLUGM3jQnt/tOTMVbbivV+rdv42UsXXYluXXRLqN0iby4Y0RTGtKi+iuldzF+Mt3jkMe3VW5lu/RsotroO45qdZFfqIvnRVd6VyXkhI9kUqrAjV/fPw0W8ic2BITNn2rVj1gADl0AAAAAAAAAAAAAAAAAACEbZKZ+x/NH72Ghk65pINsdL5Fbv9fvYRqBE0U5TRh1jNn2rarSjTEiJpdPjqLjo11xjRYt3X3qJHNYczvfGcX9ioarNyiaWdD7FUsR3XGXk4ys9KV4WdV53l1MeXU4qVa5OMip2HJFue9N8ddORzC1iv51b20KtPNW7vxnSdc0yHpe4xZSJc1PGsyHPvcvId3lXOGPMuTgMdjK2Uq5vnN0i7GdW0YytRValdLfYnUjmp3kP9ni5tPLP7yREeyJ+zxfvoneSEzZ9q1YdYAA5dAAAAAAAAAAAAAAAAAAAhO2X+wrT9/ncW9hDmRO/x3kv2z6Ukf8Af/AQxqcBq19Yy7O1ZqR9Epc7l8eFMat/SVpE8O6Drw4VRXX3+PFVNnkulZ+WvtXmpV1b+Nmm6yRSuyEL1u5CMuK6w7R005PslDsR4qee/wB5TrByvZxE+kzH3kZvU5SrTyt3cRZgPopde+8wmPvL6RFzeYusU+XquVbXMUQ0VXNREY51U09HpPFrTzXePgpS5ltW3Od5raZ3WShP8iV+rxb7Xln95ISP5FfqIt7XeWfo4YkgMmfateHWAAOXQAAAAAAAAAAAAAAAAAAITtntVWSnPF/CQhjridbZieTlFs2s+I3mqifIgzFu9FO35GrV1ZdnL1UvcVW9IoRa9R7T4FitcatEbXxeb7Ix1ufTzWr3IaFb7NSR5EN+vuTise7UmKJqQ4z613h2johy7KRKTUymrdInaqqdROYZV3Tkx6alOnsu28NSx3jpK2xNRbap4119PGv5GlnXrXCeMfnNo9rLS6TtEpQrgrnwqb5U0SB0HIhlJZ6WbHlo2barviQEfyIbSUv/AHsTFyrvuUkBkz7Vrx6wABy6AAAAAAAAAAAAAAAAAABENspq/R5ZU/f53sL8iAMTh5fHedC2ya/RYNltr6y2vJ5Nxz1m+NWrqzbeVTV8dJUvulGsqVbyxUqRNfKSXIG+dirR2guPKiEbYl7U4q/IleQSVm5pf5bTjZ1qzXzE9OZZYtpNzHP3tRTppzDLV31+Zb927/G0p09lu3hp0vX0g3GpSxfHQeqhpZ1VvS8eNRdlqq9nnLxqWW0vWvNUsN3tN8XpVU3Vl2dXjaK0XHsqRR0LIViJIwkbo232c6t1eEkBosivsUJblq5+jo46jemPLmtePEAAQ6AAAAAAAAAAAAAAAAAABGNsNtZNl9mkdnuuuOc1XUdG2xG1ktC35aHqrqW85srr3b2806eGbbyuMbpc29HceMXSX8Qbj6RcrVtW/pQl+19fMTa+YzOrXEiKLe1eX4Ex2unWos6/kZw/Eq29XersnBzbLtlJyI6zpNh38OaifA6Sc8y/Sky5eNDh/FCnV2XbeEYYneVPx6ihvz7j2i+sa2V6mHjlLsnptuz77LrOa1aYqWU3vQ0yJdqUeio6y5j85rqWc0i8Jjo+RqKkjL1vW/vN2afJGHYkpVvmG4MWXNbMeIAAhIAAAAAAAAAAAAAAAAAAI1thIv0F1P3kPe18YnNdfjhOrZV7Hvm5V8GAtmJbY65US5F5UXUQX9EZpUb5CLqtZzcaX6uEv1ZST2o2Y2300ap4aesx8WjctyRmkRfq8Zy3u02Y0w+BSmSk1Wn0WPpcZuF1+PL2Fv8AeP1X/GXxrIaZza6NbXq1/Im+10l82vn2TRSOS00kRFfKva3z4qWcExREVdapdwdcsyM2MiSzJjd4bmOiPR1lVRdV9KFWzOWeIs14WXzUkOebYjV+lM4rpZPfU6GRTLPYWLNvgxIMO2jWKx1lyI7XTHlUqwvi+1mc8z0563Hp+Bfb7JsVyVnEX7LFdhv2rw14C+zJaZpfLxfabhVf/vSav7x+s/8AGXxplcnjsL0s9taKuc5j2tbapazVu6jPdknNZtmXi9L2pZS7XReVOozFyXjombAW3SzaWKuC3YomNCLnj45Jhl8TLJj7HK+ghtDB2FllgS8CC9LLobLLm4mcZby1TgABCQAAAAAAAGDsz+rb6adymnAITFmZPYGABAqcUgEJAAAABKAABL09QAIVIeqAQkQ9QAlAUv0XeioBAsSO/wCgygBeSPAABSVgADxQAAAA/9k=','Some Jeans','normal jeans','pants',20,13.00,'decent quality hardly worn'),(5,2,'https://lp2.hm.com/hmgoepprod?set=quality[79],source[/df/a5/dfa5aa69cdfc2efeeaf88589cced5d006578b19f.jpg],origin[dam],category[men_tshirtstanks_shortsleeve],type[DESCRIPTIVESTILLLIFE],res[m],hmver[1]&call=url[file:/product/main]','Green Shirt','olive green','shirt',8,19.99,'is ight quality');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderhistory`
--

DROP TABLE IF EXISTS `orderhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderhistory` (
  `orederId` mediumint(9) NOT NULL AUTO_INCREMENT,
  `userId` mediumint(9) NOT NULL,
  `itemId` mediumint(9) NOT NULL,
  `itemlink` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `itemname` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `unitspurchased` mediumint(9) NOT NULL,
  `price` float(6,2) NOT NULL,
  `datapurchased` date NOT NULL,
  PRIMARY KEY (`orederId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderhistory`
--

LOCK TABLES `orderhistory` WRITE;
/*!40000 ALTER TABLE `orderhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userId` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(72) COLLATE utf8_unicode_ci NOT NULL,
  `firstname` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'voraphi','catsRgood','Jesus','Caballero'),(2,'username','password','FirstName','LastName'),(3,'phi','something','Not Jesus','idk'),(4,'phi','$2b$10$IyWy5bCH6AETqZhYiXGNhebi4nEwNR/iW5wy7SzuM79gjKROA3J/C','phi','phi'),(5,'phiphi','$2b$10$T8ZXyunSX2ZQ1jqOl4NJjOko5dheXYWvKSqhAaaiBhJxlLd.jj50W','first','last');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-08  3:32:52
