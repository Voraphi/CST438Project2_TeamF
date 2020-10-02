SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
	`userId` mediumint(9) NOT NULL,
	`username` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
	`password` varchar(72) COLLATE utf8_unicode_ci NOT NULL,
	`firstname` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
	`lastname` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);

ALTER TABLE `users`
  MODIFY `userId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;



DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `itemId` mediumint(9) NOT NULL,
  `userId` mediumint(9) NOT NULL,
  `itemlink` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `itemname` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `unitsleft` mediumint(9) COLLATE utf8_unicode_ci NOT NULL,
  `price` float(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `items`
  ADD PRIMARY KEY (`itemId`);

ALTER TABLE `items`
  MODIFY `itemId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;



DROP TABLE IF EXISTS `orderhistory`;

CREATE TABLE `orderhistory` (
	`orederId` mediumint(9) NOT NULL,
	`userId` mediumint(9) NOT NULL,
	`sellerId` mediumint(9) NOT NULL,
  `itemlink` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `itemname` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `unitspurchased` mediumint(9) COLLATE utf8_unicode_ci NOT NULL,
  `price` float(6,2) NOT NULL,
  `datapurchased` DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `orderhistory`
  ADD PRIMARY KEY (`orederId`);

ALTER TABLE `orderhistory`
  MODIFY `orederId` mediumint(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;


COMMIT;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
