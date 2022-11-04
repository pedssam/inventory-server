-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2022 at 03:28 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toy_inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  `supplier` varchar(100) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `code`, `supplier`, `deleted`) VALUES
(1, 'N/A', 'N/A', 'N/A', 0),
(2, 'Disney Princess', 'CT-001', 'Nilsp Incorporation', 0),
(3, 'Waze Truck', 'CT-002', 'Brakama Package', 0),
(4, 'Top Gun', 'CT-003', 'Randy Store', 0),
(5, 'Ball', 'CT-004', 'Remenes Dilos', 0),
(6, 'Anime', 'CT-005', 'Remenes Dilos', 0),
(7, 'Puzzle', 'CT-006', 'Puzzle Mania', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `stock` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `investment` decimal(10,2) NOT NULL,
  `total_investment` decimal(10,2) NOT NULL,
  `selling` decimal(10,2) NOT NULL,
  `exp_return` decimal(10,2) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `stock`, `name`, `category_id`, `investment`, `total_investment`, `selling`, `exp_return`, `deleted`) VALUES
(1, 65, 'Wilson Ball', 5, '300.00', '24000.00', '350.00', '28000.00', 0),
(2, 100, 'Fortnite Gun V1', 4, '110.00', '19800.00', '130.00', '23400.00', 0),
(3, 70, 'Jolly Pet', 1, '70.00', '4900.00', '90.00', '6300.00', 0),
(4, 115, 'Among Us Toy', 1, '120.00', '16800.00', '160.00', '22400.00', 0),
(6, 80, 'Lego Robot', 6, '120.00', '15600.00', '200.00', '26000.00', 0),
(7, 120, 'Yoyo', 5, '50.00', '10000.00', '60.00', '12000.00', 0),
(8, 35, 'Tanjiro Collection', 6, '130.00', '9100.00', '150.00', '10500.00', 0),
(9, 10, 'Testing It Now', 2, '30.00', '300.00', '55.00', '550.00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_stock_history`
--

CREATE TABLE `product_stock_history` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `stock_history` int(10) NOT NULL,
  `add_or_less` int(1) NOT NULL DEFAULT 1,
  `add_or_less_stock` int(11) NOT NULL,
  `receipt_ref_num` varchar(100) DEFAULT NULL,
  `receipt_for` varchar(100) DEFAULT NULL,
  `purchase_amount` decimal(10,2) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT current_timestamp(),
  `deleted` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_stock_history`
--

INSERT INTO `product_stock_history` (`id`, `product_id`, `stock_history`, `add_or_less`, `add_or_less_stock`, `receipt_ref_num`, `receipt_for`, `purchase_amount`, `description`, `date_time`, `deleted`) VALUES
(1, 1, 50, 1, 50, NULL, NULL, NULL, '', '2022-10-27 15:19:48', 0),
(2, 2, 109, 1, 109, NULL, NULL, NULL, '', '2022-10-27 18:21:58', 0),
(3, 3, 70, 1, 70, NULL, NULL, NULL, '', '2022-10-28 17:54:19', 0),
(4, 4, 90, 1, 90, NULL, NULL, NULL, '', '2022-10-28 17:55:54', 0),
(11, 4, 115, 0, 25, 'TY-HX3DSX8Z2X', 'Renato Cruz', '4000.00', 'Renato Cruz Purchase 30pcs ', '2022-10-31 14:23:25', 0),
(12, 2, 180, 0, 30, 'TY-7T2YTG251J', 'David Santos', '3900.00', 'Renato Cruz Purchase 30 Fnite Gun', '2022-11-01 14:24:03', 0),
(13, 1, 65, 0, 15, 'TY-2IFJ07XZNJ', 'Renato Cruz', '5250.00', 'Give 6% Discount and add 5', '2022-11-01 14:24:31', 0),
(14, 6, 130, 1, 130, NULL, NULL, NULL, '', '2022-11-01 16:05:17', 0),
(15, 2, 150, 0, 20, 'TY-IN2I67SGRE', 'Renato Cruz', '2600.00', '', '2022-11-01 18:12:25', 0),
(16, 6, 80, 0, 30, 'TY-8XL297L040', 'Renato Cruz', '6000.00', '', '2022-11-01 18:12:45', 0),
(17, 6, 100, 0, 20, 'TY-I3SM3UMEOM', 'David Santos', '4000.00', '', '2022-11-01 18:13:02', 0),
(18, 2, 100, 0, 30, 'TY-VT16NXDFZO', 'Angela Cruz', '3900.00', '', '2022-11-01 18:13:25', 0),
(19, 7, 200, 1, 200, NULL, NULL, NULL, '', '2022-11-01 18:13:59', 0),
(20, 8, 70, 1, 70, NULL, NULL, NULL, '', '2022-11-01 18:14:24', 0),
(21, 8, 70, 0, 20, 'TY-6N3LOPE6NS', 'Angela Cruz', '3000.00', '', '2022-11-01 18:14:55', 0),
(22, 8, 50, 0, 15, 'TY-SQR12JYN5E', 'Renato Cruz', '2250.00', '', '2022-11-01 18:15:18', 0),
(23, 7, 200, 0, 50, 'TY-09O5VRC6DC', 'Renato Cruz', '3000.00', '', '2022-11-01 18:15:29', 0),
(24, 7, 150, 0, 30, 'TY-RAKYMI7YIL', 'David Santos', '1800.00', '', '2022-11-01 18:15:53', 0),
(25, 9, 10, 1, 10, NULL, NULL, NULL, '', '2022-11-03 20:12:24', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`) VALUES
(1, 'arvinuser', 'arvin2022user01', 'Arvin Parungao');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_stock_history`
--
ALTER TABLE `product_stock_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `product_stock_history`
--
ALTER TABLE `product_stock_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Constraints for table `product_stock_history`
--
ALTER TABLE `product_stock_history`
  ADD CONSTRAINT `product_stock_history_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
