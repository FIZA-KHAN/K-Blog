-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 11, 2021 at 03:54 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kblogs`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(10) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'FIZA_HOST', 'fizakhan0720@gmail.com', '12345678', '12345', '2021-01-31 13:13:18'),
(2, 'abcd', 'abcd@gmail.com', '1234567891', '1234', '2021-01-31 13:13:51'),
(3, 't9', 't9@gmail.com', '234567', 'wertyu', '2021-02-02 21:08:55'),
(6, 'r4', 'r4@gmail.com', '123456', 'qwertujgfd', '2021-02-02 21:11:47');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(60) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(60) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `name`, `title`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Fiza', 'About Stock Markets.', 'first-post', 'A stock market, equity market, or share market is the aggregation of buyers and sellers of stocks (also called shares), which represent ownership claims on businesses; these may include securities listed on a public stock exchange, as well as stock that is only traded privately, such as shares of private companies which are sold to investors through equity crowdfunding platforms. Investment in the stock market is most often done via stockbrokerages and electronic trading platforms. Investment is usually made with an investment strategy in mind.\r\n\r\nStocks can be categorized by the country where the company is domiciled. For example, Nestlé and Novartis are domiciled in Switzerland and traded on the SIX Swiss Exchange, so they may be considered as part of the Swiss stock market, although the stocks may also be traded on exchanges in other countries, for example, as American depositary receipts (ADRs) on U.S. stock markets. The total market capitalization of equity backed securities worldwide rose from US$2.5 trillion in 1980 to US$68.65 trillion at the end of 2018. As of December 31, 2019, the total market capitalization of all stocks worldwide was approximately US$70.75 trillion.\r\nAs of 2016, there are 60 stock exchanges in the world. Of these, there are 16 exchanges with a market capitalization of $1 trillion or more, and they account for 87% of global market capitalization. Apart from the Australian Securities Exchange, these 16 exchanges are all in either North America, Europe, or Asia.\r\nBy country, the largest stock markets as of January 2020 are in the United States of America (about 54.5%), followed by Japan (about 7.7%) and the United Kingdom (about 5.1%).', 'post-bg.jpg', '2021-02-01 12:58:44'),
(8, 'T1', 'Variables', 'post-2', 'Template variables are defined by the context dictionary passed to the template.\r\n\r\nYou can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\nYou can use a dot (.) to access attributes of a variable in addition to the standard Python __getitem__ “subscript” syntax ([]).\r\n\r\nThe following lines do the same thing:\r\n\r\n{{ foo.bar }}\r\n{{ foo[\'bar\'] }}\r\nIt’s important to know that the outer double-curly braces are not part of the variable, but the print statement. If you access variables inside tags don’t put the braces around them.\r\n\r\nIf a variable or attribute does not exist, you will get back an undefined value. What you can do with that kind of value depends on the application configuration: the default behavior is to evaluate to an empty string if printed or iterated over, and to fail for every other operation.', '', '2021-02-02 20:59:01'),
(9, 'T2', 'Implementation', 'POST-3', 'For the sake of convenience, foo.bar in Jinja does the following things on the Python layer:\r\n\r\ncheck for an attribute called bar on foo (getattr(foo, \'bar\'))\r\n\r\nif there is not, check for an item \'bar\' in foo (foo.__getitem__(\'bar\'))\r\n\r\nif there is not, return an undefined object.\r\n\r\nfoo[\'bar\'] works mostly the same with a small difference in sequence:\r\n\r\ncheck for an item \'bar\' in foo. (foo.__getitem__(\'bar\'))\r\n\r\nif there is not, check for an attribute called bar on foo. (getattr(foo, \'bar\'))\r\n\r\nif there is not, return an undefined object.\r\n\r\nThis is important if an object has an item and attribute with the same name. Additionally, the attr() filter only looks up attributes.', '', '2021-02-02 20:59:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
