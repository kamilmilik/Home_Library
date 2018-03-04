-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Czas generowania: 04 Mar 2018, 22:59
-- Wersja serwera: 5.7.19-log
-- Wersja PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `library`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `autor`
--

DROP TABLE IF EXISTS `autor`;
CREATE TABLE IF NOT EXISTS `autor` (
  `IdAutora` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Imie` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  `Nazwisko` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`IdAutora`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `autor`
--

INSERT INTO `autor` (`IdAutora`, `Imie`, `Nazwisko`) VALUES
(1, 'Peter', 'Kreeft'),
(2, 'Marta', 'Dymek'),
(21, 'lkmkl', 'lkml');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `biblioteka`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `biblioteka`;
CREATE TABLE IF NOT EXISTS `biblioteka` (
`Tytul` text
,`Isbn` varchar(64)
,`ImieAutora` varchar(32)
,`NazwiskoAutora` varchar(32)
,`RokWydania` int(10) unsigned
,`NazwaWydawnictwa` varchar(32)
,`NazwaDziedziny` varchar(32)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dziedzina`
--

DROP TABLE IF EXISTS `dziedzina`;
CREATE TABLE IF NOT EXISTS `dziedzina` (
  `IdDziedziny` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nazwa` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`IdDziedziny`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `dziedzina`
--

INSERT INTO `dziedzina` (`IdDziedziny`, `Nazwa`) VALUES
(1, 'Nauki Humanistyczne'),
(2, 'Religia Nauki Humanistyczne'),
(3, 'Filozofia');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ksiazki`
--

DROP TABLE IF EXISTS `ksiazki`;
CREATE TABLE IF NOT EXISTS `ksiazki` (
  `IdKsiazki` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Isbn` varchar(64) COLLATE utf8_polish_ci NOT NULL,
  `IdWydano` int(10) UNSIGNED NOT NULL,
  `IdNapisanaPrzez` int(10) UNSIGNED NOT NULL,
  `IdDziedzina` int(10) UNSIGNED NOT NULL,
  `Tytul` text COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`IdKsiazki`),
  UNIQUE KEY `Isbn` (`Isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `ksiazki`
--

INSERT INTO `ksiazki` (`IdKsiazki`, `Isbn`, `IdWydano`, `IdNapisanaPrzez`, `IdDziedzina`, `Tytul`) VALUES
(1, '9788364095665', 1, 1, 1, 'Między piekłem a niebem dialog w zaświatach'),
(2, '9788365586971', 2, 2, 3, 'Nowa Jadłonomia'),
(19, 'jknk', 0, 0, 0, 'sdds');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `napisanaprzez`
--

DROP TABLE IF EXISTS `napisanaprzez`;
CREATE TABLE IF NOT EXISTS `napisanaprzez` (
  `IdNapisanaPrzez` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdKsiazki` int(10) UNSIGNED NOT NULL,
  `IdAutora` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`IdNapisanaPrzez`),
  KEY `FK_IdAutora` (`IdAutora`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `napisanaprzez`
--

INSERT INTO `napisanaprzez` (`IdNapisanaPrzez`, `IdKsiazki`, `IdAutora`) VALUES
(1, 1, 1),
(2, 2, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wydano`
--

DROP TABLE IF EXISTS `wydano`;
CREATE TABLE IF NOT EXISTS `wydano` (
  `IdWydano` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Rok` int(10) UNSIGNED NOT NULL,
  `IdKsiazki` int(10) UNSIGNED NOT NULL,
  `IdWydawnictwa` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`IdWydano`),
  KEY `FK_IdWydawnictwa` (`IdWydawnictwa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `wydano`
--

INSERT INTO `wydano` (`IdWydano`, `Rok`, `IdKsiazki`, `IdWydawnictwa`) VALUES
(1, 2017, 1, 1),
(2, 2017, 2, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wydawnictwo`
--

DROP TABLE IF EXISTS `wydawnictwo`;
CREATE TABLE IF NOT EXISTS `wydawnictwo` (
  `IdWydawnictwa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nazwa` varchar(32) COLLATE utf8_polish_ci NOT NULL,
  PRIMARY KEY (`IdWydawnictwa`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `wydawnictwo`
--

INSERT INTO `wydawnictwo` (`IdWydawnictwa`, `Nazwa`) VALUES
(1, 'FRONDA'),
(2, 'Marginesy'),
(21, 'lkmlk');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zdziedziny`
--

DROP TABLE IF EXISTS `zdziedziny`;
CREATE TABLE IF NOT EXISTS `zdziedziny` (
  `IdZDziedziny` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdKsiazki` int(10) UNSIGNED NOT NULL,
  `IdDziedziny` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`IdZDziedziny`),
  KEY `FK_IdDziedziny` (`IdDziedziny`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `zdziedziny`
--

INSERT INTO `zdziedziny` (`IdZDziedziny`, `IdKsiazki`, `IdDziedziny`) VALUES
(1, 1, 1),
(2, 2, 3);

-- --------------------------------------------------------

--
-- Struktura widoku `biblioteka`
--
DROP TABLE IF EXISTS `biblioteka`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `biblioteka`  AS  select `a`.`Tytul` AS `Tytul`,`a`.`Isbn` AS `Isbn`,`c`.`Imie` AS `ImieAutora`,`c`.`Nazwisko` AS `NazwiskoAutora`,`e`.`Rok` AS `RokWydania`,`wyd`.`Nazwa` AS `NazwaWydawnictwa`,`dziedz`.`Nazwa` AS `NazwaDziedziny` from ((((((`ksiazki` `a` join `napisanaprzez` `b` on((`a`.`IdKsiazki` = `b`.`IdKsiazki`))) join `autor` `c` on((`b`.`IdAutora` = `c`.`IdAutora`))) join `zdziedziny` `d` on((`a`.`IdKsiazki` = `d`.`IdKsiazki`))) join `dziedzina` `dziedz` on((`d`.`IdDziedziny` = `dziedz`.`IdDziedziny`))) join `wydano` `e` on((`e`.`IdKsiazki` = `a`.`IdKsiazki`))) join `wydawnictwo` `wyd` on((`wyd`.`IdWydawnictwa` = `e`.`IdWydawnictwa`))) ;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `napisanaprzez`
--
ALTER TABLE `napisanaprzez`
  ADD CONSTRAINT `FK_IdAutora` FOREIGN KEY (`IdAutora`) REFERENCES `autor` (`IdAutora`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `wydano`
--
ALTER TABLE `wydano`
  ADD CONSTRAINT `FK_IdWydawnictwa` FOREIGN KEY (`IdWydawnictwa`) REFERENCES `wydawnictwo` (`IdWydawnictwa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograniczenia dla tabeli `zdziedziny`
--
ALTER TABLE `zdziedziny`
  ADD CONSTRAINT `FK_IdDziedziny` FOREIGN KEY (`IdDziedziny`) REFERENCES `dziedzina` (`IdDziedziny`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
