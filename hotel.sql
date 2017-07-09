-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2017 at 06:56 PM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE IF NOT EXISTS `hotels` (
  `hotelId` varchar(15) NOT NULL DEFAULT 'H000000000',
  `name` varchar(50) NOT NULL,
  `address` varchar(500) NOT NULL,
  `city` varchar(50) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `latitude` decimal(11,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`hotelId`, `name`, `address`, `city`, `longitude`, `latitude`) VALUES
('H000000002', 'Araliya Green City', 'Kothmale road,Nanuoya', 'Nuwara Eliya', '79.86124400', '6.92707870'),
('H000000003', 'Mount Lavinia Hotel', 'Hotel Rd, Dehiwala-Mount Lavinia, Sri Lanka', 'Mount Lavinia', '76.86124400', '6.92707870'),
('H000000004', 'Taj Samudra Hotel', '25, Galle Face Center Road, Colombo, Sri Lanka', 'Colombo', '77.86124400', '7.92707870'),
('H000000005', 'Citrus Waskaduwa   ', 'Beach Road,Waskaduwa,Panadura', 'Panadura', '79.94200000', '6.62488650');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
 ADD PRIMARY KEY (`hotelId`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
