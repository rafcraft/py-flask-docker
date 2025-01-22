-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Cze 01, 2023 at 10:30 PM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chatanon`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `form`
--

CREATE TABLE form (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  message TEXT NOT NULL
);

--
-- Dumping data for table `form`
--

INSERT INTO form (id, email, name, last_name, message) VALUES
(1, 'bober@wp.pl', 'wobr', 'owski', 'sdadads'),
(30, 'siem@wp.pl', 'asdasyj', 'tyuktyu', 'p[\r\nO\r\ntdhsrhtg');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `messages`
--

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  username VARCHAR(30),
  message TEXT,
  data TIMESTAMP
);

--
-- Dumping data for table `messages`
--

INSERT INTO messages (id, username, message, data) VALUES
(7, 'dawfwaserfaWD', 'tgyjftyijrjtydftrjy', '2023-05-27 02:53:50');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `form`
--
ALTER TABLE `form`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `form`
--
ALTER TABLE `form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
