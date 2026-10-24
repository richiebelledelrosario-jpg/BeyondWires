-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2026 at 03:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `beyondwires`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `setting_key` varchar(60) NOT NULL,
  `setting_value` varchar(255) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`setting_key`, `setting_value`, `updated_by`, `updated_at`) VALUES
('markup_percent', '20', 1, '2026-10-24 08:19:02');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action_type` varchar(60) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `user_id`, `action_type`, `details`, `ip_address`, `timestamp`) VALUES
(1, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 05:54:00'),
(2, 2, 'LOGOUT', '', '::1', '2026-10-07 05:57:10'),
(3, 3, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 06:20:16'),
(4, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 06:24:41'),
(5, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 06:27:37'),
(6, 1, 'LOGOUT', '', '::1', '2026-10-07 06:40:34'),
(7, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 06:40:53'),
(8, 4, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 07:08:04'),
(9, 5, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 09:18:36'),
(10, 5, 'INQUIRY_SUBMITTED', '#1,#2', '::1', '2026-10-07 09:19:39'),
(11, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 09:21:42'),
(12, 1, 'LOGOUT', '', '::1', '2026-10-07 09:40:44'),
(13, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 09:41:11'),
(14, 2, 'INQUIRY_ACCEPTED', '#2', '::1', '2026-10-07 09:41:34'),
(15, 2, 'QUOTATION_CREATED', '#1', '::1', '2026-10-07 09:43:35'),
(16, 2, 'LOGOUT', '', '::1', '2026-10-07 09:44:09'),
(17, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 09:44:34'),
(18, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00001', '::1', '2026-10-07 09:44:47'),
(19, 1, 'LOGOUT', '', '::1', '2026-10-07 09:45:46'),
(20, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 09:46:08'),
(21, 2, 'LOGOUT', '', '::1', '2026-10-07 09:46:57'),
(22, 5, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 09:47:18'),
(23, 5, 'QUOTATION_APPROVED', 'Q-2026-00001', '::1', '2026-10-07 09:47:48'),
(24, 5, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00001', '::1', '2026-10-07 09:49:06'),
(25, 5, 'LOGOUT', '', '::1', '2026-10-07 09:49:21'),
(26, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 09:49:52'),
(27, 2, 'PAYMENT_CONFIRMED', '#1', '::1', '2026-10-07 09:50:15'),
(28, 2, 'RECEIPT_SENT', 'OR-2026-00001', '::1', '2026-10-07 09:50:31'),
(29, 2, 'INSTALL_STARTED', 'project #1', '::1', '2026-10-07 09:50:40'),
(30, 2, 'INSTALLATION_COMPLETE', 'project #1 -> Done', '::1', '2026-10-07 09:50:47'),
(31, 2, 'CERTIFICATE_SENT', 'project #1', '::1', '2026-10-07 09:51:22'),
(32, 2, 'LOGOUT', '', '::1', '2026-10-07 09:53:00'),
(33, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 09:53:26'),
(34, 5, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 10:20:04'),
(35, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 10:21:18'),
(36, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 10:23:34'),
(37, 2, 'INQUIRY_ACCEPTED', '#1', '::1', '2026-10-07 10:26:01'),
(38, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #1', '::1', '2026-10-07 10:26:08'),
(39, 2, 'SITE_VISIT_DONE', 'inquiry #1', '::1', '2026-10-07 10:26:08'),
(40, 5, 'LOGOUT', '', '::1', '2026-10-07 12:22:44'),
(41, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 12:23:10'),
(42, 2, 'LOGOUT', '', '::1', '2026-10-07 12:23:39'),
(43, 6, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 12:24:29'),
(44, 6, 'INQUIRY_SUBMITTED', '#3', '::1', '2026-10-07 12:25:53'),
(45, 6, 'LOGOUT', '', '::1', '2026-10-07 12:25:57'),
(46, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 12:26:18'),
(47, 5, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 12:27:53'),
(48, 5, 'LOGOUT', '', '::1', '2026-10-07 12:28:34'),
(49, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 12:29:03'),
(50, 1, 'LOGOUT', '', '::1', '2026-10-07 12:30:53'),
(51, 5, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 12:31:14'),
(52, 5, 'LOGOUT', '', '::1', '2026-10-07 12:37:01'),
(53, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 12:37:29'),
(54, 1, 'LOGOUT', '', '::1', '2026-10-07 12:53:06'),
(55, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 12:53:56'),
(56, 2, 'INQUIRY_REJECTED', '#3 (Outside service area (NCR only))', '::1', '2026-10-07 12:54:11'),
(57, 2, 'INQUIRY_REJECTED', '#1 (Outside service area (NCR only))', '::1', '2026-10-07 12:54:27'),
(58, 2, 'LOGOUT', '', '::1', '2026-10-07 12:54:45'),
(59, 5, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 12:55:04'),
(60, 11, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 13:18:40'),
(61, 11, 'INQUIRY_SUBMITTED', '#4', '::1', '2026-10-07 13:23:44'),
(62, 11, 'INQUIRY_SUBMITTED', '#5', '::1', '2026-10-07 13:27:56'),
(63, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 13:32:08'),
(64, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 13:34:15'),
(65, 2, 'INQUIRY_ACCEPTED', '#5', '::1', '2026-10-07 13:38:58'),
(66, 2, 'QUOTATION_CREATED', '#2', '::1', '2026-10-07 13:47:32'),
(67, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 13:48:21'),
(68, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-07 13:49:36'),
(69, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-07 13:50:45'),
(70, 1, 'QUOTATION_EDITED_OWNER', '#2', '::1', '2026-10-07 14:00:59'),
(71, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00002', '::1', '2026-10-07 14:01:11'),
(72, 11, 'LOGIN', 'Signed in as customer', '::1', '2026-10-07 14:04:16'),
(73, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-19 11:27:40'),
(74, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-19 11:44:33'),
(75, 12, 'PROFILE_UPDATE', '', '::1', '2026-10-19 11:51:49'),
(76, 12, 'PASSWORD_CHANGE', '', '::1', '2026-10-19 11:53:02'),
(77, 12, 'LOGOUT', '', '::1', '2026-10-19 11:53:16'),
(78, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-19 11:53:26'),
(79, 12, 'INQUIRY_SUBMITTED', '#6', '::1', '2026-10-19 12:00:52'),
(80, 12, 'LOGOUT', '', '::1', '2026-10-19 12:01:17'),
(81, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-19 12:01:39'),
(82, 2, 'INQUIRY_ACCEPTED', '#6', '::1', '2026-10-19 12:01:53'),
(83, 2, 'QUOTATION_CREATED', '#3', '::1', '2026-10-19 12:05:53'),
(84, 2, 'QUOTATION_EDITED', '#3', '::1', '2026-10-19 12:06:04'),
(85, 2, 'QUOTATION_SUBMITTED', 'Q-2026-00003', '::1', '2026-10-19 12:06:04'),
(86, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-19 12:08:38'),
(87, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00003', '::1', '2026-10-19 12:08:59'),
(88, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-19 12:10:50'),
(89, 12, 'LOGOUT', '', '::1', '2026-10-19 12:11:19'),
(90, 1, 'LOGOUT', '', '::1', '2026-10-19 12:12:15'),
(91, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-19 12:12:43'),
(92, 12, 'QUOTATION_APPROVED', 'Q-2026-00003', '::1', '2026-10-19 12:15:10'),
(93, 12, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00003', '::1', '2026-10-19 12:16:43'),
(94, 2, 'PAYMENT_CONFIRMED', '#2', '::1', '2026-10-19 12:17:16'),
(95, 2, 'RECEIPT_SENT', 'OR-2026-00002', '::1', '2026-10-19 12:17:50'),
(96, 2, 'AVAILABILITY_CHANGED', '2026-10-21', '::1', '2026-10-19 12:18:32'),
(97, 2, 'AVAILABILITY_CHANGED', '2026-10-23', '::1', '2026-10-19 12:18:52'),
(98, 2, 'AVAILABILITY_CHANGED', '2026-10-28', '::1', '2026-10-19 12:19:09'),
(99, 2, 'INSTALL_STARTED', 'project #2', '::1', '2026-10-19 12:19:30'),
(100, 2, 'INSTALLATION_COMPLETE', 'project #2 -> Awaiting Final Payment', '::1', '2026-10-19 12:20:13'),
(101, 2, 'RECEIPT_SENT', 'OR-2026-00002', '::1', '2026-10-19 12:20:57'),
(102, 12, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00003', '::1', '2026-10-19 12:22:17'),
(103, 2, 'PAYMENT_CONFIRMED', '#3', '::1', '2026-10-19 12:22:25'),
(104, 2, 'RECEIPT_SENT', 'OR-2026-00003', '::1', '2026-10-19 12:22:27'),
(105, 2, 'CERTIFICATE_SENT', 'project #2', '::1', '2026-10-19 12:23:49'),
(106, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-19 12:25:54'),
(107, 12, 'INQUIRY_SUBMITTED', '#7', '::1', '2026-10-19 12:27:43'),
(108, 2, 'INQUIRY_ACCEPTED', '#4', '::1', '2026-10-19 12:28:10'),
(109, 2, 'QUOTATION_CREATED', '#4', '::1', '2026-10-19 12:29:46'),
(110, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-20 01:46:10'),
(111, 2, 'INQUIRY_ACCEPTED', '#7', '::1', '2026-10-20 01:46:32'),
(112, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #7', '::1', '2026-10-20 01:46:35'),
(113, 2, 'SITE_VISIT_DONE', 'inquiry #7', '::1', '2026-10-20 01:46:35'),
(114, 2, 'QUOTATION_CREATED', '#5', '::1', '2026-10-20 03:21:00'),
(115, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-20 03:22:36'),
(116, 1, 'QUOTATION_EDITED_OWNER', '#5', '::1', '2026-10-20 03:23:46'),
(117, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-20 03:24:42'),
(118, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00005', '::1', '2026-10-20 03:25:40'),
(119, 12, 'QUOTATION_APPROVED', 'Q-2026-00005', '::1', '2026-10-20 03:26:24'),
(120, 12, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00005', '::1', '2026-10-20 03:27:01'),
(121, 2, 'PAYMENT_CONFIRMED', '#4', '::1', '2026-10-20 03:29:17'),
(122, 2, 'RECEIPT_SENT', 'OR-2026-00004', '::1', '2026-10-20 03:29:26'),
(123, 2, 'INSTALL_STARTED', 'project #3', '::1', '2026-10-20 03:33:46'),
(124, 2, 'INSTALLATION_COMPLETE', 'project #3 -> Awaiting Final Payment', '::1', '2026-10-20 03:33:54'),
(125, 12, 'INQUIRY_SUBMITTED', '#8', '::1', '2026-10-20 03:40:55'),
(126, 2, 'INQUIRY_ACCEPTED', '#8', '::1', '2026-10-20 03:43:56'),
(127, 2, 'QUOTATION_CREATED', '#6', '::1', '2026-10-20 03:45:05'),
(128, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00006', '::1', '2026-10-20 03:45:16'),
(129, 12, 'QUOTATION_APPROVED', 'Q-2026-00006', '::1', '2026-10-20 03:47:03'),
(130, 12, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00006', '::1', '2026-10-20 03:47:33'),
(131, 2, 'PAYMENT_CONFIRMED', '#6', '::1', '2026-10-20 03:47:47'),
(132, 2, 'RECEIPT_SENT', 'OR-2026-00006', '::1', '2026-10-20 03:47:51'),
(133, 12, 'INQUIRY_SUBMITTED', '#9,#10', '::1', '2026-10-20 04:11:42'),
(134, 2, 'INQUIRY_ACCEPTED', '#9', '::1', '2026-10-20 04:12:15'),
(135, 2, 'QUOTATION_CREATED', '#7', '::1', '2026-10-20 04:15:27'),
(136, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00007', '::1', '2026-10-20 04:15:47'),
(137, 12, 'QUOTATION_DECLINED', 'Q-2026-00007 (cancel)', '::1', '2026-10-20 04:16:38'),
(138, 2, 'INQUIRY_ACCEPTED', '#10', '::1', '2026-10-20 04:17:05'),
(139, 2, 'QUOTATION_CREATED', '#8', '::1', '2026-10-20 04:18:44'),
(140, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00008', '::1', '2026-10-20 04:18:51'),
(141, 12, 'QUOTATION_APPROVED', 'Q-2026-00008', '::1', '2026-10-20 04:19:11'),
(142, 12, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00008', '::1', '2026-10-20 04:20:09'),
(143, 2, 'PAYMENT_CONFIRMED', '#7', '::1', '2026-10-20 04:20:52'),
(144, 2, 'RECEIPT_SENT', 'OR-2026-00007', '::1', '2026-10-20 04:20:56'),
(145, 2, 'INSTALL_STARTED', 'project #5', '::1', '2026-10-20 04:21:31'),
(146, 2, 'INSTALLATION_COMPLETE', 'project #5 -> Done', '::1', '2026-10-20 04:21:37'),
(147, 2, 'CERTIFICATE_SENT', 'project #5', '::1', '2026-10-20 04:22:09'),
(148, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-20 23:58:00'),
(149, 12, 'LOGOUT', '', '::1', '2026-10-20 23:59:00'),
(150, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-20 23:59:20'),
(151, 2, 'LOGOUT', '', '::1', '2026-10-20 23:59:34'),
(152, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 00:01:08'),
(153, 1, 'LOGOUT', '', '::1', '2026-10-21 00:50:08'),
(154, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 00:50:26'),
(155, 12, 'LOGOUT', '', '::1', '2026-10-21 02:20:31'),
(156, 13, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 05:05:18'),
(157, 13, 'LOGOUT', '', '::1', '2026-10-21 05:05:30'),
(158, 14, 'PASSWORD_RESET', 'Password reset by email link', '::1', '2026-10-21 05:19:28'),
(159, 14, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 05:19:44'),
(160, 14, 'LOGOUT', '', '::1', '2026-10-21 05:19:49'),
(161, 12, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 05:37:31'),
(162, 12, 'LOGOUT', '', '::1', '2026-10-21 06:01:42'),
(163, 16, 'EMAIL_VERIFIED', 'Email verified with code', '::1', '2026-10-21 06:14:13'),
(164, 16, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 06:14:56'),
(165, 16, 'LOGOUT', '', '::1', '2026-10-21 06:15:06'),
(166, 17, 'EMAIL_VERIFIED', 'Email verified with code', '::1', '2026-10-21 06:18:16'),
(167, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 06:18:48'),
(168, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 06:29:09'),
(169, 1, 'LOGOUT', '', '::1', '2026-10-21 06:51:49'),
(170, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 06:54:59'),
(171, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 07:26:21'),
(172, 1, 'LOGOUT', '', '::1', '2026-10-21 07:31:16'),
(173, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 07:31:47'),
(174, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 07:33:31'),
(175, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 08:21:42'),
(176, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 09:06:30'),
(177, 17, 'LOGOUT', '', '::1', '2026-10-21 09:07:55'),
(178, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 09:25:45'),
(179, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 09:26:51'),
(180, 2, 'LOGOUT', '', '::1', '2026-10-21 09:58:20'),
(181, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 10:11:31'),
(182, 17, 'LOGOUT', '', '::1', '2026-10-21 10:14:13'),
(183, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 11:00:18'),
(184, 17, 'INQUIRY_SUBMITTED', '#11,#12', '::1', '2026-10-21 11:03:47'),
(185, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 11:15:13'),
(186, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 11:16:19'),
(187, 17, 'LOGOUT', '', '::1', '2026-10-21 11:17:06'),
(188, 1, 'LOGOUT', '', '::1', '2026-10-21 11:17:23'),
(189, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 11:17:56'),
(190, 2, 'LOGOUT', '', '::1', '2026-10-21 11:18:42'),
(191, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 11:19:23'),
(192, 1, 'LOGOUT', '', '::1', '2026-10-21 11:19:26'),
(193, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 11:21:53'),
(194, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 11:51:40'),
(195, 14, 'PASSWORD_RESET', 'Password reset by email link', '::1', '2026-10-21 12:05:44'),
(196, 14, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 12:06:16'),
(197, 14, 'INQUIRY_SUBMITTED', '#13', '::1', '2026-10-21 12:07:34'),
(198, 14, 'INQUIRY_SUBMITTED', '#14', '::1', '2026-10-21 12:10:01'),
(199, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 12:11:12'),
(200, 2, 'INQUIRY_ACCEPTED', '#13', '::1', '2026-10-21 12:11:44'),
(201, 2, 'INQUIRY_REJECTED', '#14 (Outside service area (mainland Luzon only))', '::1', '2026-10-21 12:12:01'),
(202, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #13', '::1', '2026-10-21 12:13:55'),
(203, 2, 'SITE_VISIT_DONE', 'inquiry #13', '::1', '2026-10-21 12:14:01'),
(204, 2, 'QUOTATION_CREATED', '#9', '::1', '2026-10-21 12:22:19'),
(205, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 12:23:27'),
(206, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00009', '::1', '2026-10-21 12:23:58'),
(207, 14, 'QUOTATION_APPROVED', 'Q-2026-00009', '::1', '2026-10-21 12:25:42'),
(208, 14, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00009', '::1', '2026-10-21 12:26:11'),
(209, 2, 'PAYMENT_CONFIRMED', '#8', '::1', '2026-10-21 12:27:28'),
(210, 2, 'RECEIPT_SENT', 'OR-2026-00008', '::1', '2026-10-21 12:27:38'),
(211, 14, 'PROFILE_UPDATE', '', '::1', '2026-10-21 12:31:31'),
(212, 2, 'LOGOUT', '', '::1', '2026-10-21 12:33:39'),
(213, 14, 'LOGOUT', '', '::1', '2026-10-21 12:33:46'),
(214, 1, 'LOGOUT', '', '::1', '2026-10-21 12:34:10'),
(215, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 13:09:00'),
(216, 2, 'LOGOUT', '', '::1', '2026-10-21 13:09:17'),
(217, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 13:09:55'),
(218, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 16:23:35'),
(219, 17, 'LOGOUT', '', '::1', '2026-10-21 16:24:07'),
(220, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 16:39:24'),
(221, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 16:54:18'),
(222, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 16:56:08'),
(223, 17, 'LOGOUT', '', '::1', '2026-10-21 16:57:33'),
(224, 18, 'EMAIL_VERIFIED', 'Email verified with code', '::1', '2026-10-21 18:15:59'),
(225, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 18:16:09'),
(226, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-21 18:17:51'),
(227, 18, 'INQUIRY_SUBMITTED', '#15,#16', '::1', '2026-10-21 18:23:07'),
(228, 2, 'INQUIRY_ACCEPTED', '#16', '::1', '2026-10-21 18:23:28'),
(229, 2, 'INQUIRY_ACCEPTED', '#15', '::1', '2026-10-21 18:23:33'),
(230, 2, 'QUOTATION_CREATED', '#10', '::1', '2026-10-21 18:31:20'),
(231, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 18:32:41'),
(232, 1, 'QUOTATION_EDITED_OWNER', '#10', '::1', '2026-10-21 18:35:05'),
(233, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00010', '::1', '2026-10-21 18:35:08'),
(234, 2, 'INQUIRY_ACCEPTED', '#12', '::1', '2026-10-21 18:36:51'),
(235, 2, 'QUOTATION_CREATED', '#11', '::1', '2026-10-21 18:39:14'),
(236, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00011', '::1', '2026-10-21 18:40:43'),
(237, 18, 'QUOTATION_APPROVED', 'Q-2026-00010', '::1', '2026-10-21 18:43:54'),
(238, 18, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00010', '::1', '2026-10-21 18:48:45'),
(239, 2, 'PAYMENT_CONFIRMED', '#10', '::1', '2026-10-21 18:51:39'),
(240, 2, 'RECEIPT_SENT', 'OR-2026-00010', '::1', '2026-10-21 18:52:15'),
(241, 2, 'INSTALL_STARTED', 'project #7', '::1', '2026-10-21 18:56:34'),
(242, 2, 'INSTALLATION_COMPLETE', 'project #7 -> Awaiting Final Payment', '::1', '2026-10-21 18:58:34'),
(243, 18, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00010', '::1', '2026-10-21 19:00:50'),
(244, 2, 'CERTIFICATE_SENT', 'project #7', '::1', '2026-10-21 19:04:08'),
(245, 2, 'CERTIFICATE_SENT', 'project #7', '::1', '2026-10-21 19:04:21'),
(246, 2, 'PAYMENT_CONFIRMED', '#11', '::1', '2026-10-21 19:04:29'),
(247, 2, 'RECEIPT_SENT', 'OR-2026-00011', '::1', '2026-10-21 19:04:47'),
(248, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-21 19:18:51'),
(249, 2, 'AVAILABILITY_CHANGED', '2026-10-23', '::1', '2026-10-21 19:27:22'),
(250, 2, 'SCHEDULE_MOVED', '#11', '::1', '2026-10-21 19:29:17'),
(251, 2, 'PRODUCT_RESTORED', '2-Door Access Control Package', '::1', '2026-10-21 19:33:37'),
(252, 18, 'LOGOUT', '', '::1', '2026-10-21 19:33:48'),
(253, 2, 'PRODUCT_RESTORED', '4-Camera Home CCTV Package', '::1', '2026-10-21 19:34:11'),
(254, 2, 'PRODUCT_ARCHIVED', '2-Door Access Control Package', '::1', '2026-10-21 19:35:40'),
(255, 2, 'PRODUCT_ARCHIVED', '4-Camera Home CCTV Package', '::1', '2026-10-21 19:35:47'),
(256, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 19:53:34'),
(257, 18, 'LOGOUT', '', '::1', '2026-10-21 19:55:21'),
(258, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-21 20:38:12'),
(259, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 02:57:44'),
(260, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 03:01:07'),
(261, 2, 'INQUIRY_ACCEPTED', '#11', '::1', '2026-10-22 03:01:38'),
(262, 2, 'QUOTATION_CREATED', '#12', '::1', '2026-10-22 03:02:52'),
(263, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 03:04:03'),
(264, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00012', '::1', '2026-10-22 03:04:23'),
(265, 17, 'QUOTATION_APPROVED', 'Q-2026-00012', '::1', '2026-10-22 03:05:31'),
(266, 17, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00012', '::1', '2026-10-22 03:07:37'),
(267, 2, 'PAYMENT_CONFIRMED', '#12', '::1', '2026-10-22 03:08:14'),
(268, 2, 'RECEIPT_SENT', 'OR-2026-00012', '::1', '2026-10-22 03:08:23'),
(269, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #16', '::1', '2026-10-22 03:08:44'),
(270, 2, 'SITE_VISIT_DONE', 'inquiry #16', '::1', '2026-10-22 03:08:48'),
(271, 2, 'QUOTATION_CREATED', '#13', '::1', '2026-10-22 03:09:46'),
(272, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00013', '::1', '2026-10-22 03:10:01'),
(273, 17, 'LOGOUT', '', '::1', '2026-10-22 03:10:18'),
(274, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 03:10:38'),
(275, 18, 'QUOTATION_APPROVED', 'Q-2026-00013', '::1', '2026-10-22 03:10:59'),
(276, 18, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00013', '::1', '2026-10-22 03:11:16'),
(277, 2, 'PAYMENT_CONFIRMED', '#13', '::1', '2026-10-22 03:11:27'),
(278, 2, 'RECEIPT_SENT', 'OR-2026-00013', '::1', '2026-10-22 03:11:35'),
(279, 2, 'INSTALL_STARTED', 'project #9', '::1', '2026-10-22 03:11:41'),
(280, 2, 'INSTALLATION_COMPLETE', 'project #9 -> Awaiting Final Payment', '::1', '2026-10-22 03:11:45'),
(281, 18, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00013', '::1', '2026-10-22 03:12:18'),
(282, 2, 'PAYMENT_CONFIRMED', '#14', '::1', '2026-10-22 03:12:31'),
(283, 2, 'RECEIPT_SENT', 'OR-2026-00014', '::1', '2026-10-22 03:12:44'),
(284, 2, 'DOCUMENT_SENT', 'Memorandum of Agreement for project #9', '::1', '2026-10-22 03:13:04'),
(285, 2, 'DOCUMENT_SENT', 'Job Order for project #9', '::1', '2026-10-22 03:13:08'),
(286, 2, 'CERTIFICATE_SENT', 'project #9', '::1', '2026-10-22 03:13:51'),
(287, 2, 'RECEIPT_SENT', 'OR-2026-00014', '::1', '2026-10-22 03:17:06'),
(288, 18, 'INQUIRY_SUBMITTED', '#17', '::1', '2026-10-22 03:24:12'),
(289, 2, 'INQUIRY_ACCEPTED', '#17', '::1', '2026-10-22 03:24:44'),
(290, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #17', '::1', '2026-10-22 03:24:55'),
(291, 2, 'SITE_VISIT_DONE', 'inquiry #17', '::1', '2026-10-22 03:24:59'),
(292, 2, 'QUOTATION_CREATED', '#14', '::1', '2026-10-22 03:25:50'),
(293, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00014', '::1', '2026-10-22 03:26:07'),
(294, 18, 'QUOTATION_APPROVED', 'Q-2026-00014', '::1', '2026-10-22 03:26:44'),
(295, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 05:41:09'),
(296, 17, 'SCHEDULE_CHANGED_CUSTOMER', '#13 -> 2026-10-23 3:30 PM', '::1', '2026-10-22 05:41:44'),
(297, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 05:42:14'),
(298, 2, 'SCHEDULE_MOVED', '#13', '::1', '2026-10-22 05:43:08'),
(299, 2, 'SCHEDULE_MOVED', '#16', '::1', '2026-10-22 05:44:30'),
(300, 17, 'LOGOUT', '', '::1', '2026-10-22 05:44:36'),
(301, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 05:45:02'),
(302, 18, 'SCHEDULE_CHANGED_CUSTOMER', '#16 -> 2026-10-28 1:20 PM', '::1', '2026-10-22 05:46:14'),
(303, 2, 'SCHEDULE_CONFIRMED', '#16', '::1', '2026-10-22 05:46:28'),
(304, 2, 'AVAILABILITY_BULK', '2026-10-28..2026-12-31 add (56 days)', '::1', '2026-10-22 05:48:22'),
(305, 2, 'AVAILABILITY_CHANGED', '2026-10-29', '::1', '2026-10-22 05:49:11'),
(306, 2, 'PRODUCT_PRICE', 'Exit Push Button: 350.00 -> 400', '::1', '2026-10-22 05:50:49'),
(307, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 05:51:14'),
(308, 1, 'LOGOUT', '', '::1', '2026-10-22 05:57:20'),
(309, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 05:58:02'),
(310, 2, 'LOGOUT', '', '::1', '2026-10-22 05:59:50'),
(311, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 06:00:27'),
(312, 1, 'PASSWORD_CHANGE', '', '::1', '2026-10-22 06:03:36'),
(313, 1, 'LOGOUT', '', '::1', '2026-10-22 06:03:43'),
(314, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 06:04:16'),
(315, 1, 'LOGOUT', '', '::1', '2026-10-22 06:04:30'),
(316, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 06:05:02'),
(317, 2, 'PASSWORD_CHANGE', '', '::1', '2026-10-22 06:05:22'),
(318, 2, 'LOGOUT', '', '::1', '2026-10-22 06:05:29'),
(319, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 06:05:51'),
(320, 2, 'LOGOUT', '', '::1', '2026-10-22 06:05:56'),
(321, 18, 'LOGOUT', '', '::1', '2026-10-22 06:06:00'),
(322, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 10:57:56'),
(323, 2, 'AVAILABILITY_CHANGED', '2026-10-27', '::1', '2026-10-22 10:58:44'),
(324, 2, 'LOGOUT', '', '::1', '2026-10-22 11:07:39'),
(325, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 11:08:52'),
(326, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 11:14:17'),
(327, 2, 'AVAILABILITY_BULK', '2026-10-23..2027-02-05 add (91 days)', '::1', '2026-10-22 11:15:23'),
(328, 2, 'AVAILABILITY_BULK', '2026-10-23..2027-07-30 add (241 days)', '::1', '2026-10-22 11:15:53'),
(329, 18, 'INQUIRY_SUBMITTED', '#18', '::1', '2026-10-22 11:23:16'),
(330, 2, 'INQUIRY_ACCEPTED', '#18', '::1', '2026-10-22 11:23:38'),
(331, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #18', '::1', '2026-10-22 11:23:52'),
(332, 2, 'SITE_VISIT_DONE', 'inquiry #18', '::1', '2026-10-22 11:23:58'),
(333, 2, 'QUOTATION_CREATED', '#15', '::1', '2026-10-22 11:25:01'),
(334, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 11:25:32'),
(335, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00015', '::1', '2026-10-22 11:25:45'),
(336, 18, 'QUOTATION_APPROVED', 'Q-2026-00015', '::1', '2026-10-22 11:26:51'),
(337, 18, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00015', '::1', '2026-10-22 11:29:09'),
(338, 2, 'PAYMENT_CONFIRMED', '#17', '::1', '2026-10-22 11:29:44'),
(339, 20, 'EMAIL_VERIFIED', 'Email verified with code', '::1', '2026-10-22 11:39:20'),
(340, 20, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 11:39:31'),
(341, 2, 'LOGOUT', '', '::1', '2026-10-22 11:39:47'),
(342, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 11:40:25'),
(343, 20, 'INQUIRY_SUBMITTED', '#19', '::1', '2026-10-22 11:49:49'),
(344, 2, 'INQUIRY_ACCEPTED', '#19', '::1', '2026-10-22 11:51:25'),
(345, 2, 'QUOTATION_CREATED', '#16', '::1', '2026-10-22 11:58:49'),
(346, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 11:59:42'),
(347, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00016', '::1', '2026-10-22 12:00:35'),
(348, 20, 'QUOTATION_APPROVED', 'Q-2026-00016', '::1', '2026-10-22 12:03:10'),
(349, 20, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00016', '::1', '2026-10-22 12:04:52'),
(350, 2, 'PAYMENT_CONFIRMED', '#19', '::1', '2026-10-22 12:06:23'),
(351, 2, 'RECEIPT_SENT', 'OR-2026-00019', '::1', '2026-10-22 12:06:56'),
(352, 2, 'INSTALL_STARTED', 'project #12', '::1', '2026-10-22 12:09:36'),
(353, 2, 'INSTALLATION_COMPLETE', 'project #12 -> Awaiting Final Payment', '::1', '2026-10-22 12:10:02'),
(354, 2, 'PAYMENT_CONFIRMED', '#20', '::1', '2026-10-22 12:10:18'),
(355, 2, 'RECEIPT_SENT', 'OR-2026-00019', '::1', '2026-10-22 12:11:04'),
(356, 2, 'RECEIPT_SENT', 'OR-2026-00020', '::1', '2026-10-22 12:11:05'),
(357, 2, 'DOCUMENT_SENT', 'Memorandum of Agreement for project #12', '::1', '2026-10-22 12:11:09'),
(358, 2, 'DOCUMENT_SENT', 'Job Order for project #12', '::1', '2026-10-22 12:11:18'),
(359, 2, 'CERTIFICATE_SENT', 'project #12', '::1', '2026-10-22 12:12:17'),
(360, 2, 'CERTIFICATE_SENT', 'project #12', '::1', '2026-10-22 12:12:23'),
(361, 2, 'PRODUCT_ARCHIVED', 'Biometric Access Terminal', '::1', '2026-10-22 12:21:11'),
(362, 2, 'PRODUCT_RESTORED', 'Biometric Access Terminal', '::1', '2026-10-22 12:21:23'),
(363, 20, 'LOGOUT', '', '::1', '2026-10-22 12:32:33'),
(364, 1, 'LOGOUT', '', '::1', '2026-10-22 12:39:37'),
(365, 2, 'LOGOUT', '', '::1', '2026-10-22 12:40:25'),
(366, 21, 'EMAIL_VERIFIED', 'Email verified with code', '::1', '2026-10-22 13:46:15'),
(367, 21, 'LOGIN', 'Signed in as customer', '::1', '2026-10-22 13:49:16'),
(368, 21, 'INQUIRY_SUBMITTED', '#20,#21', '::1', '2026-10-22 14:03:51'),
(369, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-22 14:05:18'),
(370, 2, 'INQUIRY_ACCEPTED', '#21', '::1', '2026-10-22 14:06:44'),
(371, 2, 'INQUIRY_REJECTED', '#20 (Outside service area (mainland Luzon only))', '::1', '2026-10-22 14:08:13'),
(372, 2, 'INQUIRY_REJECTED', '#21 (Outside service area (mainland Luzon only))', '::1', '2026-10-22 14:09:17'),
(373, 21, 'INQUIRY_SUBMITTED', '#22,#23', '::1', '2026-10-22 14:12:15'),
(374, 2, 'INQUIRY_ACCEPTED', '#23', '::1', '2026-10-22 14:12:33'),
(375, 2, 'INQUIRY_ACCEPTED', '#22', '::1', '2026-10-22 14:12:47'),
(376, 2, 'QUOTATION_CREATED', '#17', '::1', '2026-10-22 14:19:25'),
(377, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-22 14:21:02'),
(378, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00017', '::1', '2026-10-22 14:22:19'),
(379, 21, 'QUOTATION_DECLINED', 'Q-2026-00017 (revise)', '::1', '2026-10-22 14:23:45'),
(380, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #23', '::1', '2026-10-22 14:24:42'),
(381, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #23', '::1', '2026-10-22 14:24:49'),
(382, 2, 'SITE_VISIT_DONE', 'inquiry #23', '::1', '2026-10-22 14:24:56'),
(383, 2, 'QUOTATION_CREATED', '#18', '::1', '2026-10-22 14:25:42'),
(384, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00018', '::1', '2026-10-22 14:26:05'),
(385, 21, 'QUOTATION_APPROVED', 'Q-2026-00018', '::1', '2026-10-22 14:27:24'),
(386, 21, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00018', '::1', '2026-10-22 14:30:09'),
(387, 2, 'PAYMENT_CONFIRMED', '#21', '::1', '2026-10-22 14:31:00'),
(388, 2, 'RECEIPT_SENT', 'OR-2026-00021', '::1', '2026-10-22 14:31:24'),
(389, 2, 'INSTALL_STARTED', 'project #13', '::1', '2026-10-22 14:31:53'),
(390, 2, 'INSTALLATION_COMPLETE', 'project #13 -> Awaiting Final Payment', '::1', '2026-10-22 14:32:17'),
(391, 2, 'CERTIFICATE_SENT', 'project #13', '::1', '2026-10-22 14:33:46'),
(392, 2, 'CERTIFICATE_SENT', 'project #13', '::1', '2026-10-22 14:33:52'),
(393, 2, 'CERTIFICATE_SENT', 'project #13', '::1', '2026-10-22 14:33:58'),
(394, 21, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00018', '::1', '2026-10-22 14:34:47'),
(395, 2, 'PAYMENT_CONFIRMED', '#22', '::1', '2026-10-22 14:34:56'),
(396, 1, 'LOGOUT', '', '::1', '2026-10-22 14:48:01'),
(397, 18, 'LOGIN', 'Signed in as customer', '::1', '2026-10-23 21:29:41'),
(398, 18, 'LOGOUT', '', '::1', '2026-10-23 21:55:05'),
(399, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-23 22:11:39'),
(400, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 00:35:23'),
(401, 17, 'INQUIRY_SUBMITTED', '#24', '::1', '2026-10-24 00:38:06'),
(402, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-24 00:39:26'),
(403, 2, 'INQUIRY_ACCEPTED', '#24', '::1', '2026-10-24 00:39:50'),
(404, 17, 'LOGOUT', '', '::1', '2026-10-24 00:40:24'),
(405, 14, 'PASSWORD_RESET', 'Password reset by email link', '::1', '2026-10-24 00:42:58'),
(406, 14, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 00:43:18'),
(407, 14, 'INQUIRY_SUBMITTED', '#25', '::1', '2026-10-24 00:44:07'),
(408, 14, 'LOGOUT', '', '::1', '2026-10-24 00:46:57'),
(409, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-24 00:50:46'),
(410, 14, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 00:52:32'),
(411, 14, 'INQUIRY_CANCELLED', '#25 (Schedule doesn\'t work)', '::1', '2026-10-24 00:53:12'),
(412, 14, 'INQUIRY_SUBMITTED', '#26', '::1', '2026-10-24 00:55:12'),
(413, 2, 'INQUIRY_ACCEPTED', '#26', '::1', '2026-10-24 00:55:41'),
(414, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-24 01:03:54'),
(415, 1, 'EXPENSE_ADDED', 'Maintenance & Repair 800', '::1', '2026-10-24 01:09:48'),
(416, 1, 'EXPENSE_VOIDED', '#1 (Wrong amount)', '::1', '2026-10-24 01:10:58'),
(417, 1, 'LOGOUT', '', '::1', '2026-10-24 01:39:41'),
(418, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #26', '::1', '2026-10-24 01:42:32'),
(419, 2, 'SITE_VISIT_DONE', 'inquiry #26', '::1', '2026-10-24 01:42:49'),
(420, 2, 'QUOTATION_CREATED', '#19', '::1', '2026-10-24 01:46:25'),
(421, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-24 01:47:15'),
(422, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00019', '::1', '2026-10-24 01:47:45'),
(423, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 01:49:06'),
(424, 17, 'INQUIRY_SUBMITTED', '#27', '::1', '2026-10-24 01:50:09'),
(425, 17, 'LOGOUT', '', '::1', '2026-10-24 01:59:21'),
(426, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 03:25:11'),
(427, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-24 03:26:03'),
(428, 1, 'LOGOUT', '', '::1', '2026-10-24 03:27:21'),
(429, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-24 03:28:07'),
(430, 2, 'LOGOUT', '', '::1', '2026-10-24 04:10:21'),
(431, 22, 'EMAIL_VERIFIED', 'Email verified with code', '::1', '2026-10-24 04:20:40'),
(432, 22, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 04:22:12'),
(433, 22, 'INQUIRY_SUBMITTED', '#28,#29', '::1', '2026-10-24 04:25:09'),
(434, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-24 04:26:33'),
(435, 2, 'INQUIRY_ACCEPTED', '#29', '::1', '2026-10-24 04:27:38'),
(436, 2, 'SITE_VISIT_CONFIRMED', 'inquiry #29', '::1', '2026-10-24 04:27:48'),
(437, 2, 'SITE_VISIT_DONE', 'inquiry #29', '::1', '2026-10-24 04:27:53'),
(438, 2, 'QUOTATION_CREATED', '#20', '::1', '2026-10-24 04:30:04'),
(439, 22, 'INQUIRY_SUBMITTED', '#30', '::1', '2026-10-24 04:31:55'),
(440, 22, 'INQUIRY_SUBMITTED', '#31', '::1', '2026-10-24 04:33:20'),
(441, 2, 'INQUIRY_ACCEPTED', '#30', '::1', '2026-10-24 04:36:49'),
(442, 2, 'QUOTATION_CREATED', '#21', '::1', '2026-10-24 04:38:59'),
(443, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-24 04:39:47'),
(444, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00020', '::1', '2026-10-24 04:40:19'),
(445, 22, 'QUOTATION_APPROVED', 'Q-2026-00020', '::1', '2026-10-24 04:40:53'),
(446, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00021', '::1', '2026-10-24 04:45:59'),
(447, 22, 'QUOTATION_APPROVED', 'Q-2026-00021', '::1', '2026-10-24 04:47:33'),
(448, 22, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00021', '::1', '2026-10-24 04:53:06'),
(449, 2, 'PAYMENT_CONFIRMED', '#25', '::1', '2026-10-24 04:53:42'),
(450, 2, 'RECEIPT_SENT', 'OR-2026-00025', '::1', '2026-10-24 04:53:51'),
(451, 2, 'EXPENSE_ADDED', 'project #15 Labor & Personnel 10000', '::1', '2026-10-24 04:54:23'),
(452, 22, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00020', '::1', '2026-10-24 04:55:01'),
(453, 22, 'SCHEDULE_CHANGED_CUSTOMER', '#27 -> 2026-10-30 3:30 PM', '::1', '2026-10-24 04:56:18'),
(454, 2, 'INSTALL_STARTED', 'project #15', '::1', '2026-10-24 04:56:41'),
(455, 2, 'INSTALLATION_COMPLETE', 'project #15 -> Awaiting Final Payment', '::1', '2026-10-24 04:56:46'),
(456, 22, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00021', '::1', '2026-10-24 04:57:41'),
(457, 2, 'PAYMENT_CONFIRMED', '#26', '::1', '2026-10-24 04:57:49'),
(458, 2, 'RECEIPT_SENT', 'OR-2026-00026', '::1', '2026-10-24 04:57:56'),
(459, 2, 'CERTIFICATE_SENT', 'project #15 (project done)', '::1', '2026-10-24 04:58:27'),
(460, 2, 'LOGIN', 'Signed in as admin', '::1', '2026-10-24 07:47:58'),
(461, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-24 07:48:20'),
(462, 17, 'LOGIN', 'Signed in as customer', '::1', '2026-10-24 07:49:57'),
(463, 17, 'INQUIRY_SUBMITTED', '#32,#33', '::1', '2026-10-24 07:54:01'),
(464, 2, 'INQUIRY_CHANGES_REQUESTED', '#33 (Budget does not cover the request)', '::1', '2026-10-24 07:56:56'),
(465, 2, 'INQUIRY_ACCEPTED', '#32', '::1', '2026-10-24 07:57:18'),
(466, 17, 'INQUIRY_SUBMITTED', '#34', '::1', '2026-10-24 08:00:27'),
(467, 2, 'INQUIRY_CHANGES_REQUESTED', '#34 (Outside our service area)', '::1', '2026-10-24 08:00:52'),
(468, 17, 'INQUIRY_UPDATED', '#33', '::1', '2026-10-24 08:04:04'),
(469, 2, 'INQUIRY_ACCEPTED', '#33', '::1', '2026-10-24 08:04:23'),
(470, 1, 'MARKUP_CHANGED', '20% -> 20%', '::1', '2026-10-24 08:08:40'),
(471, 1, 'MARKUP_CHANGED', '20% -> 20%', '::1', '2026-10-24 08:14:46'),
(472, 1, 'MARKUP_CHANGED', '20% -> 20%', '::1', '2026-10-24 08:19:00'),
(473, 1, 'MARKUP_CHANGED', '20% -> 20%', '::1', '2026-10-24 08:19:02'),
(474, 2, 'QUOTATION_CREATED', '#22', '::1', '2026-10-24 08:20:33'),
(475, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00022', '::1', '2026-10-24 08:21:01'),
(476, 17, 'QUOTATION_APPROVED', 'Q-2026-00022', '::1', '2026-10-24 08:22:15'),
(477, 17, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00022', '::1', '2026-10-24 08:22:44'),
(478, 2, 'EXPENSE_ADDED', 'project #16 Labor & Personnel 5000', '::1', '2026-10-24 08:23:56'),
(479, 2, 'PAYMENT_CONFIRMED', '#27', '::1', '2026-10-24 08:24:57'),
(480, 2, 'RECEIPT_SENT', 'OR-2026-00027', '::1', '2026-10-24 08:25:06'),
(481, 2, 'INSTALL_STARTED', 'project #16', '::1', '2026-10-24 08:25:18'),
(482, 2, 'INSTALLATION_COMPLETE', 'project #16 -> Installation In Progress', '::1', '2026-10-24 08:25:23'),
(483, 2, 'CERTIFICATE_SENT', 'project #16 (project done)', '::1', '2026-10-24 08:27:06'),
(484, 2, 'CERTIFICATE_SENT', 'project #16', '::1', '2026-10-24 08:27:12'),
(485, 17, 'INQUIRY_SUBMITTED', '#35', '::1', '2026-10-24 08:34:53'),
(486, 2, 'INQUIRY_ACCEPTED', '#35', '::1', '2026-10-24 08:35:16'),
(487, 17, 'INQUIRY_SUBMITTED', '#36,#37', '::1', '2026-10-24 09:16:11'),
(488, 2, 'SITE_VISIT_PROPOSED', 'inquiry #36 -> 2026-10-28 10:30 AM', '::1', '2026-10-24 09:16:44'),
(489, 2, 'INQUIRY_ACCEPTED', '#37', '::1', '2026-10-24 09:17:09'),
(490, 2, 'QUOTATION_CREATED', '#23', '::1', '2026-10-24 09:18:36'),
(491, 17, 'SCHEDULE_ACCEPTED', '#31', '::1', '2026-10-24 09:19:12'),
(492, 1, 'LOGIN', 'Signed in as superadmin', '::1', '2026-10-24 09:19:54'),
(493, 1, 'QUOTATION_APPROVED_OWNER', 'Q-2026-00023', '::1', '2026-10-24 09:20:03'),
(494, 17, 'QUOTATION_APPROVED', 'Q-2026-00023', '::1', '2026-10-24 09:20:37'),
(495, 17, 'PAYMENT_PROOF_UPLOADED', 'Q-2026-00023', '::1', '2026-10-24 09:20:52'),
(496, 2, 'PAYMENT_CONFIRMED', '#28', '::1', '2026-10-24 09:21:25'),
(497, 2, 'RECEIPT_SENT', 'OR-2026-00028', '::1', '2026-10-24 09:21:35'),
(498, 2, 'INSTALL_STARTED', 'project #17', '::1', '2026-10-24 09:21:41'),
(499, 2, 'INSTALLATION_COMPLETE', 'project #17 -> Installation In Progress', '::1', '2026-10-24 09:21:43'),
(500, 2, 'CERTIFICATE_SENT', 'project #17 (project done)', '::1', '2026-10-24 09:22:10'),
(501, 2, 'CERTIFICATE_SENT', 'project #17 (project done)', '::1', '2026-10-24 09:22:15'),
(502, 2, 'DOCUMENT_SENT', 'Memorandum of Agreement for project #17', '::1', '2026-10-24 09:23:18'),
(503, 2, 'DOCUMENT_SENT', 'Job Order for project #17', '::1', '2026-10-24 09:23:29'),
(504, 2, 'QUOTATION_CREATED', '#24', '::1', '2026-10-24 09:25:51'),
(505, 2, 'LOGOUT', '', '::1', '2026-10-24 09:26:01'),
(506, 1, 'LOGOUT', '', '::1', '2026-10-24 09:27:17'),
(507, 17, 'LOGOUT', '', '::1', '2026-10-24 09:27:29');

-- --------------------------------------------------------

--
-- Table structure for table `certificate_photos`
--

CREATE TABLE `certificate_photos` (
  `photo_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `caption` varchar(60) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `certificate_photos`
--

INSERT INTO `certificate_photos` (`photo_id`, `project_id`, `file_path`, `caption`, `created_at`) VALUES
(1, 1, 'certificates/d2e8854a0533db45bf37838e1332bea1.jpg', NULL, '2026-10-07 09:51:20'),
(4, 5, 'certificates/e5a2ff9e7f930bae4a875c6e2bc2621a.jpg', NULL, '2026-10-20 04:22:07'),
(5, 7, 'certificates/c2c9d1b8df3e8f5e84c8fbeb45a0f627.jpg', NULL, '2026-10-21 19:04:05'),
(6, 9, 'certificates/6b7fe51fa0035dd625679f0271ee1aa9.jpg', NULL, '2026-10-22 03:13:48'),
(7, 12, 'certificates/358c8eb962972a5cf33fe6a85fd47680.jpg', NULL, '2026-10-22 12:12:15'),
(8, 13, 'certificates/b397417eba672b24623b968444c63fc2.jpg', NULL, '2026-10-22 14:33:43'),
(9, 15, 'certificates/539fb25b416210e3d2dae35b408683f2.jpg', NULL, '2026-10-24 04:58:25'),
(10, 16, 'certificates/08f5dff118948d38105727251b63db6f.jpg', NULL, '2026-10-24 08:27:04'),
(11, 17, 'certificates/956c05f4727c3960e2c51ef93ba67497.jpg', NULL, '2026-10-24 09:22:01');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_name` varchar(120) DEFAULT NULL,
  `avatar_initials` varchar(4) DEFAULT NULL,
  `contact_name` varchar(120) DEFAULT NULL,
  `contact_role` varchar(50) DEFAULT NULL,
  `contact_email` varchar(120) DEFAULT NULL,
  `contact_phone` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `user_id`, `company_name`, `avatar_initials`, `contact_name`, `contact_role`, `contact_email`, `contact_phone`) VALUES
(1, 3, NULL, 'JD', NULL, NULL, NULL, NULL),
(2, 4, NULL, 'RD', NULL, NULL, NULL, NULL),
(3, 5, NULL, 'TJ', NULL, NULL, NULL, NULL),
(4, 6, NULL, 'JD', NULL, NULL, NULL, NULL),
(5, 7, NULL, 'RD', NULL, NULL, NULL, NULL),
(6, 8, NULL, 'AM', NULL, NULL, NULL, NULL),
(7, 9, NULL, 'AE', NULL, NULL, NULL, NULL),
(8, 10, NULL, 'DY', NULL, NULL, NULL, NULL),
(9, 11, NULL, 'AB', NULL, NULL, NULL, NULL),
(10, 12, NULL, 'JO', NULL, NULL, NULL, NULL),
(11, 13, NULL, 'JB', NULL, NULL, NULL, NULL),
(12, 14, NULL, 'RD', NULL, NULL, NULL, NULL),
(13, 15, NULL, 'CD', NULL, NULL, NULL, NULL),
(14, 16, NULL, 'CD', NULL, NULL, NULL, NULL),
(15, 17, NULL, 'JO', NULL, NULL, NULL, NULL),
(16, 18, NULL, 'AG', NULL, NULL, NULL, NULL),
(17, 19, NULL, 'JM', NULL, NULL, NULL, NULL),
(18, 20, NULL, 'AE', NULL, NULL, NULL, NULL),
(19, 21, NULL, 'DY', NULL, NULL, NULL, NULL),
(20, 22, NULL, 'HS', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_activity_logs`
--

CREATE TABLE `customer_activity_logs` (
  `log_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `activity_device` varchar(160) DEFAULT NULL,
  `location` varchar(60) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_activity_logs`
--

INSERT INTO `customer_activity_logs` (`log_id`, `customer_id`, `activity_device`, `location`, `status`, `timestamp`) VALUES
(1, 1, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 06:20:16'),
(2, 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 07:08:04'),
(3, 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 09:18:36'),
(4, 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 09:47:18'),
(5, 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 10:20:04'),
(6, 4, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 12:24:29'),
(7, 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 12:27:53'),
(8, 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 12:31:14'),
(9, 3, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 12:55:04'),
(10, 9, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 13:18:40'),
(11, 9, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-07 14:04:16'),
(12, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-19 11:27:40'),
(13, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-19 11:44:33'),
(14, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-19 11:53:26'),
(15, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-19 12:10:50'),
(16, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-20 03:24:42'),
(17, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-20 23:58:00'),
(18, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 00:50:26'),
(19, 11, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 05:05:18'),
(20, 12, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 05:19:44'),
(21, 10, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 05:37:31'),
(22, 14, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 06:14:56'),
(23, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 06:18:48'),
(24, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 06:54:59'),
(25, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 07:31:47'),
(26, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 08:21:42'),
(27, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 09:06:30'),
(28, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 09:25:45'),
(29, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 10:11:31'),
(30, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 11:00:18'),
(31, 12, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 12:06:16'),
(32, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 13:09:55'),
(33, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 16:23:35'),
(34, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 16:39:24'),
(35, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 16:56:08'),
(36, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 18:16:09'),
(37, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 19:53:34'),
(38, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-21 20:38:12'),
(39, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 02:57:44'),
(40, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 03:10:38'),
(41, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 05:41:09'),
(42, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 05:45:02'),
(43, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 11:08:52'),
(44, 18, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 11:39:31'),
(45, 19, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-22 13:49:16'),
(46, 16, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-23 21:29:41'),
(47, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 00:35:23'),
(48, 12, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 00:43:18'),
(49, 12, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 00:52:32'),
(50, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 01:49:06'),
(51, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 03:25:11'),
(52, 20, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 04:22:12'),
(53, 15, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '::1', 'Login', '2026-10-24 07:49:57');

-- --------------------------------------------------------

--
-- Table structure for table `customer_documents`
--

CREATE TABLE `customer_documents` (
  `document_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `inquiry_id` int(11) DEFAULT NULL,
  `quotation_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `document_type` enum('Quotation','Receipt','Other') NOT NULL,
  `title` varchar(160) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `date_issued` date DEFAULT NULL,
  `status` varchar(30) DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_documents`
--

INSERT INTO `customer_documents` (`document_id`, `customer_id`, `inquiry_id`, `quotation_id`, `payment_id`, `document_type`, `title`, `file_path`, `date_issued`, `status`) VALUES
(1, 16, 16, 13, NULL, 'Other', 'Memorandum of Agreement - Allexis Grocery Store', 'project-documents/522a315ee1db84ab61f11b719021af29.pdf', '2026-10-22', 'Available'),
(2, 16, 16, 13, NULL, 'Other', 'Job Order - Allexis Grocery Store', 'project-documents/47507d265feb5d0b6f2dda2e0aba0951.pdf', '2026-10-22', 'Available'),
(3, 18, 19, 16, NULL, 'Other', 'Memorandum of Agreement - Library', 'project-documents/fb2978a1d7eaca7a52403e25889a7fa1.pdf', '2026-10-22', 'Available'),
(4, 18, 19, 16, NULL, 'Other', 'Job Order - Library', 'project-documents/51c6e834f4c5e1b3b4b5050fc341d3d3.pdf', '2026-10-22', 'Available'),
(5, 15, 37, 23, NULL, 'Other', 'Memorandum of Agreement - Jasper and his turtle', 'project-documents/7f90528eaf67cf35a8840a456c8c88be.pdf', '2026-10-24', 'Available'),
(6, 15, 37, 23, NULL, 'Other', 'Job Order - Jasper and his turtle', 'project-documents/dfceaae35e731b33352b6061636d03a7.pdf', '2026-10-24', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `email_codes`
--

CREATE TABLE `email_codes` (
  `code_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code_hash` char(64) NOT NULL,
  `tries` int(11) NOT NULL DEFAULT 0,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `sent_to` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_codes`
--

INSERT INTO `email_codes` (`code_id`, `user_id`, `code_hash`, `tries`, `expires_at`, `created_at`, `sent_to`) VALUES
(1, 15, '763b9ed58726d478cf6539f2192d6213c9d973d9c5ead2e6446fe0d23b6ae659', 0, '2026-10-21 06:12:48', '2026-10-21 06:02:48', NULL),
(6, 19, 'a3a0059e8f4304060080f4c85726c468b9b227783b9a028bda4c04cce02a7eb2', 0, '2026-10-22 03:07:09', '2026-10-22 02:57:09', 'johnmark18@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `summary_id` int(11) DEFAULT NULL,
  `category_name` varchar(80) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(14,2) NOT NULL,
  `expense_date` date NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'PHP',
  `payment_method` varchar(40) DEFAULT NULL,
  `reference_no` varchar(60) DEFAULT NULL,
  `recorded_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Active',
  `void_reason` varchar(255) DEFAULT NULL,
  `voided_at` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expense_id`, `summary_id`, `category_name`, `description`, `amount`, `expense_date`, `project_id`, `currency`, `payment_method`, `reference_no`, `recorded_by`, `created_at`, `updated_at`, `status`, `void_reason`, `voided_at`, `voided_by`) VALUES
(1, NULL, 'Maintenance & Repair', '4 cameras', 800.00, '2026-10-24', 5, 'PHP', NULL, NULL, 1, '2026-10-24 01:09:48', NULL, 'Void', 'Wrong amount', '2026-10-24 01:10:58', 1),
(2, NULL, 'Labor & Personnel', 'Cables and molding', 10000.00, '2026-10-24', 15, 'PHP', 'GCash', NULL, 2, '2026-10-24 04:54:23', NULL, 'Active', NULL, NULL, NULL),
(3, NULL, 'Labor & Personnel', 'Hardwares', 5000.00, '2026-10-24', 16, 'PHP', 'GCash', NULL, 2, '2026-10-24 08:23:56', NULL, 'Active', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expense_history`
--

CREATE TABLE `expense_history` (
  `history_id` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `action` varchar(10) NOT NULL,
  `details` text DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense_history`
--

INSERT INTO `expense_history` (`history_id`, `expense_id`, `action`, `details`, `changed_by`, `created_at`) VALUES
(1, 1, 'Added', 'Maintenance & Repair 800.00 on 2026-10-24', 1, '2026-10-24 01:09:48'),
(2, 1, 'Voided', 'Wrong amount', 1, '2026-10-24 01:10:58'),
(3, 2, 'Added', 'Labor & Personnel 10,000.00 on 2026-10-24', 2, '2026-10-24 04:54:23'),
(4, 3, 'Added', 'Labor & Personnel 5,000.00 on 2026-10-24', 2, '2026-10-24 08:23:56');

-- --------------------------------------------------------

--
-- Table structure for table `financial_summaries`
--

CREATE TABLE `financial_summaries` (
  `summary_id` int(11) NOT NULL,
  `month_year` varchar(7) NOT NULL,
  `gross_revenue` decimal(14,2) DEFAULT 0.00,
  `operating_expenses` decimal(14,2) DEFAULT 0.00,
  `net_profit` decimal(14,2) DEFAULT 0.00,
  `margin_percentage` decimal(6,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inquiry_items`
--

CREATE TABLE `inquiry_items` (
  `inquiry_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inquiry_items`
--

INSERT INTO `inquiry_items` (`inquiry_id`, `product_id`, `quantity`) VALUES
(2, 14, 1),
(4, 15, 1),
(5, 10, 1),
(5, 12, 1),
(6, 13, 1),
(8, 5, 1),
(8, 156, 1),
(9, 112, 1),
(10, 15, 1),
(11, 25, 1),
(11, 45, 1),
(12, 2, 1),
(12, 5, 1),
(12, 24, 1),
(12, 25, 1),
(14, 171, 1),
(15, 5, 1),
(19, 1, 1),
(19, 3, 1),
(21, 1, 1),
(21, 2, 1),
(21, 3, 1),
(21, 4, 1),
(21, 12, 1),
(21, 171, 1),
(22, 5, 1),
(22, 23, 1),
(22, 24, 1),
(22, 171, 1),
(24, 23, 1),
(24, 41, 1),
(24, 113, 1),
(24, 169, 1),
(24, 171, 1),
(27, 43, 1),
(27, 45, 1),
(27, 47, 1),
(28, 171, 1),
(30, 169, 1),
(30, 170, 1),
(30, 171, 1),
(33, 168, 1),
(33, 169, 1),
(34, 9, 1),
(34, 19, 1),
(34, 23, 1),
(34, 24, 1),
(34, 168, 1),
(34, 169, 1),
(34, 171, 1),
(35, 5, 1),
(35, 24, 1),
(35, 39, 1),
(37, 2, 1),
(37, 3, 1),
(37, 12, 1),
(37, 39, 1),
(37, 171, 1);

-- --------------------------------------------------------

--
-- Table structure for table `installation_schedules`
--

CREATE TABLE `installation_schedules` (
  `schedule_id` int(11) NOT NULL,
  `quotation_id` int(11) DEFAULT NULL,
  `inquiry_id` int(11) DEFAULT NULL,
  `technician_id` int(11) DEFAULT NULL,
  `scheduled_date` date NOT NULL,
  `time_slot` varchar(10) NOT NULL,
  `activity_type` enum('Site Inspection','Installation') NOT NULL,
  `status` enum('Requested','Confirmed','Completed','Cancelled') NOT NULL DEFAULT 'Requested',
  `notes` varchar(255) DEFAULT NULL,
  `active_key` varchar(30) GENERATED ALWAYS AS (if(`status` in ('Requested','Confirmed'),concat(`scheduled_date`,'|',`time_slot`),NULL)) STORED,
  `previous_date` date DEFAULT NULL,
  `previous_slot` varchar(10) DEFAULT NULL,
  `change_reason` varchar(255) DEFAULT NULL,
  `changed_at` datetime DEFAULT NULL,
  `proposed_by` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `installation_schedules`
--

INSERT INTO `installation_schedules` (`schedule_id`, `quotation_id`, `inquiry_id`, `technician_id`, `scheduled_date`, `time_slot`, `activity_type`, `status`, `notes`, `previous_date`, `previous_slot`, `change_reason`, `changed_at`, `proposed_by`) VALUES
(1, NULL, 1, NULL, '2026-10-21', '1:00 PM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 2, NULL, '2026-10-09', '1:00 PM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, 3, NULL, '2026-10-13', '9:00 AM', 'Site Inspection', 'Cancelled', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 3, 6, NULL, '2026-10-21', '1:00 PM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(5, NULL, 7, NULL, '2026-10-28', '1:20 PM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 5, 7, NULL, '2026-10-24', '3:30 PM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 6, 8, NULL, '2026-10-27', '10:30 AM', 'Installation', 'Confirmed', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 8, 10, NULL, '2026-10-28', '10:30 AM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(9, NULL, 13, NULL, '2026-10-23', '1:00 PM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 9, 13, NULL, '2026-10-23', '1:00 PM', 'Installation', 'Confirmed', NULL, NULL, NULL, NULL, NULL, NULL),
(11, NULL, 16, NULL, '2026-10-28', '1:00 PM', 'Site Inspection', 'Completed', 'Crew Unavailable', NULL, NULL, NULL, NULL, NULL),
(12, 10, 15, NULL, '2026-10-23', '3:20 PM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 12, 11, NULL, '2026-10-24', '1:00 PM', 'Installation', 'Confirmed', 'Proposed by BeyondWires', NULL, NULL, NULL, '2026-10-22 05:41:44', NULL),
(14, 13, 16, NULL, '2026-10-28', '9:00 AM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(15, NULL, 17, NULL, '2026-10-28', '10:30 AM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 14, 17, NULL, '2026-10-28', '1:20 PM', 'Installation', 'Confirmed', 'Customer reschedule: I am not home', NULL, NULL, NULL, '2026-10-22 05:46:14', NULL),
(17, NULL, 18, NULL, '2026-10-23', '10:30 AM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 15, 18, NULL, '2026-10-24', '10:30 AM', 'Installation', 'Confirmed', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 16, 19, NULL, '2026-11-06', '9:00 AM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(20, NULL, 20, NULL, '2026-10-26', '10:30 AM', 'Site Inspection', 'Cancelled', NULL, NULL, NULL, NULL, NULL, NULL),
(21, NULL, 23, NULL, '2026-10-27', '3:30 PM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 18, 23, NULL, '2026-10-23', '10:30 AM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(23, NULL, 25, NULL, '2026-10-28', '9:00 AM', 'Site Inspection', 'Cancelled', NULL, NULL, NULL, NULL, NULL, NULL),
(24, NULL, 26, NULL, '2026-10-29', '1:00 PM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(25, NULL, 29, NULL, '2026-12-04', '9:00 AM', 'Site Inspection', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(26, NULL, 31, NULL, '2026-10-31', '10:30 AM', 'Site Inspection', 'Requested', NULL, NULL, NULL, NULL, NULL, NULL),
(27, 20, 29, NULL, '2026-10-30', '3:30 PM', 'Installation', 'Requested', 'Customer reschedule: Emergency / personal matter', '2026-10-27', '3:30 PM', 'Emergency / personal matter', '2026-10-24 04:56:18', NULL),
(28, 21, 30, NULL, '2026-10-27', '9:00 AM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(29, NULL, 32, NULL, '2026-11-02', '9:00 AM', 'Site Inspection', 'Requested', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 22, 33, NULL, '2026-11-03', '3:30 PM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL),
(31, NULL, 36, NULL, '2026-10-28', '10:30 AM', 'Site Inspection', 'Confirmed', NULL, NULL, NULL, NULL, '2026-10-24 09:16:44', NULL),
(32, 23, 37, NULL, '2026-10-31', '3:30 PM', 'Installation', 'Completed', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `email` varchar(120) NOT NULL,
  `fails` int(11) NOT NULL DEFAULT 0,
  `lock_until` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`email`, `fails`, `lock_until`, `updated_at`) VALUES
('admin@beyondiwires.com', 1, NULL, '2026-10-24 00:39:07'),
('admin@beyondiwres.com', 1, NULL, '2026-10-24 00:38:51'),
('jasperolarte@gmail.com', 5, '2026-10-23 21:33:17', '2026-10-23 21:28:17'),
('owner@beoyndwires.com', 1, NULL, '2026-10-24 09:19:39'),
('owner@beyondwir', 5, '2026-10-21 11:26:12', '2026-10-21 11:21:12');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(120) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `link` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `title`, `message`, `is_read`, `timestamp`, `link`) VALUES
(1, 2, 'New inquiry', 'Inquiry #1 from Tender Juicy (Residential). Site visit requested.', 0, '2026-10-07 09:19:39', 'inquiry:1'),
(2, 2, 'New inquiry', 'Inquiry #2 from Tender Juicy (Commercial).', 0, '2026-10-07 09:19:39', 'inquiry:2'),
(3, 5, 'Inquiry received', '2 inquiries were received. Please wait for our acknowledgment.', 0, '2026-10-07 09:19:39', 'inquiry:1'),
(4, 5, 'Inquiry acknowledged', 'Your inquiry #2 has been accepted. We are preparing your quotation.', 0, '2026-10-07 09:41:34', 'inquiry:2'),
(5, 1, 'Quotation for approval', 'Q-2026-00001 is waiting for your approval.', 1, '2026-10-07 09:43:35', 'quotation:1'),
(6, 5, 'New quotation', 'Quotation Q-2026-00001 is ready for your review.', 0, '2026-10-07 09:44:47', 'quotation:1'),
(7, 2, 'Quotation approved', 'Q-2026-00001 was approved and sent to the customer.', 0, '2026-10-07 09:44:47', 'quotation:1'),
(8, 2, 'Quotation approved', 'Q-2026-00001 approved by customer. Payment: Full upon quotation (Online). Install request: 2026-10-09 1:00 PM.', 0, '2026-10-07 09:47:48', 'project:1'),
(9, 2, 'Payment proof uploaded', 'Tender Juicy uploaded proof for Q-2026-00001 (Full).', 0, '2026-10-07 09:49:06', 'project:1'),
(10, 5, 'Payment confirmed', 'Your Full for Q-2026-00001 was confirmed. Your receipt is being prepared.', 0, '2026-10-07 09:50:15', 'project:1'),
(11, 5, 'Receipt available', 'Service invoice OR-2026-00001 is now in your Documents.', 0, '2026-10-07 09:50:31', 'documents'),
(12, 5, 'Installation started', 'Our team has started your installation.', 0, '2026-10-07 09:50:40', 'project:1'),
(13, 5, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-07 09:50:47', 'project:1'),
(14, 5, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-07 09:51:22', 'documents'),
(15, 5, 'Inquiry acknowledged', 'Your inquiry #1 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-07 10:26:01', 'inquiry:1'),
(16, 5, 'Site visit confirmed', 'Your site visit is set for 2026-10-21 at 1:00 PM.', 0, '2026-10-07 10:26:08', 'inquiry:1'),
(17, 2, 'New inquiry', 'Inquiry #3 from john doe (Residential). Site visit requested.', 0, '2026-10-07 12:25:53', 'inquiry:3'),
(18, 6, 'Inquiry received', 'Inquiry #3 was received. Please wait for our acknowledgment.', 0, '2026-10-07 12:25:53', 'inquiry:3'),
(19, 6, 'Inquiry not accepted', 'Thank you for your interest in Beyond Wires. We currently serve Metro Manila (NCR) only, so we are unable to take on a project at your location.', 0, '2026-10-07 12:54:11', 'inquiry:3'),
(20, 5, 'Inquiry not accepted', 'Thank you for your interest in Beyond Wires. We currently serve Metro Manila (NCR) only, so we are unable to take on a project at your location.', 0, '2026-10-07 12:54:27', 'inquiry:1'),
(21, 2, 'New inquiry', 'Inquiry #4 from Allexis Benlota (Residential).', 0, '2026-10-07 13:23:44', 'inquiry:4'),
(22, 11, 'Inquiry received', 'Inquiry #4 was received. Please wait for our acknowledgment.', 0, '2026-10-07 13:23:44', 'inquiry:4'),
(23, 2, 'New inquiry', 'Inquiry #5 from Allexis Benlota (Commercial).', 0, '2026-10-07 13:27:56', 'inquiry:5'),
(24, 11, 'Inquiry received', 'Inquiry #5 was received. Please wait for our acknowledgment.', 0, '2026-10-07 13:27:56', 'inquiry:5'),
(25, 11, 'Inquiry acknowledged', 'Your inquiry #5 has been accepted. We are preparing your quotation.', 0, '2026-10-07 13:38:58', 'inquiry:5'),
(26, 1, 'Quotation for approval', 'Q-2026-00002 is waiting for your approval.', 0, '2026-10-07 13:47:32', 'quotation:2'),
(27, 11, 'New quotation', 'Quotation Q-2026-00002 is ready for your review.', 1, '2026-10-07 14:01:11', 'quotation:2'),
(28, 2, 'Quotation approved', 'Q-2026-00002 was approved and sent to the customer.', 0, '2026-10-07 14:01:11', 'quotation:2'),
(29, 2, 'New inquiry', 'Inquiry #6 from Jasper Olarte (Residential).', 0, '2026-10-19 12:00:52', 'inquiry:6'),
(30, 12, 'Inquiry received', 'Inquiry #6 was received. Please wait for our acknowledgment.', 0, '2026-10-19 12:00:52', 'inquiry:6'),
(31, 12, 'Inquiry acknowledged', 'Your inquiry #6 has been accepted. We are preparing your quotation.', 0, '2026-10-19 12:01:53', 'inquiry:6'),
(32, 1, 'Quotation for approval', 'Q-2026-00003 is waiting for your approval.', 0, '2026-10-19 12:06:04', 'quotation:3'),
(33, 12, 'New quotation', 'Quotation Q-2026-00003 is ready for your review.', 0, '2026-10-19 12:08:59', 'quotation:3'),
(34, 2, 'Quotation approved', 'Q-2026-00003 was approved and sent to the customer.', 0, '2026-10-19 12:08:59', 'quotation:3'),
(35, 2, 'Quotation approved', 'Q-2026-00003 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-21 1:00 PM.', 0, '2026-10-19 12:15:10', 'project:2'),
(36, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00003 (Down payment).', 0, '2026-10-19 12:16:43', 'project:2'),
(37, 12, 'Payment confirmed', 'Your Down payment for Q-2026-00003 was confirmed. Your receipt is being prepared.', 0, '2026-10-19 12:17:16', 'project:2'),
(38, 12, 'Receipt available', 'Service invoice OR-2026-00002 is now in your Documents.', 0, '2026-10-19 12:17:50', 'documents'),
(39, 12, 'Installation started', 'Our team has started your installation.', 0, '2026-10-19 12:19:30', 'project:2'),
(40, 12, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 5,628.00.', 0, '2026-10-19 12:20:13', 'project:2'),
(41, 12, 'Receipt available', 'Service invoice OR-2026-00002 is now in your Documents.', 0, '2026-10-19 12:20:57', 'documents'),
(42, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00003 (Final balance).', 0, '2026-10-19 12:22:17', 'project:2'),
(43, 12, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-19 12:22:25', 'project:2'),
(44, 12, 'Payment confirmed', 'Your Final balance for Q-2026-00003 was confirmed. Your receipt is being prepared.', 0, '2026-10-19 12:22:25', 'project:2'),
(45, 12, 'Receipt available', 'Service invoice OR-2026-00003 is now in your Documents.', 0, '2026-10-19 12:22:27', 'documents'),
(46, 12, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-19 12:23:49', 'documents'),
(47, 2, 'New inquiry', 'Inquiry #7 from Jasper Olarte (Commercial). Site visit requested.', 0, '2026-10-19 12:27:43', 'inquiry:7'),
(48, 12, 'Inquiry received', 'Inquiry #7 was received. Please wait for our acknowledgment.', 0, '2026-10-19 12:27:43', 'inquiry:7'),
(49, 11, 'Inquiry acknowledged', 'Your inquiry #4 has been accepted. We are preparing your quotation.', 0, '2026-10-19 12:28:10', 'inquiry:4'),
(50, 1, 'Quotation for approval', 'Q-2026-00004 is waiting for your approval.', 0, '2026-10-19 12:29:46', 'quotation:4'),
(51, 12, 'Inquiry acknowledged', 'Your inquiry #7 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-20 01:46:32', 'inquiry:7'),
(52, 12, 'Site visit confirmed', 'Your site visit is set for 2026-10-28 at 1:20 PM.', 0, '2026-10-20 01:46:35', 'inquiry:7'),
(53, 1, 'Quotation for approval', 'Q-2026-00005 is waiting for your approval.', 0, '2026-10-20 03:21:00', 'quotation:5'),
(54, 12, 'New quotation', 'Quotation Q-2026-00005 is ready for your review.', 1, '2026-10-20 03:25:40', 'quotation:5'),
(55, 2, 'Quotation approved', 'Q-2026-00005 was approved and sent to the customer.', 0, '2026-10-20 03:25:40', 'quotation:5'),
(56, 2, 'Quotation approved', 'Q-2026-00005 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-24 3:30 PM.', 0, '2026-10-20 03:26:24', 'project:3'),
(57, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00005 (Down payment).', 0, '2026-10-20 03:27:01', 'project:3'),
(58, 12, 'Payment confirmed', 'Your Down payment for Q-2026-00005 was confirmed. Your receipt is being prepared.', 1, '2026-10-20 03:29:17', 'project:3'),
(59, 12, 'Receipt available', 'Acknowledgement receipt OR-2026-00004 is now in your Documents.', 1, '2026-10-20 03:29:26', 'documents'),
(60, 12, 'Installation started', 'Our team has started your installation.', 0, '2026-10-20 03:33:46', 'project:3'),
(61, 12, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 5,040.00.', 0, '2026-10-20 03:33:54', 'project:3'),
(62, 2, 'New inquiry', 'Inquiry #8 from Jasper Olarte (Commercial).', 0, '2026-10-20 03:40:55', 'inquiry:8'),
(63, 12, 'Inquiry received', 'Inquiry #8 was received. Please wait for our acknowledgment.', 0, '2026-10-20 03:40:55', 'inquiry:8'),
(64, 12, 'Inquiry acknowledged', 'Your inquiry #8 has been accepted. We are preparing your quotation.', 0, '2026-10-20 03:43:56', 'inquiry:8'),
(65, 1, 'Quotation for approval', 'Q-2026-00006 is waiting for your approval.', 0, '2026-10-20 03:45:05', 'quotation:6'),
(66, 12, 'New quotation', 'Quotation Q-2026-00006 is ready for your review.', 1, '2026-10-20 03:45:16', 'quotation:6'),
(67, 2, 'Quotation approved', 'Q-2026-00006 was approved and sent to the customer.', 0, '2026-10-20 03:45:16', 'quotation:6'),
(68, 2, 'Quotation approved', 'Q-2026-00006 approved by customer. Payment: Full upon quotation (Over the counter). Install request: 2026-10-27 10:30 AM.', 0, '2026-10-20 03:47:03', 'project:4'),
(69, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00006 (Full).', 1, '2026-10-20 03:47:33', 'project:4'),
(70, 12, 'Payment confirmed', 'Your Full for Q-2026-00006 was confirmed. Your receipt is being prepared.', 0, '2026-10-20 03:47:47', 'project:4'),
(71, 12, 'Receipt available', 'Acknowledgement receipt OR-2026-00006 is now in your Documents.', 1, '2026-10-20 03:47:51', 'documents'),
(72, 2, 'New inquiry', 'Inquiry #9 from Jasper Olarte (Residential).', 1, '2026-10-20 04:11:42', 'inquiry:9'),
(73, 2, 'New inquiry', 'Inquiry #10 from Jasper Olarte (Commercial).', 0, '2026-10-20 04:11:42', 'inquiry:10'),
(74, 12, 'Inquiry received', '2 inquiries were received. Please wait for our acknowledgment.', 0, '2026-10-20 04:11:42', 'inquiry:9'),
(75, 12, 'Inquiry acknowledged', 'Your inquiry #9 has been accepted. We are preparing your quotation.', 0, '2026-10-20 04:12:15', 'inquiry:9'),
(76, 1, 'Quotation for approval', 'Q-2026-00007 is waiting for your approval.', 0, '2026-10-20 04:15:27', 'quotation:7'),
(77, 12, 'New quotation', 'Quotation Q-2026-00007 is ready for your review.', 0, '2026-10-20 04:15:47', 'quotation:7'),
(78, 2, 'Quotation approved', 'Q-2026-00007 was approved and sent to the customer.', 0, '2026-10-20 04:15:47', 'quotation:7'),
(79, 2, 'Negotiation cancelled', 'Q-2026-00007 was declined and the inquiry is marked Failed.', 0, '2026-10-20 04:16:38', 'quotation:7'),
(80, 12, 'Inquiry acknowledged', 'Your inquiry #10 has been accepted. We are preparing your quotation.', 0, '2026-10-20 04:17:05', 'inquiry:10'),
(81, 1, 'Quotation for approval', 'Q-2026-00008 is waiting for your approval.', 0, '2026-10-20 04:18:44', 'quotation:8'),
(82, 12, 'New quotation', 'Quotation Q-2026-00008 is ready for your review.', 1, '2026-10-20 04:18:51', 'quotation:8'),
(83, 2, 'Quotation approved', 'Q-2026-00008 was approved and sent to the customer.', 0, '2026-10-20 04:18:51', 'quotation:8'),
(84, 2, 'Quotation approved', 'Q-2026-00008 approved by customer. Payment: Full upon quotation (Online). Install request: 2026-10-28 10:30 AM.', 0, '2026-10-20 04:19:11', 'project:5'),
(85, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00008 (Full).', 0, '2026-10-20 04:20:09', 'project:5'),
(86, 12, 'Payment confirmed', 'Your Full for Q-2026-00008 was confirmed. Your receipt is being prepared.', 0, '2026-10-20 04:20:52', 'project:5'),
(87, 12, 'Receipt available', 'Acknowledgement receipt OR-2026-00007 is now in your Documents.', 1, '2026-10-20 04:20:56', 'documents'),
(88, 12, 'Installation started', 'Our team has started your installation.', 0, '2026-10-20 04:21:31', 'project:5'),
(89, 12, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-20 04:21:37', 'project:5'),
(90, 12, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 1, '2026-10-20 04:22:09', 'documents'),
(91, 2, 'New inquiry', 'Inquiry #11 from Jasper Olarte (Residential).', 0, '2026-10-21 11:03:47', 'inquiry:11'),
(92, 2, 'New inquiry', 'Inquiry #12 from Jasper Olarte (Commercial).', 0, '2026-10-21 11:03:47', 'inquiry:12'),
(93, 17, 'Inquiry received', '2 inquiries were received. Please wait for our acknowledgment.', 0, '2026-10-21 11:03:47', 'inquiry:11'),
(94, 2, 'New inquiry', 'Inquiry #13 from Richiebelle Del Rosario (Residential). Site visit requested.', 0, '2026-10-21 12:07:34', 'inquiry:13'),
(95, 14, 'Inquiry received', 'Inquiry #13 was received. Please wait for our acknowledgment.', 0, '2026-10-21 12:07:34', 'inquiry:13'),
(96, 2, 'New inquiry', 'Inquiry #14 from Richiebelle Del Rosario (Commercial).', 0, '2026-10-21 12:10:01', 'inquiry:14'),
(97, 14, 'Inquiry received', 'Inquiry #14 was received. Please wait for our acknowledgment.', 0, '2026-10-21 12:10:01', 'inquiry:14'),
(98, 14, 'Inquiry acknowledged', 'Your inquiry #13 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-21 12:11:44', 'inquiry:13'),
(99, 14, 'Inquiry not accepted', 'Thank you for your interest in Beyond Wires. We currently serve mainland Luzon only, so we are unable to take on a project at your location.', 0, '2026-10-21 12:12:01', 'inquiry:14'),
(100, 14, 'Site visit confirmed', 'Your site visit is set for 2026-10-23 at 1:00 PM.', 0, '2026-10-21 12:13:55', 'inquiry:13'),
(101, 1, 'Quotation for approval', 'Q-2026-00009 is waiting for your approval.', 0, '2026-10-21 12:22:19', 'quotation:9'),
(102, 14, 'New quotation', 'Quotation Q-2026-00009 is ready for your review.', 0, '2026-10-21 12:23:58', 'quotation:9'),
(103, 2, 'Quotation approved', 'Q-2026-00009 was approved and sent to the customer.', 1, '2026-10-21 12:23:58', 'quotation:9'),
(104, 2, 'Quotation approved', 'Q-2026-00009 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-23 1:00 PM.', 0, '2026-10-21 12:25:42', 'project:6'),
(105, 2, 'Payment proof uploaded', 'Richiebelle Del Rosario uploaded proof for Q-2026-00009 (Down payment).', 0, '2026-10-21 12:26:11', 'project:6'),
(106, 14, 'Payment confirmed', 'Your Down payment for Q-2026-00009 was confirmed. Your receipt is being prepared.', 0, '2026-10-21 12:27:28', 'project:6'),
(107, 14, 'Receipt available', 'Acknowledgement receipt OR-2026-00008 is now in your Documents.', 1, '2026-10-21 12:27:38', 'documents'),
(108, 2, 'New inquiry', 'Inquiry #15 from Allexis Gomez (Commercial).', 0, '2026-10-21 18:23:07', 'inquiry:15'),
(109, 2, 'New inquiry', 'Inquiry #16 from Allexis Gomez (Residential). Site visit requested.', 0, '2026-10-21 18:23:07', 'inquiry:16'),
(110, 18, 'Inquiry received', '2 inquiries were received. Please wait for our acknowledgment.', 0, '2026-10-21 18:23:07', 'inquiry:15'),
(111, 18, 'Inquiry acknowledged', 'Your inquiry #16 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-21 18:23:28', 'inquiry:16'),
(112, 18, 'Inquiry acknowledged', 'Your inquiry #15 has been accepted. We are preparing your quotation.', 0, '2026-10-21 18:23:33', 'inquiry:15'),
(113, 1, 'Quotation for approval', 'Q-2026-00010 is waiting for your approval.', 1, '2026-10-21 18:31:20', 'quotation:10'),
(114, 18, 'New quotation', 'Quotation Q-2026-00010 is ready for your review.', 1, '2026-10-21 18:35:08', 'quotation:10'),
(115, 2, 'Quotation approved', 'Q-2026-00010 was approved and sent to the customer.', 0, '2026-10-21 18:35:08', 'quotation:10'),
(116, 17, 'Inquiry acknowledged', 'Your inquiry #12 has been accepted. We are preparing your quotation.', 0, '2026-10-21 18:36:51', 'inquiry:12'),
(117, 1, 'Quotation for approval', 'Q-2026-00011 is waiting for your approval.', 0, '2026-10-21 18:39:14', 'quotation:11'),
(118, 17, 'New quotation', 'Quotation Q-2026-00011 is ready for your review.', 0, '2026-10-21 18:40:43', 'quotation:11'),
(119, 2, 'Quotation approved', 'Q-2026-00011 was approved and sent to the customer.', 0, '2026-10-21 18:40:43', 'quotation:11'),
(120, 2, 'Quotation approved', 'Q-2026-00010 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-23 3:20 PM.', 0, '2026-10-21 18:43:54', 'project:7'),
(121, 2, 'Payment proof uploaded', 'Allexis Gomez uploaded proof for Q-2026-00010 (Down payment).', 1, '2026-10-21 18:48:45', 'project:7'),
(122, 18, 'Payment confirmed', 'Your Down payment for Q-2026-00010 was confirmed. Your receipt is being prepared.', 0, '2026-10-21 18:51:39', 'project:7'),
(123, 18, 'Receipt available', 'Acknowledgement receipt OR-2026-00010 is now in your Documents.', 0, '2026-10-21 18:52:15', 'documents'),
(124, 18, 'Installation started', 'Our team has started your installation.', 0, '2026-10-21 18:56:34', 'project:7'),
(125, 18, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 5,208.00.', 1, '2026-10-21 18:58:34', 'project:7'),
(126, 2, 'Payment proof uploaded', 'Allexis Gomez uploaded proof for Q-2026-00010 (Final balance).', 1, '2026-10-21 19:00:50', 'project:7'),
(127, 18, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-21 19:04:08', 'documents'),
(128, 18, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-21 19:04:21', 'documents'),
(129, 18, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-21 19:04:29', 'project:7'),
(130, 18, 'Payment confirmed', 'Your Final balance for Q-2026-00010 was confirmed. Your receipt is being prepared.', 0, '2026-10-21 19:04:29', 'project:7'),
(131, 18, 'Receipt available', 'Acknowledgement receipt OR-2026-00011 is now in your Documents.', 0, '2026-10-21 19:04:47', 'documents'),
(132, 18, 'Schedule updated', 'Your Site Inspection was moved to 2026-10-28 at 1:00 PM. Reason: Crew Unavailable', 1, '2026-10-21 19:29:17', 'schedule:11'),
(133, 17, 'Inquiry acknowledged', 'Your inquiry #11 has been accepted. We are preparing your quotation.', 0, '2026-10-22 03:01:38', 'inquiry:11'),
(134, 1, 'Quotation for approval', 'Q-2026-00012 is waiting for your approval.', 0, '2026-10-22 03:02:52', 'quotation:12'),
(135, 17, 'New quotation', 'Quotation Q-2026-00012 is ready for your review.', 1, '2026-10-22 03:04:23', 'quotation:12'),
(136, 2, 'Quotation approved', 'Q-2026-00012 was approved and sent to the customer.', 0, '2026-10-22 03:04:23', 'quotation:12'),
(137, 2, 'Quotation approved', 'Q-2026-00012 approved by customer. Payment: Full upon quotation (Online). Install request: 2026-10-27 1:00 PM.', 0, '2026-10-22 03:05:31', 'project:8'),
(138, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00012 (Full).', 1, '2026-10-22 03:07:37', 'project:8'),
(139, 17, 'Payment confirmed', 'Your Full for Q-2026-00012 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 03:08:14', 'project:8'),
(140, 17, 'Receipt available', 'Acknowledgement receipt OR-2026-00012 is now in your Documents.', 0, '2026-10-22 03:08:23', 'documents'),
(141, 18, 'Site visit confirmed', 'Your site visit is set for 2026-10-28 at 1:00 PM.', 0, '2026-10-22 03:08:44', 'inquiry:16'),
(142, 1, 'Quotation for approval', 'Q-2026-00013 is waiting for your approval.', 1, '2026-10-22 03:09:46', 'quotation:13'),
(143, 18, 'New quotation', 'Quotation Q-2026-00013 is ready for your review.', 0, '2026-10-22 03:10:01', 'quotation:13'),
(144, 2, 'Quotation approved', 'Q-2026-00013 was approved and sent to the customer.', 0, '2026-10-22 03:10:01', 'quotation:13'),
(145, 2, 'Quotation approved', 'Q-2026-00013 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-28 9:00 AM.', 0, '2026-10-22 03:10:59', 'project:9'),
(146, 2, 'Payment proof uploaded', 'Allexis Gomez uploaded proof for Q-2026-00013 (Down payment).', 1, '2026-10-22 03:11:16', 'project:9'),
(147, 18, 'Payment confirmed', 'Your Down payment for Q-2026-00013 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 03:11:27', 'project:9'),
(148, 18, 'Receipt available', 'Acknowledgement receipt OR-2026-00013 is now in your Documents.', 0, '2026-10-22 03:11:35', 'documents'),
(149, 18, 'Installation started', 'Our team has started your installation.', 0, '2026-10-22 03:11:41', 'project:9'),
(150, 18, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 10,248.00.', 0, '2026-10-22 03:11:45', 'project:9'),
(151, 2, 'Payment proof uploaded', 'Allexis Gomez uploaded proof for Q-2026-00013 (Final balance).', 0, '2026-10-22 03:12:18', 'project:9'),
(152, 18, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-22 03:12:31', 'project:9'),
(153, 18, 'Payment confirmed', 'Your Final balance for Q-2026-00013 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 03:12:31', 'project:9'),
(154, 18, 'Receipt available', 'Acknowledgement receipt OR-2026-00014 is now in your Documents.', 0, '2026-10-22 03:12:44', 'documents'),
(155, 18, 'Memorandum of Agreement available', 'Your memorandum of agreement is now in your Documents.', 0, '2026-10-22 03:13:04', 'documents'),
(156, 18, 'Job Order available', 'Your job order is now in your Documents.', 0, '2026-10-22 03:13:08', 'documents'),
(157, 18, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-22 03:13:51', 'documents'),
(158, 18, 'Receipt available', 'Acknowledgement receipt OR-2026-00014 is now in your Documents.', 0, '2026-10-22 03:17:06', 'documents'),
(159, 2, 'New inquiry', 'Inquiry #17 from Allexis Gomez (Residential). Site visit requested.', 1, '2026-10-22 03:24:12', 'inquiry:17'),
(160, 18, 'Inquiry received', 'Inquiry #17 was received. Please wait for our acknowledgment.', 0, '2026-10-22 03:24:12', 'inquiry:17'),
(161, 18, 'Inquiry acknowledged', 'Your inquiry #17 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-22 03:24:44', 'inquiry:17'),
(162, 18, 'Site visit confirmed', 'Your site visit is set for 2026-10-28 at 10:30 AM.', 0, '2026-10-22 03:24:55', 'inquiry:17'),
(163, 1, 'Quotation for approval', 'Q-2026-00014 is waiting for your approval.', 1, '2026-10-22 03:25:50', 'quotation:14'),
(164, 18, 'New quotation', 'Quotation Q-2026-00014 is ready for your review.', 0, '2026-10-22 03:26:07', 'quotation:14'),
(165, 2, 'Quotation approved', 'Q-2026-00014 was approved and sent to the customer.', 0, '2026-10-22 03:26:07', 'quotation:14'),
(166, 2, 'Quotation approved', 'Q-2026-00014 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-24 3:30 PM.', 0, '2026-10-22 03:26:44', 'project:10'),
(167, 2, 'Reschedule request', 'Jasper Olarte moved a Installation to 2026-10-23 3:30 PM. Reason: Emergency / personal matter', 1, '2026-10-22 05:41:44', 'schedule:13'),
(168, 17, 'Schedule updated', 'Your Installation was moved to 2026-10-24 at 1:00 PM. Reason: Proposed by BeyondWires', 1, '2026-10-22 05:43:08', 'schedule:13'),
(169, 18, 'Schedule updated', 'Your Installation was moved to 2026-10-28 at 10:30 AM. Reason: Travel Conflict', 1, '2026-10-22 05:44:30', 'schedule:16'),
(170, 2, 'Reschedule request', 'Allexis Gomez moved a Installation to 2026-10-28 1:20 PM. Reason: I am not home', 1, '2026-10-22 05:46:14', 'schedule:16'),
(171, 18, 'Installation confirmed', 'Your Installation on 2026-10-28 at 1:20 PM is confirmed.', 1, '2026-10-22 05:46:28', 'schedule:16'),
(172, 2, 'New inquiry', 'Inquiry #18 from Allexis Gomez (Commercial). Site visit requested.', 1, '2026-10-22 11:23:16', 'inquiry:18'),
(173, 18, 'Inquiry received', 'Inquiry #18 was received. Please wait for our acknowledgment.', 0, '2026-10-22 11:23:16', 'inquiry:18'),
(174, 18, 'Inquiry acknowledged', 'Your inquiry #18 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-22 11:23:38', 'inquiry:18'),
(175, 18, 'Site visit confirmed', 'Your site visit is set for 2026-10-23 at 10:30 AM.', 0, '2026-10-22 11:23:52', 'inquiry:18'),
(176, 1, 'Quotation for approval', 'Q-2026-00015 is waiting for your approval.', 1, '2026-10-22 11:25:01', 'quotation:15'),
(177, 18, 'New quotation', 'Quotation Q-2026-00015 is ready for your review.', 1, '2026-10-22 11:25:45', 'quotation:15'),
(178, 2, 'Quotation approved', 'Q-2026-00015 was approved and sent to the customer.', 0, '2026-10-22 11:25:45', 'quotation:15'),
(179, 2, 'Quotation approved', 'Q-2026-00015 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-24 10:30 AM.', 0, '2026-10-22 11:26:51', 'project:11'),
(180, 2, 'Payment proof uploaded', 'Allexis Gomez uploaded proof for Q-2026-00015 (Down payment).', 1, '2026-10-22 11:29:09', 'project:11'),
(181, 18, 'Payment confirmed', 'Your Down payment for Q-2026-00015 was confirmed. Your receipt is being prepared.', 1, '2026-10-22 11:29:44', 'project:11'),
(182, 2, 'New inquiry', 'Inquiry #19 from Angelyn ed (Residential).', 0, '2026-10-22 11:49:49', 'inquiry:19'),
(183, 20, 'Inquiry received', 'Inquiry #19 was received. Please wait for our acknowledgment.', 0, '2026-10-22 11:49:49', 'inquiry:19'),
(184, 20, 'Inquiry acknowledged', 'Your inquiry #19 has been accepted. We are preparing your quotation.', 0, '2026-10-22 11:51:25', 'inquiry:19'),
(185, 1, 'Quotation for approval', 'Q-2026-00016 is waiting for your approval.', 0, '2026-10-22 11:58:49', 'quotation:16'),
(186, 20, 'New quotation', 'Quotation Q-2026-00016 is ready for your review.', 1, '2026-10-22 12:00:35', 'quotation:16'),
(187, 2, 'Quotation approved', 'Q-2026-00016 was approved and sent to the customer.', 0, '2026-10-22 12:00:35', 'quotation:16'),
(188, 2, 'Quotation approved', 'Q-2026-00016 approved by customer. Payment: Half upon quotation (Over the counter). Install request: 2026-11-06 9:00 AM.', 0, '2026-10-22 12:03:10', 'project:12'),
(189, 2, 'Payment proof uploaded', 'Angelyn ed uploaded proof for Q-2026-00016 (Down payment).', 1, '2026-10-22 12:04:52', 'project:12'),
(190, 20, 'Payment confirmed', 'Your Down payment for Q-2026-00016 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 12:06:23', 'project:12'),
(191, 20, 'Receipt available', 'Acknowledgement receipt OR-2026-00019 is now in your Documents.', 0, '2026-10-22 12:06:56', 'documents'),
(192, 20, 'Installation started', 'Our team has started your installation.', 0, '2026-10-22 12:09:36', 'project:12'),
(193, 20, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 2,884.00.', 0, '2026-10-22 12:10:02', 'project:12'),
(194, 20, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-22 12:10:18', 'project:12'),
(195, 20, 'Payment confirmed', 'Your Final balance for Q-2026-00016 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 12:10:18', 'project:12'),
(196, 20, 'Receipt available', 'Acknowledgement receipt OR-2026-00019 is now in your Documents.', 0, '2026-10-22 12:11:04', 'documents'),
(197, 20, 'Receipt available', 'Acknowledgement receipt OR-2026-00020 is now in your Documents.', 0, '2026-10-22 12:11:05', 'documents'),
(198, 20, 'Memorandum of Agreement available', 'Your memorandum of agreement is now in your Documents.', 0, '2026-10-22 12:11:09', 'documents'),
(199, 20, 'Job Order available', 'Your job order is now in your Documents.', 0, '2026-10-22 12:11:18', 'documents'),
(200, 20, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-22 12:12:17', 'documents'),
(201, 20, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-22 12:12:23', 'documents'),
(202, 2, 'New inquiry', 'Inquiry #20 from Dustin Yu (Commercial). Site visit requested.', 1, '2026-10-22 14:03:51', 'inquiry:20'),
(203, 2, 'New inquiry', 'Inquiry #21 from Dustin Yu (Commercial).', 1, '2026-10-22 14:03:51', 'inquiry:21'),
(204, 21, 'Inquiry received', '2 inquiries were received. Please wait for our acknowledgment.', 0, '2026-10-22 14:03:51', 'inquiry:20'),
(205, 21, 'Inquiry acknowledged', 'Your inquiry #21 has been accepted. We are preparing your quotation.', 0, '2026-10-22 14:06:44', 'inquiry:21'),
(206, 21, 'Inquiry not accepted', 'Thank you for your interest in Beyond Wires. We currently serve mainland Luzon only, so we are unable to take on a project at your location.', 0, '2026-10-22 14:08:13', 'inquiry:20'),
(207, 21, 'Inquiry not accepted', 'Thank you for your interest in Beyond Wires. We currently serve mainland Luzon only, so we are unable to take on a project at your location.', 0, '2026-10-22 14:09:17', 'inquiry:21'),
(208, 2, 'New inquiry', 'Inquiry #22 from Dustin Yu (Residential).', 0, '2026-10-22 14:12:15', 'inquiry:22'),
(209, 2, 'New inquiry', 'Inquiry #23 from Dustin Yu (Commercial). Site visit requested.', 0, '2026-10-22 14:12:15', 'inquiry:23'),
(210, 21, 'Inquiry received', '2 inquiries were received. Please wait for our acknowledgment.', 0, '2026-10-22 14:12:15', 'inquiry:22'),
(211, 21, 'Inquiry acknowledged', 'Your inquiry #23 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-22 14:12:33', 'inquiry:23'),
(212, 21, 'Inquiry acknowledged', 'Your inquiry #22 has been accepted. We are preparing your quotation.', 0, '2026-10-22 14:12:47', 'inquiry:22'),
(213, 1, 'Quotation for approval', 'Q-2026-00017 is waiting for your approval.', 1, '2026-10-22 14:19:25', 'quotation:17'),
(214, 21, 'New quotation', 'Quotation Q-2026-00017 is ready for your review.', 1, '2026-10-22 14:22:19', 'quotation:17'),
(215, 2, 'Quotation approved', 'Q-2026-00017 was approved and sent to the customer.', 0, '2026-10-22 14:22:19', 'quotation:17'),
(216, 2, 'New quotation requested', 'Q-2026-00017 was declined; the customer wants a revised quotation.', 0, '2026-10-22 14:23:45', 'quotation:17'),
(217, 21, 'Site visit confirmed', 'Your site visit is set for 2026-10-27 at 3:30 PM.', 0, '2026-10-22 14:24:42', 'inquiry:23'),
(218, 21, 'Site visit confirmed', 'Your site visit is set for 2026-10-27 at 3:30 PM.', 0, '2026-10-22 14:24:49', 'inquiry:23'),
(219, 1, 'Quotation for approval', 'Q-2026-00018 is waiting for your approval.', 1, '2026-10-22 14:25:42', 'quotation:18'),
(220, 21, 'New quotation', 'Quotation Q-2026-00018 is ready for your review.', 1, '2026-10-22 14:26:05', 'quotation:18'),
(221, 2, 'Quotation approved', 'Q-2026-00018 was approved and sent to the customer.', 0, '2026-10-22 14:26:05', 'quotation:18'),
(222, 2, 'Quotation approved', 'Q-2026-00018 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-23 10:30 AM.', 0, '2026-10-22 14:27:24', 'project:13'),
(223, 2, 'Payment proof uploaded', 'Dustin Yu uploaded proof for Q-2026-00018 (Down payment).', 1, '2026-10-22 14:30:09', 'project:13'),
(224, 21, 'Payment confirmed', 'Your Down payment for Q-2026-00018 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 14:31:00', 'project:13'),
(225, 21, 'Receipt available', 'Acknowledgement receipt OR-2026-00021 is now in your Documents.', 0, '2026-10-22 14:31:24', 'documents'),
(226, 21, 'Installation started', 'Our team has started your installation.', 0, '2026-10-22 14:31:53', 'project:13'),
(227, 21, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 6,272.00.', 0, '2026-10-22 14:32:17', 'project:13'),
(228, 21, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-22 14:33:46', 'documents'),
(229, 21, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-22 14:33:52', 'documents'),
(230, 21, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 0, '2026-10-22 14:33:58', 'documents'),
(231, 2, 'Payment proof uploaded', 'Dustin Yu uploaded proof for Q-2026-00018 (Final balance).', 0, '2026-10-22 14:34:47', 'project:13'),
(232, 21, 'Project completed', 'Your project is complete. Your quotation and receipts are available under Documents.', 0, '2026-10-22 14:34:56', 'project:13'),
(233, 21, 'Payment confirmed', 'Your Final balance for Q-2026-00018 was confirmed. Your receipt is being prepared.', 0, '2026-10-22 14:34:56', 'project:13'),
(234, 2, 'New inquiry', 'Inquiry #24 from Jasper Olarte (Commercial).', 1, '2026-10-24 00:38:06', 'inquiry:24'),
(235, 17, 'Inquiry received', 'Inquiry #24 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 00:38:06', 'inquiry:24'),
(236, 17, 'Inquiry acknowledged', 'Your inquiry #24 has been accepted. We are preparing your quotation.', 0, '2026-10-24 00:39:50', 'inquiry:24'),
(237, 2, 'New inquiry', 'Inquiry #25 from Richiebelle Del Rosario (Residential). Site visit requested.', 0, '2026-10-24 00:44:07', 'inquiry:25'),
(238, 14, 'Inquiry received', 'Inquiry #25 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 00:44:07', 'inquiry:25'),
(239, 2, 'Inquiry cancelled', 'Richiebelle Del Rosario cancelled inquiry #25. Reason: Schedule doesn\'t work', 1, '2026-10-24 00:53:12', 'inquiry:25'),
(240, 2, 'New inquiry', 'Inquiry #26 from Richiebelle Del Rosario (Residential). Site visit requested.', 1, '2026-10-24 00:55:12', 'inquiry:26'),
(241, 14, 'Inquiry received', 'Inquiry #26 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 00:55:12', 'inquiry:26'),
(242, 14, 'Inquiry acknowledged', 'Your inquiry #26 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-24 00:55:41', 'inquiry:26'),
(243, 14, 'Site visit confirmed', 'Your site visit is set for 2026-10-29 at 1:00 PM.', 0, '2026-10-24 01:42:32', 'inquiry:26'),
(244, 1, 'Quotation for approval', 'Q-2026-00019 is waiting for your approval.', 0, '2026-10-24 01:46:25', 'quotation:19'),
(245, 14, 'New quotation', 'Quotation Q-2026-00019 is ready for your review.', 0, '2026-10-24 01:47:45', 'quotation:19'),
(246, 2, 'Quotation approved', 'Q-2026-00019 was approved and sent to the customer.', 0, '2026-10-24 01:47:45', 'quotation:19'),
(247, 2, 'New inquiry', 'Inquiry #27 from Jasper Olarte (Commercial).', 0, '2026-10-24 01:50:09', 'inquiry:27'),
(248, 17, 'Inquiry received', 'Inquiry #27 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 01:50:09', 'inquiry:27'),
(249, 2, 'New inquiry', 'Inquiry #28 from Harry Styles (Commercial).', 0, '2026-10-24 04:25:09', 'inquiry:28'),
(250, 2, 'New inquiry', 'Inquiry #29 from Harry Styles (Residential). Site visit requested.', 0, '2026-10-24 04:25:09', 'inquiry:29'),
(251, 22, 'Inquiry received', '2 inquiries were received. We will review them within 3 business days and let you know.', 0, '2026-10-24 04:25:09', 'inquiry:28'),
(252, 22, 'Inquiry acknowledged', 'Your inquiry #29 has been accepted. We will confirm your site visit schedule shortly.', 0, '2026-10-24 04:27:38', 'inquiry:29'),
(253, 22, 'Site visit confirmed', 'Your site visit is set for 2026-12-04 at 9:00 AM.', 0, '2026-10-24 04:27:48', 'inquiry:29'),
(254, 1, 'Quotation for approval', 'Q-2026-00020 is waiting for your approval.', 1, '2026-10-24 04:30:04', 'quotation:20'),
(255, 2, 'New inquiry', 'Inquiry #30 from Harry Styles (Residential).', 1, '2026-10-24 04:31:55', 'inquiry:30'),
(256, 22, 'Inquiry received', 'Inquiry #30 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 04:31:55', 'inquiry:30'),
(257, 2, 'New inquiry', 'Inquiry #31 from Harry Styles (Commercial). Site visit requested.', 0, '2026-10-24 04:33:20', 'inquiry:31'),
(258, 22, 'Inquiry received', 'Inquiry #31 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 04:33:20', 'inquiry:31'),
(259, 22, 'Inquiry acknowledged', 'Your inquiry #30 has been accepted. We are preparing your quotation.', 0, '2026-10-24 04:36:49', 'inquiry:30'),
(260, 1, 'Quotation for approval', 'Q-2026-00021 is waiting for your approval.', 0, '2026-10-24 04:38:59', 'quotation:21'),
(261, 22, 'New quotation', 'Quotation Q-2026-00020 is ready for your review.', 1, '2026-10-24 04:40:19', 'quotation:20'),
(262, 2, 'Quotation approved', 'Q-2026-00020 was approved and sent to the customer.', 0, '2026-10-24 04:40:19', 'quotation:20'),
(263, 2, 'Quotation approved', 'Q-2026-00020 approved by customer. Payment: Half upon quotation (Online). Install request: 2026-10-27 3:30 PM.', 0, '2026-10-24 04:40:53', 'project:14'),
(264, 22, 'New quotation', 'Quotation Q-2026-00021 is ready for your review.', 1, '2026-10-24 04:45:59', 'quotation:21'),
(265, 2, 'Quotation approved', 'Q-2026-00021 was approved and sent to the customer.', 0, '2026-10-24 04:45:59', 'quotation:21'),
(266, 2, 'Quotation approved', 'Q-2026-00021 approved by customer. Payment: Half upon quotation (Over the counter). Install request: 2026-10-27 9:00 AM.', 0, '2026-10-24 04:47:33', 'project:15'),
(267, 2, 'Payment proof uploaded', 'Harry Styles uploaded proof for Q-2026-00021 (Down payment).', 1, '2026-10-24 04:53:06', 'project:15'),
(268, 22, 'Payment confirmed', 'Your Down payment for Q-2026-00021 was confirmed. Your receipt is being prepared.', 0, '2026-10-24 04:53:42', 'project:15'),
(269, 22, 'Receipt available', 'Acknowledgement receipt OR-2026-00025 is now in your Documents.', 0, '2026-10-24 04:53:51', 'documents'),
(270, 2, 'Payment proof uploaded', 'Harry Styles uploaded proof for Q-2026-00020 (Down payment).', 0, '2026-10-24 04:55:01', 'project:14'),
(271, 2, 'Reschedule request', 'Harry Styles moved a Installation to 2026-10-30 3:30 PM. Reason: Emergency / personal matter', 0, '2026-10-24 04:56:18', 'schedule:27'),
(272, 22, 'Installation started', 'Our team has started your installation.', 0, '2026-10-24 04:56:41', 'project:15'),
(273, 22, 'Installation complete', 'Your installation is complete. Remaining balance: PHP 5,600.00.', 1, '2026-10-24 04:56:46', 'project:15'),
(274, 2, 'Payment proof uploaded', 'Harry Styles uploaded proof for Q-2026-00021 (Final balance).', 1, '2026-10-24 04:57:41', 'project:15'),
(275, 22, 'Payment confirmed', 'Your Final balance for Q-2026-00021 was confirmed. Your receipt is being prepared.', 0, '2026-10-24 04:57:49', 'project:15'),
(276, 22, 'Receipt available', 'Acknowledgement receipt OR-2026-00026 is now in your Documents.', 0, '2026-10-24 04:57:56', 'documents'),
(277, 22, 'Project completed', 'Your project \"Harry Styles Concert\" is complete. All your documents are ready under Documents in your account: Quotation Q-2026-00021; Receipts OR-2026-00025 and OR-2026-00026; Installation certificate and accomplishment report. Thank you for choosing BeyondWires.', 0, '2026-10-24 04:58:27', 'project:15'),
(278, 2, 'New inquiry', 'Inquiry #32 from Jasper Olarte (Commercial). Site visit requested.', 0, '2026-10-24 07:54:01', 'inquiry:32'),
(279, 2, 'New inquiry', 'Inquiry #33 from Jasper Olarte (Residential).', 0, '2026-10-24 07:54:01', 'inquiry:33'),
(280, 17, 'Inquiry received', '2 inquiries were received. We will review them within 3 business days and let you know.', 0, '2026-10-24 07:54:01', 'inquiry:32'),
(281, 17, 'Changes requested', 'Please update your inquiry #33. Reason: Budget does not cover the request. Open My Inquiries to update it and send it again.', 1, '2026-10-24 07:56:56', 'inquiry:33'),
(282, 17, 'Inquiry acknowledged', 'Your inquiry #32 has been accepted. We will confirm your site visit schedule shortly.', 1, '2026-10-24 07:57:18', 'inquiry:32'),
(283, 2, 'New inquiry', 'Inquiry #34 from Jasper Olarte (Commercial).', 0, '2026-10-24 08:00:27', 'inquiry:34'),
(284, 17, 'Inquiry received', 'Inquiry #34 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 08:00:27', 'inquiry:34'),
(285, 17, 'Changes requested', 'Please update your inquiry #34. Reason: Outside our service area. Open My Inquiries to update it and send it again.', 1, '2026-10-24 08:00:52', 'inquiry:34'),
(286, 2, 'Inquiry updated', 'Jasper Olarte updated inquiry #33 and sent it again.', 1, '2026-10-24 08:04:04', 'inquiry:33'),
(287, 17, 'Inquiry acknowledged', 'Your inquiry #33 has been accepted. We are preparing your quotation.', 0, '2026-10-24 08:04:23', 'inquiry:33'),
(288, 1, 'Quotation for approval', 'Q-2026-00022 is waiting for your approval.', 0, '2026-10-24 08:20:33', 'quotation:22'),
(289, 17, 'New quotation', 'Quotation Q-2026-00022 is ready for your review.', 1, '2026-10-24 08:21:01', 'quotation:22'),
(290, 2, 'Quotation approved', 'Q-2026-00022 was approved and sent to the customer.', 0, '2026-10-24 08:21:01', 'quotation:22'),
(291, 2, 'Quotation approved', 'Q-2026-00022 approved by customer. Payment: Full upon quotation (Online). Install request: 2026-11-03 3:30 PM.', 0, '2026-10-24 08:22:15', 'project:16'),
(292, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00022 (Full).', 1, '2026-10-24 08:22:44', 'project:16'),
(293, 17, 'Payment confirmed', 'Your Full for Q-2026-00022 was confirmed. Your receipt is being prepared.', 0, '2026-10-24 08:24:57', 'project:16'),
(294, 17, 'Receipt available', 'Acknowledgement receipt OR-2026-00027 is now in your Documents.', 0, '2026-10-24 08:25:06', 'documents'),
(295, 17, 'Installation started', 'Our team has started your installation.', 0, '2026-10-24 08:25:18', 'project:16'),
(296, 17, 'Project completed', 'Your project \"Jasper Dunkin Donut\" is complete. All your documents are ready under Documents in your account: Quotation Q-2026-00022; Receipt OR-2026-00027; Installation certificate and accomplishment report. Thank you for choosing BeyondWires.', 0, '2026-10-24 08:27:06', 'project:16'),
(297, 17, 'Installation certificate available', 'Your installation certificate and accomplishment report are now in your Documents.', 1, '2026-10-24 08:27:12', 'documents'),
(298, 2, 'New inquiry', 'Inquiry #35 from Jasper Olarte (Commercial).', 1, '2026-10-24 08:34:53', 'inquiry:35'),
(299, 17, 'Inquiry received', 'Inquiry #35 was received. We will review it within 3 business days and let you know.', 0, '2026-10-24 08:34:53', 'inquiry:35'),
(300, 17, 'Inquiry acknowledged', 'Your inquiry #35 has been accepted. We are preparing your quotation.', 1, '2026-10-24 08:35:16', 'inquiry:35'),
(301, 2, 'New inquiry', 'Inquiry #36 from Jasper Olarte (Commercial). Site visit requested.', 1, '2026-10-24 09:16:11', 'inquiry:36'),
(302, 2, 'New inquiry', 'Inquiry #37 from Jasper Olarte (Residential).', 0, '2026-10-24 09:16:11', 'inquiry:37'),
(303, 17, 'Inquiry received', '2 inquiries were received. We will review them within 3 business days and let you know.', 0, '2026-10-24 09:16:11', 'inquiry:36'),
(304, 17, 'New schedule proposed', 'We proposed a new site visit schedule: 2026-10-28 at 10:30 AM. Reason: Weather concerns. Please accept it or ask for another time in My Inquiries.', 1, '2026-10-24 09:16:44', 'inquiry:36'),
(305, 17, 'Inquiry acknowledged', 'Your inquiry #37 has been accepted. We are preparing your quotation.', 0, '2026-10-24 09:17:09', 'inquiry:37'),
(306, 1, 'Quotation for approval', 'Q-2026-00023 is waiting for your approval.', 0, '2026-10-24 09:18:36', 'quotation:23'),
(307, 2, 'Schedule accepted', 'Jasper Olarte accepted the Site Inspection on 2026-10-28 at 10:30 AM.', 0, '2026-10-24 09:19:12', 'schedule:31'),
(308, 17, 'New quotation', 'Quotation Q-2026-00023 is ready for your review.', 1, '2026-10-24 09:20:03', 'quotation:23'),
(309, 2, 'Quotation approved', 'Q-2026-00023 was approved and sent to the customer.', 0, '2026-10-24 09:20:03', 'quotation:23'),
(310, 2, 'Quotation approved', 'Q-2026-00023 approved by customer. Payment: Full upon quotation (Over the counter). Install request: 2026-10-31 3:30 PM.', 0, '2026-10-24 09:20:37', 'project:17'),
(311, 2, 'Payment proof uploaded', 'Jasper Olarte uploaded proof for Q-2026-00023 (Full).', 0, '2026-10-24 09:20:52', 'project:17'),
(312, 17, 'Payment confirmed', 'Your Full for Q-2026-00023 was confirmed. Your receipt is being prepared.', 0, '2026-10-24 09:21:25', 'project:17'),
(313, 17, 'Receipt available', 'Acknowledgement receipt OR-2026-00028 is now in your Documents.', 0, '2026-10-24 09:21:35', 'documents'),
(314, 17, 'Installation started', 'Our team has started your installation.', 0, '2026-10-24 09:21:41', 'project:17'),
(315, 17, 'Project completed', 'Your project \"Jasper and his turtle\" is complete. All your documents are ready under Documents in your account: Quotation Q-2026-00023; Receipt OR-2026-00028; Installation certificate and accomplishment report. Thank you for choosing BeyondWires.', 0, '2026-10-24 09:22:10', 'project:17'),
(316, 17, 'Project completed', 'Your project \"Jasper and his turtle\" is complete. All your documents are ready under Documents in your account: Quotation Q-2026-00023; Receipt OR-2026-00028; Installation certificate and accomplishment report. Thank you for choosing BeyondWires.', 1, '2026-10-24 09:22:15', 'project:17'),
(317, 17, 'Memorandum of Agreement available', 'Your memorandum of agreement is now in your Documents.', 0, '2026-10-24 09:23:18', 'documents'),
(318, 17, 'Job Order available', 'Your job order is now in your Documents.', 0, '2026-10-24 09:23:29', 'documents'),
(319, 1, 'Quotation for approval', 'Q-2026-00024 is waiting for your approval.', 0, '2026-10-24 09:25:51', 'quotation:24');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `reset_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`reset_id`, `user_id`, `token_hash`, `expires_at`, `used_at`, `created_at`) VALUES
(1, 13, 'f473cb93a6b117f6ae53109e2313b939486fd359290dd5e0d3d5c43d95f95010', '2026-10-21 04:52:57', NULL, '2026-10-21 04:52:41'),
(2, 13, 'ed19b039c829f6fe9800dc5e3e14990899f396c0d690db7eb2d272e8d04d5b86', '2026-10-21 05:02:03', NULL, '2026-10-21 04:52:57'),
(3, 13, 'cea201ddcbcc07047fe3b408898aec002c564e4b607bef6dc90ffb3402dfa63d', '2026-10-21 05:32:03', NULL, '2026-10-21 05:02:03'),
(4, 14, '7c91f3f087608b6f61634334259ea4c19f0122108e8ecbe5494e83c9e35e5415', '2026-10-21 05:38:09', '2026-10-21 05:19:28', '2026-10-21 05:08:09'),
(5, 14, '6a6e9388537ac13ed792e6e4e3730e366132901c708792d31561bd4fd3d6a152', '2026-10-21 12:34:29', '2026-10-21 12:05:44', '2026-10-21 12:04:29'),
(6, 18, 'cc3ec372e6918aa95a86269e5426c9dc83d5e3fab8e8ce766dfb7f45b0420080', '2026-10-21 20:25:44', NULL, '2026-10-21 19:55:44'),
(7, 14, 'f7fbaf3b7a3dc1aa8c3ca3760fef0f4b6320072e97b160336cbd9b91ec7f65fa', '2026-10-21 20:26:23', NULL, '2026-10-21 19:56:23'),
(8, 14, '67e127113f2f5868a9074f00f7e9945dc7f94fd886a0daa8d5a29bba45baf0c0', '2026-10-24 01:12:15', '2026-10-24 00:42:58', '2026-10-24 00:42:15');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `installment` enum('Down payment','Final balance','Full') NOT NULL,
  `amount_due` decimal(12,2) NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL DEFAULT 0.00,
  `payment_method` enum('Online','Over the counter') NOT NULL,
  `payment_agreement` varchar(40) NOT NULL,
  `proof_of_payment_url` varchar(255) DEFAULT NULL,
  `reference_no` varchar(60) DEFAULT NULL,
  `status` enum('Not Due','Awaiting Payment','Under Review','Confirmed','Rejected') NOT NULL,
  `reject_reason` varchar(255) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `confirmed_by` int(11) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `quotation_id`, `customer_id`, `installment`, `amount_due`, `amount_paid`, `payment_method`, `payment_agreement`, `proof_of_payment_url`, `reference_no`, `status`, `reject_reason`, `transaction_date`, `confirmed_by`, `confirmed_at`) VALUES
(1, 1, 3, 'Full', 26040.00, 26040.00, 'Online', 'Full upon quotation', 'proofs/f3339b14c998fa90f74186f2ca58c0fd.png', '11100 9992 00', 'Confirmed', NULL, '2026-10-05 09:49:06', 2, '2026-10-07 09:50:15'),
(2, 3, 10, 'Down payment', 5628.00, 5628.00, 'Online', 'Half upon quotation', 'proofs/23b1ca1dd1eb640cc57c58222bb7dcf7.jpg', '11100 9992 00', 'Confirmed', NULL, '2026-10-19 12:16:43', 2, '2026-10-19 12:17:16'),
(3, 3, 10, 'Final balance', 5628.00, 5628.00, 'Online', 'Half upon quotation', 'proofs/e1ac4b2f858ae7fd52578bbab02979bc.jpg', '11100 9992 00', 'Confirmed', NULL, '2026-10-19 12:22:17', 2, '2026-10-19 12:22:25'),
(4, 5, 10, 'Down payment', 5040.00, 5040.00, 'Online', 'Half upon quotation', 'proofs/8b97fc7de9abeb58c01b86debfacb056.jpg', '9999 999 999', 'Confirmed', NULL, '2026-10-20 03:27:01', 2, '2026-10-20 03:29:17'),
(5, 5, 10, 'Final balance', 5040.00, 0.00, 'Online', 'Half upon quotation', NULL, NULL, 'Awaiting Payment', NULL, NULL, NULL, NULL),
(6, 6, 10, 'Full', 84000.00, 84000.00, 'Over the counter', 'Full upon quotation', 'proofs/fd8c58a2d1b2135e1c2a6b35bf6652ee.png', '9999 999 999', 'Confirmed', NULL, '2026-10-20 03:47:33', 2, '2026-10-20 03:47:47'),
(7, 8, 10, 'Full', 58240.00, 58240.00, 'Online', 'Full upon quotation', 'proofs/3fd7cb7b955839c4c632fc29c196a9c0.png', '8888', 'Confirmed', NULL, '2026-10-20 04:20:09', 2, '2026-10-20 04:20:52'),
(8, 9, 12, 'Down payment', 4317.60, 4317.60, 'Online', 'Half upon quotation', 'proofs/3d1230d294d26ee2cba8ead24fd7218f.png', '8000', 'Confirmed', NULL, '2026-10-21 12:26:11', 2, '2026-10-21 12:27:28'),
(9, 9, 12, 'Final balance', 4317.60, 0.00, 'Online', 'Half upon quotation', NULL, NULL, 'Not Due', NULL, NULL, NULL, NULL),
(10, 10, 16, 'Down payment', 5208.00, 5208.00, 'Online', 'Half upon quotation', 'proofs/7e136802d3a65b3a610bf2adbfadb114.png', '9999', 'Confirmed', NULL, '2026-10-21 18:48:45', 2, '2026-10-21 18:51:39'),
(11, 10, 16, 'Final balance', 5208.00, 5208.00, 'Online', 'Half upon quotation', 'proofs/32e31c88657318b79d47ed48753ce434.png', '7890', 'Confirmed', NULL, '2026-10-21 19:00:50', 2, '2026-10-21 19:04:29'),
(12, 12, 15, 'Full', 36960.00, 36960.00, 'Online', 'Full upon quotation', 'proofs/8073fe0e91d77d2ac9639148d0d936e0.png', '9999', 'Confirmed', NULL, '2026-10-22 03:07:37', 2, '2026-10-22 03:08:14'),
(13, 13, 16, 'Down payment', 10248.00, 10248.00, 'Online', 'Half upon quotation', 'proofs/4a5f4e84e2fa4090ea1387d2b6c0f4af.png', '8888', 'Confirmed', NULL, '2026-10-22 03:11:16', 2, '2026-10-22 03:11:27'),
(14, 13, 16, 'Final balance', 10248.00, 10248.00, 'Online', 'Half upon quotation', 'proofs/766947fccbbce486e60f2360a053c4fe.png', '8888', 'Confirmed', NULL, '2026-10-22 03:12:18', 2, '2026-10-22 03:12:31'),
(15, 14, 16, 'Down payment', 5992.00, 0.00, 'Online', 'Half upon quotation', NULL, NULL, 'Awaiting Payment', NULL, NULL, NULL, NULL),
(16, 14, 16, 'Final balance', 5992.00, 0.00, 'Online', 'Half upon quotation', NULL, NULL, 'Not Due', NULL, NULL, NULL, NULL),
(17, 15, 16, 'Down payment', 1792.00, 1792.00, 'Online', 'Half upon quotation', 'proofs/c3bd672c40097abde2f6d69a3dde2e4e.jpg', '9999', 'Confirmed', NULL, '2026-10-22 11:29:09', 2, '2026-10-22 11:29:44'),
(18, 15, 16, 'Final balance', 1792.00, 0.00, 'Online', 'Half upon quotation', NULL, NULL, 'Not Due', NULL, NULL, NULL, NULL),
(19, 16, 18, 'Down payment', 2884.00, 2884.00, 'Over the counter', 'Half upon quotation', 'proofs/ff7892b724bceb69a73abfcc021ec0d1.jpg', '1234', 'Confirmed', NULL, '2026-10-22 12:04:52', 2, '2026-10-22 12:06:23'),
(20, 16, 18, 'Final balance', 2884.00, 2884.00, 'Over the counter', 'Half upon quotation', NULL, NULL, 'Confirmed', NULL, '2026-10-22 12:10:18', 2, '2026-10-22 12:10:18'),
(21, 18, 19, 'Down payment', 6272.00, 6272.00, 'Online', 'Half upon quotation', 'proofs/71067fbb7a064001c42b2238700a9ae9.jpg', '8888', 'Confirmed', NULL, '2026-10-22 14:30:09', 2, '2026-10-22 14:31:00'),
(22, 18, 19, 'Final balance', 6272.00, 6272.00, 'Online', 'Half upon quotation', 'proofs/545ca874d6eedf57701d254111d18e09.jpg', '7777', 'Confirmed', NULL, '2026-10-22 14:34:47', 2, '2026-10-22 14:34:56'),
(23, 20, 20, 'Down payment', 7806.40, 0.00, 'Online', 'Half upon quotation', 'proofs/da39543a06cd95ddb7276d6c424f1fc3.jpg', '9999', 'Under Review', NULL, '2026-10-24 04:55:01', NULL, NULL),
(24, 20, 20, 'Final balance', 7806.40, 0.00, 'Online', 'Half upon quotation', NULL, NULL, 'Not Due', NULL, NULL, NULL, NULL),
(25, 21, 20, 'Down payment', 5600.00, 5600.00, 'Over the counter', 'Half upon quotation', 'proofs/2b70de7b58bad1b8e625a15868fb2cf6.jpg', '8888', 'Confirmed', NULL, '2026-10-24 04:53:06', 2, '2026-10-24 04:53:42'),
(26, 21, 20, 'Final balance', 5600.00, 5600.00, 'Over the counter', 'Half upon quotation', 'proofs/102d53db7287feb4be3e3d6e670370f0.jpg', '7899', 'Confirmed', NULL, '2026-10-24 04:57:41', 2, '2026-10-24 04:57:49'),
(27, 22, 15, 'Full', 7280.00, 7280.00, 'Online', 'Full upon quotation', 'proofs/a9db1b78c185768d90c40a053356187c.jpg', '1987', 'Confirmed', NULL, '2026-10-24 08:22:44', 2, '2026-10-24 08:24:57'),
(28, 23, 15, 'Full', 21271.04, 21271.04, 'Over the counter', 'Full upon quotation', 'proofs/1d194a173ce16055a13a5313f93b7584.jpg', '7777', 'Confirmed', NULL, '2026-10-24 09:20:52', 2, '2026-10-24 09:21:25');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(60) NOT NULL DEFAULT 'General',
  `item_type` enum('product','service','package') NOT NULL DEFAULT 'product',
  `specs` text DEFAULT NULL,
  `supplier` varchar(80) DEFAULT NULL,
  `icon` varchar(40) DEFAULT NULL,
  `unit_price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `category`, `item_type`, `specs`, `supplier`, `icon`, `unit_price`, `is_active`, `updated_at`) VALUES
(1, 'IR CCTV Camera 2MP', 'Night-vision weatherproof bullet camera', 'CCTV', 'product', '2MP, 20m IR, IP66', NULL, NULL, 1500.00, 1, NULL),
(2, 'IP CCTV Camera 4MP', 'Network camera with remote viewing', 'CCTV', 'product', '4MP, PoE, H.265', NULL, NULL, 3200.00, 1, NULL),
(3, 'DVR 4-Channel', 'Recorder for analog cameras', 'CCTV', 'product', '4CH, 1080p', NULL, NULL, 3500.00, 1, NULL),
(4, 'NVR 8-Channel', 'Network video recorder', 'CCTV', 'product', '8CH PoE', NULL, NULL, 6500.00, 1, NULL),
(5, 'Biometric Access Terminal', 'Fingerprint / face access + attendance', 'Access Control', 'product', 'Fingerprint + card', NULL, NULL, 7800.00, 1, '2026-10-22 12:21:23'),
(6, 'Smart Door Lock', 'PIN / fingerprint / card entry', 'Access Control', 'product', 'Zinc alloy, 5 modes', NULL, NULL, 9500.00, 1, NULL),
(7, 'Video Intercom Set', 'Door station + indoor unit', 'Intercom', 'product', '7in display', NULL, NULL, 6200.00, 1, NULL),
(8, 'Solar Street Light', 'Dusk-to-dawn LED', 'Lighting', 'product', '60W, motion sensor', NULL, NULL, 8500.00, 1, NULL),
(9, 'CAT6 Cable (305m)', 'Pull box', 'Accessories', 'product', 'Pure copper', NULL, NULL, 4200.00, 1, NULL),
(10, 'Ocular / Site Visit', 'On-site inspection and assessment', 'Services', 'service', NULL, NULL, NULL, 0.00, 1, NULL),
(11, 'Installation Labor', 'Professional installation per device', 'Services', 'service', NULL, NULL, NULL, 800.00, 0, NULL),
(12, 'Mobile Viewing Configuration', 'Per setup. Remote viewing on your phone.', 'Services', 'service', NULL, NULL, NULL, 1000.00, 1, '2026-10-21 11:30:15'),
(13, 'Rough-ins, Piping, Molding', 'Concealed cable routing, per meter', 'Services', 'service', NULL, NULL, NULL, 120.00, 0, NULL),
(14, '4-Camera Home CCTV Package', '4 cameras, 4-ch DVR, cabling and installation', 'CCTV Packages', 'package', NULL, NULL, NULL, 18500.00, 0, '2026-10-21 19:35:47'),
(15, '8-Camera Business CCTV Package', '8 IP cameras, 8-ch NVR, PoE, cabling and installation', 'CCTV Packages', 'package', NULL, NULL, NULL, 52000.00, 0, NULL),
(16, '2-Door Access Control Package', '2 smart locks with access terminal and installation', 'Access Control Packages', 'package', NULL, NULL, NULL, 21500.00, 0, '2026-10-21 19:35:40'),
(17, '500GB Surveillance HDD', '3.5\" surveillance-grade hard drive for DVR/NVR recording', 'Recorders & Storage', 'product', NULL, 'Northpoint Security Distribution', 'fa-database', 2100.00, 1, '2026-10-20 01:42:54'),
(18, '4-Channel DVR', '4-channel 1080P hybrid DVR with mobile app viewing', 'Recorders & Storage', 'product', NULL, 'Northpoint Security Distribution', 'fa-hard-drive', 3900.00, 1, '2026-10-20 01:42:54'),
(19, 'IP Camera 4MP (Turret)', '4MP PoE turret camera, 30m IR night vision, IP67', 'Cameras', 'product', NULL, 'Northpoint Security Distribution', 'fa-video', 3600.00, 1, '2026-10-20 01:42:54'),
(20, 'RG59 Siamese Cable (305m Box)', 'Coaxial video + power cable for analog/HD CCTV', 'Power & Cabling', 'product', NULL, 'Cablenet Electrical Supply', 'fa-network-wired', 3200.00, 1, '2026-10-20 01:42:54'),
(21, 'BNC & DC Connector Set (10 pairs)', 'Twist-on BNC and DC male connectors', 'Power & Cabling', 'product', NULL, 'Cablenet Electrical Supply', 'fa-plug', 450.00, 1, '2026-10-20 01:42:54'),
(22, '12V 10A CCTV Power Supply Box', 'Centralized 9-output power supply for up to 8 cameras', 'Power & Cabling', 'product', NULL, 'Cablenet Electrical Supply', 'fa-car-battery', 1450.00, 1, '2026-10-20 01:42:54'),
(23, 'Magnetic Door Lock 600lbs', 'Electromagnetic lock with mounting bracket', 'Access Control', 'product', NULL, 'Lockwise Access Systems', 'fa-door-closed', 2800.00, 1, '2026-10-20 01:42:54'),
(24, 'Exit Push Button', 'Stainless request-to-exit button', 'Access Control', 'product', NULL, 'Lockwise Access Systems', 'fa-hand-pointer', 400.00, 1, '2026-10-22 05:50:49'),
(25, 'Solar Streetlight 100W', 'All-in-one solar streetlight with motion sensor and remote', 'Solar & Lighting', 'product', NULL, 'Sunvolt Solar Trading', 'fa-solar-panel', 24500.00, 1, '2026-10-20 01:42:54'),
(26, 'Hikvision 2MP 4CH HDTVI Combo Kit (TVI-4CH2D2B-2MP Eco 2.8mm)', 'DS-7204HGHI-M1 DVR, 2x DS-2CE76D0T-EXIPF turret, 2x DS-2CE16D0T-EXIPF bullet (2.8mm). 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 6110.00, 1, '2026-10-20 01:42:54'),
(27, 'Hikvision 2MP 8CH HDTVI Combo Kit (TVI-8CH4D4B-2MP Eco 2.8mm)', 'DS-7208HGHI-M1 DVR, 4x DS-2CE76D0T-EXIPF turret, 4x DS-2CE16D0T-EXIPF bullet (2.8mm). 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 10270.00, 1, '2026-10-20 01:42:54'),
(28, 'Hikvision 2MP 4CH Lite ColorVu Kit with Mic (2.8mm)', 'TVI-Lite-4CH2D2B-2MP-ColorVu(2.8): DS-7204HGHI-M1 DVR, 2x DS-2CE10DF3T-PFS, 2x DS-2CE70DF3T-PFS. Built-in mic. 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 9430.00, 1, '2026-10-20 01:42:54'),
(29, 'Hikvision 2MP 4CH Lite ColorVu Kit with Mic (3.6mm)', 'TVI-Lite-4CH2D2B-2MP-ColorVu: DS-7204HGHI-K1(S) DVR, 2x DS-2CE10DF3T-PFS, 2x DS-2CE70DF3T-PFS. Built-in mic. 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 9430.00, 1, '2026-10-20 01:42:54'),
(30, 'Hikvision 2MP 8CH Lite ColorVu Kit with Mic (2.8mm)', 'TVI-Lite-8CH4D4B-2MP-ColorVu(2.8): DS-7208HGHI-M1 DVR, 4x DS-2CE10DF3T-PFS, 4x DS-2CE70DF3T-PFS. Built-in mic. 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 16970.00, 1, '2026-10-20 01:42:54'),
(31, 'Hikvision 5MP 4CH HDTVI Combo Kit (TVI-4CH2D2B-5MP)', 'DS-7204HUHI-K1/E(S) DVR, 2x DS-2CE16H0T-ITPF(C) bullet, 2x DS-2CE76H0T-ITPF(C) turret. 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 10170.00, 1, '2026-10-20 01:42:54'),
(32, 'Hikvision 5MP 8CH HDTVI Combo Kit (TVI-8CH4D4B-5MP)', 'DS-7208HUHI-K1/E(S) DVR, 4x DS-2CE16H0T-ITPF(C) bullet, 4x DS-2CE76H0T-ITPF(C) turret. 2-yr warranty', 'CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-video', 18850.00, 1, '2026-10-20 01:42:54'),
(33, 'Hikvision 2MP 2CH Wi-Fi Kit, 2 Bullet (NKS422W0H)', 'DS-7104NI-S1/W NVR, 2x IPC-B120HA-LIDF/W bullet. 2-yr warranty', 'Wi-Fi CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-wifi', 3940.00, 1, '2026-10-20 01:42:54'),
(34, 'Hikvision 2MP 2CH Wi-Fi Kit, Bullet + Turret (NKS422W02H)', 'DS-7104NI-S1/W NVR, 1x IPC-B120HA-LIDF/W bullet, 1x IPC-F120-LIDF/W turret. 2-yr warranty', 'Wi-Fi CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-wifi', 4280.00, 1, '2026-10-20 01:42:54'),
(35, 'Hikvision 2MP 4CH Wi-Fi Combo Kit (NK42W0H(D))', 'DS-7104NI-K1/W/M(C) NVR, 4x DS-2CV1021G1-IDW (2.8mm). 2-yr warranty', 'Wi-Fi CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-wifi', 12460.00, 1, '2026-10-20 01:42:54'),
(36, 'Hikvision 4MP 4CH Wi-Fi Combo Kit (NK44W0H(D))', 'DS-7104NI-K1/W/M(C) NVR, 4x DS-2CV1041G1-IDW (2.8mm). 2-yr warranty', 'Wi-Fi CCTV Kits', 'product', NULL, 'Nanotec Corp. (Hikvision)', 'fa-wifi', 16730.00, 1, '2026-10-20 01:42:54'),
(37, 'Dahua 2MP 4CH HDCVI Kit (DH-KIT1B04)', '1x DH-XVR1B04 DVR, 2x HAC-B1A21N bullet, 2x HAC-T1A21N turret', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 6210.00, 1, '2026-10-20 01:42:54'),
(38, 'Dahua 2MP 8CH HDCVI Kit (DH-KIT1B08)', '1x DH-XVR1B08 DVR, 4x HAC-B1A21N bullet, 4x HAC-T1A21N turret', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 10430.00, 1, '2026-10-20 01:42:54'),
(39, 'Dahua 2MP 4CH WizSense Kit (DH-KIT-CVI2MP2B2T-I)', '1x XVR1B04-I DVR, 2x B1A21N-0360B bullet, 2x T1A21N-0360B turret', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 6210.00, 1, '2026-10-20 01:42:54'),
(40, 'Dahua 2MP 8CH WizSense Kit (DH-KIT-CVI2MP4B4T-I)', '1x XVR1B08-I DVR, 4x B1A21N-0360B bullet, 4x T1A21N-0360B turret', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 10430.00, 1, '2026-10-20 01:42:54'),
(41, 'Dahua 2MP 4CH Full Color Kit (DH-KIT-CVI2MP2B2T-I)', '1x XVR1B04-I DVR, 2x HFW1239CN-A-LED bullet, 2x HDW1239TLQN-A-LED turret', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 11740.00, 1, '2026-10-20 01:42:54'),
(42, 'Dahua 2MP 8CH Full Color Kit (DH-KIT-CVI2MP4B4T-I)', '1x XVR1B08-I DVR, 4x HFW1239CN-A-LED bullet, 4x HDW1239TLQN-A-LED turret', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 21520.00, 1, '2026-10-20 01:42:54'),
(43, 'Dahua 2MP 4CH SDL Kit (DH-KIT-CVI2MP2B2T-SDL)', '1x DH-XVR1B04-I DVR, 2x HFW1239TLMN-IL-A bullet, 2x HDW1239TLQN-IL-A turret, 4 video power cables, 1 power adapter', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 13385.00, 1, '2026-10-20 01:42:54'),
(44, 'Dahua 2MP 8CH SDL Kit (DH-KIT-CVI2MP4B4T-SDL)', '1x DH-XVR1B08-I DVR, 4x HFW1239TLMN-IL-A bullet, 4x HDW1239TLQN-IL-A turret, 8 video power cables, 2 power adapters', 'CCTV Kits', 'product', NULL, 'Dahua Technology', 'fa-video', 24815.00, 1, '2026-10-20 01:42:54'),
(45, '2-Channel CCTV Package', 'Perfect for small spaces. 2 cameras with built-in mic, 1 DVR, 1 500GB HDD, all accessories, free installation. 1-yr product, 90-day service warranty', 'CCTV Packages', 'package', NULL, NULL, 'fa-box-open', 8500.00, 1, '2026-10-20 01:42:54'),
(46, '3-Channel CCTV Package', 'Ideal for homes & small businesses. 3 cameras with built-in mic, 1 DVR, 1 500GB HDD, all accessories, free installation. 1-yr product, 90-day service warranty', 'CCTV Packages', 'package', NULL, NULL, 'fa-box-open', 12500.00, 1, '2026-10-20 01:42:54'),
(47, '4-Channel CCTV Package', 'Complete coverage for your property. 4 cameras with built-in mic, 1 DVR, 1 500GB HDD, all accessories, free installation. 1-yr product, 90-day service warranty', 'CCTV Packages', 'package', NULL, NULL, 'fa-box-open', 16500.00, 1, '2026-10-20 01:42:54'),
(48, '2-Channel CCTV Set, 2MP/1080P Standard', '2 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 7000.00, 1, '2026-10-20 01:42:54'),
(49, '2-Channel CCTV Set, 2MP/1080P Full Color', '2 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 9000.00, 1, '2026-10-20 01:42:54'),
(50, '2-Channel CCTV Set, 2MP/1080P with Built-in Mic', '2 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 8000.00, 1, '2026-10-20 01:42:54'),
(51, '2-Channel CCTV Set, 2MP/1080P Full Color with Mic', '2 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 10000.00, 1, '2026-10-20 01:42:54'),
(52, '2-Channel CCTV Set, 5MP/3K Standard', '2 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 10000.00, 1, '2026-10-20 01:42:54'),
(53, '2-Channel CCTV Set, 5MP/3K Full Color', '2 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 12000.00, 1, '2026-10-20 01:42:54'),
(54, '2-Channel CCTV Set, 5MP/3K with Built-in Mic', '2 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 11000.00, 1, '2026-10-20 01:42:54'),
(55, '2-Channel CCTV Set, 5MP/3K Full Color with Mic', '2 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 13000.00, 1, '2026-10-20 01:42:54'),
(56, '3-Channel CCTV Set, 2MP/1080P Standard', '3 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 10500.00, 1, '2026-10-20 01:42:54'),
(57, '3-Channel CCTV Set, 2MP/1080P Full Color', '3 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 13500.00, 1, '2026-10-20 01:42:54'),
(58, '3-Channel CCTV Set, 2MP/1080P with Built-in Mic', '3 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 12000.00, 1, '2026-10-20 01:42:54'),
(59, '3-Channel CCTV Set, 2MP/1080P Full Color with Mic', '3 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 15000.00, 1, '2026-10-20 01:42:54'),
(60, '3-Channel CCTV Set, 5MP/3K Standard', '3 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 15000.00, 1, '2026-10-20 01:42:54'),
(61, '3-Channel CCTV Set, 5MP/3K Full Color', '3 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 18000.00, 1, '2026-10-20 01:42:54'),
(62, '3-Channel CCTV Set, 5MP/3K with Built-in Mic', '3 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 16500.00, 1, '2026-10-20 01:42:54'),
(63, '3-Channel CCTV Set, 5MP/3K Full Color with Mic', '3 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 19500.00, 1, '2026-10-20 01:42:54'),
(64, '4-Channel CCTV Set, 2MP/1080P Standard', '4 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 14000.00, 1, '2026-10-20 01:42:54'),
(65, '4-Channel CCTV Set, 2MP/1080P Full Color', '4 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 18000.00, 1, '2026-10-20 01:42:54'),
(66, '4-Channel CCTV Set, 2MP/1080P with Built-in Mic', '4 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 16000.00, 1, '2026-10-20 01:42:54'),
(67, '4-Channel CCTV Set, 2MP/1080P Full Color with Mic', '4 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 20000.00, 1, '2026-10-20 01:42:54'),
(68, '4-Channel CCTV Set, 5MP/3K Standard', '4 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 20000.00, 1, '2026-10-20 01:42:54'),
(69, '4-Channel CCTV Set, 5MP/3K Full Color', '4 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 24000.00, 1, '2026-10-20 01:42:54'),
(70, '4-Channel CCTV Set, 5MP/3K with Built-in Mic', '4 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 22000.00, 1, '2026-10-20 01:42:54'),
(71, '4-Channel CCTV Set, 5MP/3K Full Color with Mic', '4 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 26000.00, 1, '2026-10-20 01:42:54'),
(72, '5-Channel CCTV Set, 2MP/1080P Standard', '5 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 17500.00, 1, '2026-10-20 01:42:54'),
(73, '5-Channel CCTV Set, 2MP/1080P Full Color', '5 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 22500.00, 1, '2026-10-20 01:42:54'),
(74, '5-Channel CCTV Set, 2MP/1080P with Built-in Mic', '5 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 20000.00, 1, '2026-10-20 01:42:54'),
(75, '5-Channel CCTV Set, 2MP/1080P Full Color with Mic', '5 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 25000.00, 1, '2026-10-20 01:42:54'),
(76, '5-Channel CCTV Set, 5MP/3K Standard', '5 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 25000.00, 1, '2026-10-20 01:42:54'),
(77, '5-Channel CCTV Set, 5MP/3K Full Color', '5 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 30000.00, 1, '2026-10-20 01:42:54'),
(78, '5-Channel CCTV Set, 5MP/3K with Built-in Mic', '5 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 27500.00, 1, '2026-10-20 01:42:54'),
(79, '5-Channel CCTV Set, 5MP/3K Full Color with Mic', '5 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 32500.00, 1, '2026-10-20 01:42:54'),
(80, '6-Channel CCTV Set, 2MP/1080P Standard', '6 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 21000.00, 1, '2026-10-20 01:42:54'),
(81, '6-Channel CCTV Set, 2MP/1080P Full Color', '6 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 27000.00, 1, '2026-10-20 01:42:54'),
(82, '6-Channel CCTV Set, 2MP/1080P with Built-in Mic', '6 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 24000.00, 1, '2026-10-20 01:42:54'),
(83, '6-Channel CCTV Set, 2MP/1080P Full Color with Mic', '6 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 30000.00, 1, '2026-10-20 01:42:54'),
(84, '6-Channel CCTV Set, 5MP/3K Standard', '6 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 30000.00, 1, '2026-10-20 01:42:54'),
(85, '6-Channel CCTV Set, 5MP/3K Full Color', '6 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 36000.00, 1, '2026-10-20 01:42:54'),
(86, '6-Channel CCTV Set, 5MP/3K with Built-in Mic', '6 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 33000.00, 1, '2026-10-20 01:42:54'),
(87, '6-Channel CCTV Set, 5MP/3K Full Color with Mic', '6 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 39000.00, 1, '2026-10-20 01:42:54'),
(88, '7-Channel CCTV Set, 2MP/1080P Standard', '7 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 24500.00, 1, '2026-10-20 01:42:54'),
(89, '7-Channel CCTV Set, 2MP/1080P Full Color', '7 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 31500.00, 1, '2026-10-20 01:42:54'),
(90, '7-Channel CCTV Set, 2MP/1080P with Built-in Mic', '7 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 28000.00, 1, '2026-10-20 01:42:54'),
(91, '7-Channel CCTV Set, 2MP/1080P Full Color with Mic', '7 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 35000.00, 1, '2026-10-20 01:42:54'),
(92, '7-Channel CCTV Set, 5MP/3K Standard', '7 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 35000.00, 1, '2026-10-20 01:42:54'),
(93, '7-Channel CCTV Set, 5MP/3K Full Color', '7 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 42000.00, 1, '2026-10-20 01:42:54'),
(94, '7-Channel CCTV Set, 5MP/3K with Built-in Mic', '7 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 38500.00, 1, '2026-10-20 01:42:54'),
(95, '7-Channel CCTV Set, 5MP/3K Full Color with Mic', '7 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 45500.00, 1, '2026-10-20 01:42:54'),
(96, '8-Channel CCTV Set, 2MP/1080P Standard', '8 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 28000.00, 1, '2026-10-20 01:42:54'),
(97, '8-Channel CCTV Set, 2MP/1080P Full Color', '8 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 36000.00, 1, '2026-10-20 01:42:54'),
(98, '8-Channel CCTV Set, 2MP/1080P with Built-in Mic', '8 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 32000.00, 1, '2026-10-20 01:42:54'),
(99, '8-Channel CCTV Set, 2MP/1080P Full Color with Mic', '8 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 40000.00, 1, '2026-10-20 01:42:54'),
(100, '8-Channel CCTV Set, 5MP/3K Standard', '8 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 40000.00, 1, '2026-10-20 01:42:54'),
(101, '8-Channel CCTV Set, 5MP/3K Full Color', '8 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 48000.00, 1, '2026-10-20 01:42:54'),
(102, '8-Channel CCTV Set, 5MP/3K with Built-in Mic', '8 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 44000.00, 1, '2026-10-20 01:42:54'),
(103, '8-Channel CCTV Set, 5MP/3K Full Color with Mic', '8 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 52000.00, 1, '2026-10-20 01:42:54'),
(104, '9-Channel CCTV Set, 2MP/1080P Standard', '9 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 31500.00, 1, '2026-10-20 01:42:54'),
(105, '9-Channel CCTV Set, 2MP/1080P Full Color', '9 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 40500.00, 1, '2026-10-20 01:42:54'),
(106, '9-Channel CCTV Set, 2MP/1080P with Built-in Mic', '9 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 36000.00, 1, '2026-10-20 01:42:54'),
(107, '9-Channel CCTV Set, 2MP/1080P Full Color with Mic', '9 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 45000.00, 1, '2026-10-20 01:42:54'),
(108, '9-Channel CCTV Set, 5MP/3K Standard', '9 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 45000.00, 1, '2026-10-20 01:42:54'),
(109, '9-Channel CCTV Set, 5MP/3K Full Color', '9 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 54000.00, 1, '2026-10-20 01:42:54'),
(110, '9-Channel CCTV Set, 5MP/3K with Built-in Mic', '9 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 49500.00, 1, '2026-10-20 01:42:54'),
(111, '9-Channel CCTV Set, 5MP/3K Full Color with Mic', '9 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 58500.00, 1, '2026-10-20 01:42:54'),
(112, '10-Channel CCTV Set, 2MP/1080P Standard', '10 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 35000.00, 1, '2026-10-20 01:42:54'),
(113, '10-Channel CCTV Set, 2MP/1080P Full Color', '10 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 45000.00, 1, '2026-10-20 01:42:54'),
(114, '10-Channel CCTV Set, 2MP/1080P with Built-in Mic', '10 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 40000.00, 1, '2026-10-20 01:42:54'),
(115, '10-Channel CCTV Set, 2MP/1080P Full Color with Mic', '10 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 50000.00, 1, '2026-10-20 01:42:54'),
(116, '10-Channel CCTV Set, 5MP/3K Standard', '10 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 50000.00, 1, '2026-10-20 01:42:54'),
(117, '10-Channel CCTV Set, 5MP/3K Full Color', '10 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 60000.00, 1, '2026-10-20 01:42:54'),
(118, '10-Channel CCTV Set, 5MP/3K with Built-in Mic', '10 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 55000.00, 1, '2026-10-20 01:42:54'),
(119, '10-Channel CCTV Set, 5MP/3K Full Color with Mic', '10 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 65000.00, 1, '2026-10-20 01:42:54'),
(120, '11-Channel CCTV Set, 2MP/1080P Standard', '11 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 38500.00, 1, '2026-10-20 01:42:54'),
(121, '11-Channel CCTV Set, 2MP/1080P Full Color', '11 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 49500.00, 1, '2026-10-20 01:42:54'),
(122, '11-Channel CCTV Set, 2MP/1080P with Built-in Mic', '11 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 44000.00, 1, '2026-10-20 01:42:54'),
(123, '11-Channel CCTV Set, 2MP/1080P Full Color with Mic', '11 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 55000.00, 1, '2026-10-20 01:42:54'),
(124, '11-Channel CCTV Set, 5MP/3K Standard', '11 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 55000.00, 1, '2026-10-20 01:42:54'),
(125, '11-Channel CCTV Set, 5MP/3K Full Color', '11 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 66000.00, 1, '2026-10-20 01:42:54'),
(126, '11-Channel CCTV Set, 5MP/3K with Built-in Mic', '11 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 60500.00, 1, '2026-10-20 01:42:54'),
(127, '11-Channel CCTV Set, 5MP/3K Full Color with Mic', '11 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 71500.00, 1, '2026-10-20 01:42:54'),
(128, '12-Channel CCTV Set, 2MP/1080P Standard', '12 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 42000.00, 1, '2026-10-20 01:42:54'),
(129, '12-Channel CCTV Set, 2MP/1080P Full Color', '12 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 54000.00, 1, '2026-10-20 01:42:54'),
(130, '12-Channel CCTV Set, 2MP/1080P with Built-in Mic', '12 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 48000.00, 1, '2026-10-20 01:42:54'),
(131, '12-Channel CCTV Set, 2MP/1080P Full Color with Mic', '12 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 60000.00, 1, '2026-10-20 01:42:54'),
(132, '12-Channel CCTV Set, 5MP/3K Standard', '12 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 60000.00, 1, '2026-10-20 01:42:54'),
(133, '12-Channel CCTV Set, 5MP/3K Full Color', '12 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 72000.00, 1, '2026-10-20 01:42:54'),
(134, '12-Channel CCTV Set, 5MP/3K with Built-in Mic', '12 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 66000.00, 1, '2026-10-20 01:42:54'),
(135, '12-Channel CCTV Set, 5MP/3K Full Color with Mic', '12 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 78000.00, 1, '2026-10-20 01:42:54'),
(136, '13-Channel CCTV Set, 2MP/1080P Standard', '13 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 45500.00, 1, '2026-10-20 01:42:54'),
(137, '13-Channel CCTV Set, 2MP/1080P Full Color', '13 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 58500.00, 1, '2026-10-20 01:42:54'),
(138, '13-Channel CCTV Set, 2MP/1080P with Built-in Mic', '13 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 52000.00, 1, '2026-10-20 01:42:54'),
(139, '13-Channel CCTV Set, 2MP/1080P Full Color with Mic', '13 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 65000.00, 1, '2026-10-20 01:42:54'),
(140, '13-Channel CCTV Set, 5MP/3K Standard', '13 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 65000.00, 1, '2026-10-20 01:42:54'),
(141, '13-Channel CCTV Set, 5MP/3K Full Color', '13 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 78000.00, 1, '2026-10-20 01:42:54'),
(142, '13-Channel CCTV Set, 5MP/3K with Built-in Mic', '13 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 71500.00, 1, '2026-10-20 01:42:54'),
(143, '13-Channel CCTV Set, 5MP/3K Full Color with Mic', '13 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 84500.00, 1, '2026-10-20 01:42:54'),
(144, '14-Channel CCTV Set, 2MP/1080P Standard', '14 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 49000.00, 1, '2026-10-20 01:42:54'),
(145, '14-Channel CCTV Set, 2MP/1080P Full Color', '14 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 63000.00, 1, '2026-10-20 01:42:54'),
(146, '14-Channel CCTV Set, 2MP/1080P with Built-in Mic', '14 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 56000.00, 1, '2026-10-20 01:42:54'),
(147, '14-Channel CCTV Set, 2MP/1080P Full Color with Mic', '14 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 70000.00, 1, '2026-10-20 01:42:54'),
(148, '14-Channel CCTV Set, 5MP/3K Standard', '14 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 70000.00, 1, '2026-10-20 01:42:54'),
(149, '14-Channel CCTV Set, 5MP/3K Full Color', '14 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 84000.00, 1, '2026-10-20 01:42:54'),
(150, '14-Channel CCTV Set, 5MP/3K with Built-in Mic', '14 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 77000.00, 1, '2026-10-20 01:42:54'),
(151, '14-Channel CCTV Set, 5MP/3K Full Color with Mic', '14 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 91000.00, 1, '2026-10-20 01:42:54'),
(152, '15-Channel CCTV Set, 2MP/1080P Standard', '15 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 52500.00, 1, '2026-10-20 01:42:54'),
(153, '15-Channel CCTV Set, 2MP/1080P Full Color', '15 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 67500.00, 1, '2026-10-20 01:42:54'),
(154, '15-Channel CCTV Set, 2MP/1080P with Built-in Mic', '15 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 60000.00, 1, '2026-10-20 01:42:54'),
(155, '15-Channel CCTV Set, 2MP/1080P Full Color with Mic', '15 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 75000.00, 1, '2026-10-20 01:42:54'),
(156, '15-Channel CCTV Set, 5MP/3K Standard', '15 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 75000.00, 1, '2026-10-20 01:42:54'),
(157, '15-Channel CCTV Set, 5MP/3K Full Color', '15 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 90000.00, 1, '2026-10-20 01:42:54'),
(158, '15-Channel CCTV Set, 5MP/3K with Built-in Mic', '15 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 82500.00, 1, '2026-10-20 01:42:54'),
(159, '15-Channel CCTV Set, 5MP/3K Full Color with Mic', '15 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 97500.00, 1, '2026-10-20 01:42:54'),
(160, '16-Channel CCTV Set, 2MP/1080P Standard', '16 cameras (2MP/1080P, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 56000.00, 1, '2026-10-20 01:42:54'),
(161, '16-Channel CCTV Set, 2MP/1080P Full Color', '16 cameras (2MP/1080P, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 72000.00, 1, '2026-10-20 01:42:54'),
(162, '16-Channel CCTV Set, 2MP/1080P with Built-in Mic', '16 cameras (2MP/1080P, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 64000.00, 1, '2026-10-20 01:42:54'),
(163, '16-Channel CCTV Set, 2MP/1080P Full Color with Mic', '16 cameras (2MP/1080P, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 80000.00, 1, '2026-10-20 01:42:54'),
(164, '16-Channel CCTV Set, 5MP/3K Standard', '16 cameras (5MP/3K, standard) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 80000.00, 1, '2026-10-20 01:42:54'),
(165, '16-Channel CCTV Set, 5MP/3K Full Color', '16 cameras (5MP/3K, full color) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 96000.00, 1, '2026-10-20 01:42:54'),
(166, '16-Channel CCTV Set, 5MP/3K with Built-in Mic', '16 cameras (5MP/3K, with built-in mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 88000.00, 1, '2026-10-20 01:42:54'),
(167, '16-Channel CCTV Set, 5MP/3K Full Color with Mic', '16 cameras (5MP/3K, full color with mic) with DVR. Dahua/Hikvision package pricelist', 'CCTV Package Sets', 'product', NULL, 'Dahua & Hikvision Package Pricelist', 'fa-layer-group', 104000.00, 1, '2026-10-20 01:42:54'),
(168, 'Installation - Open / Exposed Wiring', 'Per camera. Installation with open (exposed) wiring.', '', 'service', NULL, NULL, 'fa-screwdriver-wrench', 1500.00, 1, '2026-10-21 11:30:15'),
(169, 'Installation - with Molding', 'Per camera. Installation with wiring in molding.', '', 'service', NULL, NULL, 'fa-screwdriver-wrench', 2000.00, 1, '2026-10-21 11:30:15'),
(170, 'Installation - with Rough-ins', 'Per camera. Installation with rough-ins (concealed piping).', '', 'service', NULL, NULL, 'fa-screwdriver-wrench', 2500.00, 1, '2026-10-21 11:30:15'),
(171, 'CCTV Footage Retrieval and Review Fee', 'Per request. Technical assistance in locating, reviewing, and retrieving recorded CCTV footage upon customer request, including footage intended for investigation or legal proceedings.', '', 'service', NULL, NULL, 'fa-film', 1500.00, 1, '2026-10-21 11:30:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_price_history`
--

CREATE TABLE `product_price_history` (
  `history_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `old_price` decimal(12,2) NOT NULL,
  `new_price` decimal(12,2) NOT NULL,
  `note` varchar(120) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_price_history`
--

INSERT INTO `product_price_history` (`history_id`, `product_id`, `old_price`, `new_price`, `note`, `changed_by`, `changed_at`) VALUES
(1, 24, 350.00, 400.00, NULL, 2, '2026-10-22 05:50:49');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `inquiry_id` int(11) DEFAULT NULL,
  `project_name` varchar(160) DEFAULT NULL,
  `project_lead` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('Awaiting Payment','Payment Under Review','Installation In Progress','Awaiting Final Payment','Done','Failed') NOT NULL DEFAULT 'Awaiting Payment',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `install_status` enum('Scheduled','In progress','Completed') DEFAULT NULL,
  `checklist` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `customer_id`, `inquiry_id`, `project_name`, `project_lead`, `start_date`, `end_date`, `status`, `created_at`, `install_status`, `checklist`) VALUES
(1, 3, 2, 'Tender Juicy', NULL, '2026-10-07', '2026-10-07', 'Done', '2026-10-07 09:47:48', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(2, 10, 6, 'Jasper\'s Security', NULL, '2026-10-19', '2026-10-19', 'Done', '2026-10-19 12:15:10', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(3, 10, 7, 'Jasper Veranda', NULL, '2026-10-20', '2026-10-20', 'Awaiting Final Payment', '2026-10-20 03:26:24', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(4, 10, 8, 'Jasper Store', NULL, '2026-10-27', NULL, 'Installation In Progress', '2026-10-20 03:47:03', 'Scheduled', NULL),
(5, 10, 10, 'Jasper St. Claire College', NULL, '2026-10-20', '2026-10-20', 'Done', '2026-10-20 04:19:11', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(6, 12, 13, 'First Project', NULL, '2026-10-23', NULL, 'Installation In Progress', '2026-10-21 12:25:42', 'Scheduled', NULL),
(7, 16, 15, 'Project 1', NULL, '2026-10-21', '2026-10-21', 'Done', '2026-10-21 18:43:54', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(8, 15, 11, 'Jasper\'s Sari Sari Store', NULL, '2026-10-27', NULL, 'Installation In Progress', '2026-10-22 03:05:31', 'Scheduled', NULL),
(9, 16, 16, 'Allexis Grocery Store', NULL, '2026-10-22', '2026-10-22', 'Done', '2026-10-22 03:10:59', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(10, 16, 17, 'Allexis New House', NULL, '2026-10-24', NULL, 'Awaiting Payment', '2026-10-22 03:26:44', 'Scheduled', NULL),
(11, 16, 18, 'Library', NULL, '2026-10-24', NULL, 'Installation In Progress', '2026-10-22 11:26:51', 'Scheduled', NULL),
(12, 18, 19, 'Library', NULL, '2026-10-22', '2026-10-22', 'Done', '2026-10-22 12:03:10', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(13, 19, 23, 'UCC', NULL, '2026-10-22', '2026-10-22', 'Done', '2026-10-22 14:27:24', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(14, 20, 29, 'BeyondWires Security', NULL, '2026-10-27', NULL, 'Payment Under Review', '2026-10-24 04:40:53', 'Scheduled', NULL),
(15, 20, 30, 'Harry Styles Concert', NULL, '2026-10-24', '2026-10-24', 'Done', '2026-10-24 04:47:33', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(16, 15, 33, 'Jasper Dunkin Donut', NULL, '2026-10-24', '2026-10-24', 'Done', '2026-10-24 08:22:15', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]'),
(17, 15, 37, 'Jasper and his turtle', NULL, '2026-10-24', '2026-10-24', 'Done', '2026-10-24 09:20:37', 'Completed', '[{\"label\":\"Site preparation\",\"state\":\"Done\"},{\"label\":\"Equipment mounting\",\"state\":\"Done\"},{\"label\":\"Cabling & PoE\",\"state\":\"Done\"},{\"label\":\"Recorder setup & configuration\",\"state\":\"Done\"},{\"label\":\"Testing & customer handover\",\"state\":\"Done\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `project_certificates`
--

CREATE TABLE `project_certificates` (
  `project_id` int(11) NOT NULL,
  `data` mediumtext NOT NULL,
  `sent_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_certificates`
--

INSERT INTO `project_certificates` (`project_id`, `data`, `sent_at`, `updated_at`) VALUES
(1, '{\"system\":\"CCTV\",\"title\":\"Installation of Tender Juicy for Tender Juicy\",\"work\":\"Tender Juicy\",\"location\":\"Camarin Caloocan City\",\"manager\":\"Richiebelle Del Rosario\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Tender Juicy for Tender Juicy. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × 4-Camera Home CCTV Package at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-07\",\"end\":\"2026-10-07\"}', '2026-10-07 09:51:22', '2026-10-07 09:51:22'),
(2, '{\"system\":\"CCTV\",\"title\":\"Installation of Jasper\'s Security for Jasper Olarte\",\"work\":\"Jasper\'s Security\",\"location\":\"Mabolo Camarin Caloocan City\",\"manager\":\"Richiebelle\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Jasper\'s Security for Jasper Olarte. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × DVR 4-Channel, 1 × NVR 8-Channel at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-19\",\"end\":\"2026-10-19\"}', '2026-10-19 12:23:49', '2026-10-19 12:23:49'),
(5, '{\"system\":\"CCTV\",\"title\":\"Installation of Jasper St. Claire College for Jasper Olarte\",\"work\":\"Jasper St. Claire College\",\"location\":\"Parañaque City\",\"manager\":\"Richiebelle Del Rosario\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Jasper St. Claire College for Jasper Olarte. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × 8-Camera Business CCTV Package at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-20\",\"end\":\"2026-10-20\"}', '2026-10-20 04:22:09', '2026-10-20 04:22:09'),
(7, '{\"system\":\"CCTV\",\"title\":\"Installation of Project 1 for Allexis Gomez\",\"work\":\"Project 1\",\"location\":\"Lot 5 Blk 2, Banglolao, Bucay, Abra\",\"manager\":\"Richiebelle\",\"team\":\"Richiebelle, Dustin, Angelyn\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Project 1 for Allexis Gomez. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × Biometric Access Terminal at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-21\",\"end\":\"2026-10-21\"}', '2026-10-21 19:04:21', '2026-10-21 19:04:21'),
(9, '{\"system\":\"CCTV\",\"title\":\"Installation of Allexis Grocery Store for Allexis Gomez\",\"work\":\"Allexis Grocery Store\",\"location\":\"Kaagapay Street, Atok, Flora, Apayao\",\"manager\":\"Richiebelle\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Allexis Grocery Store for Allexis Gomez. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × Magnetic Door Lock 600lbs, 1 × CAT6 Cable (305m), 1 × Biometric Access Terminal, 1 × DVR 4-Channel at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-22\",\"end\":\"2026-10-22\"}', '2026-10-22 03:13:51', '2026-10-22 03:13:51'),
(12, '{\"system\":\"CCTV\",\"title\":\"Installation of Library for Angelyn ed\",\"work\":\"Library\",\"location\":\"Phase 10b Package 5 Block 34 Lot 1 Bagong Silang, Barangay 176-F, Caloocan City, Metro Manila\",\"manager\":\"Mr. Yujin Isabbelo\",\"team\":\"Dustin Yu, Richiebelle Del Rosario\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Library for Angelyn ed. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × IR CCTV Camera 2MP, 1 × DVR 4-Channel at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-22\",\"end\":\"2026-10-22\"}', '2026-10-22 12:12:23', '2026-10-22 12:12:23'),
(13, '{\"system\":\"CCTV\",\"title\":\"Installation of UCC for Dustin Yu\",\"work\":\"UCC\",\"location\":\"Lot 5 Blk 2 B.S.C.C, Anislag, Daraga, Albay\",\"manager\":\"Richiebelle\",\"team\":\"HELLO 123\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of UCC for Dustin Yu. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 4 × Magnetic Door Lock 600lbs at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-22\",\"end\":\"2026-10-22\"}', '2026-10-22 14:33:58', '2026-10-22 14:33:58'),
(15, '{\"system\":\"CCTV\",\"title\":\"Installation of Harry Styles Concert for Harry Styles\",\"work\":\"Harry Styles Concert\",\"location\":\"Kaagapay Street, Canadam, Maconacon, Isabela\",\"manager\":\"Louis Tomlinson\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Harry Styles Concert for Harry Styles. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed the equipment listed in the quotation at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-24\",\"end\":\"2026-10-24\"}', '2026-10-24 04:58:27', '2026-10-24 04:58:27'),
(16, '{\"system\":\"CCTV\",\"title\":\"Installation of Jasper Dunkin Donut for Jasper Olarte\",\"work\":\"Jasper Dunkin Donut\",\"location\":\"Lot 44 Blk 108 Pkg 5a, Balasbas, Manito, Albay\",\"manager\":\"Richiebelle Del Rosario\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Jasper Dunkin Donut for Jasper Olarte. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed the equipment listed in the quotation at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-24\",\"end\":\"2026-10-24\"}', '2026-10-24 08:27:12', '2026-10-24 08:27:12'),
(17, '{\"system\":\"CCTV\",\"title\":\"Installation of Jasper and his turtle for Jasper Olarte\",\"work\":\"Jasper and his turtle\",\"location\":\"Lot 44 Blk 108 Pkg 5a, Bantonan, Camalig, Albay\",\"manager\":\"Richiebelle Del Rosario\",\"team\":\"\",\"contractor\":\"Eugene P. Isabelo\",\"residence\":\"9999 Rosal St., San Lazaro, Brgy. 187 Tala, Caloocan City 1427\",\"overview\":\"This project involved the installation of Jasper and his turtle for Jasper Olarte. The objective was to enhance security by providing reliable surveillance coverage across the property, including entrances and other critical areas, while keeping disruption to daily operations to a minimum.\",\"scope\":\"Site Survey and Equipment Placement Design: Conducted a site survey to identify the best placement for each device.\\nInstallation of Equipment:\\n- Installed 1 × IP CCTV Camera 4MP, 1 × DVR 4-Channel, 1 × Dahua 2MP 4CH WizSense Kit (DH-KIT-CVI2MP2B2T-I) at the designated locations.\\n- Ran and secured all cabling and power connections.\\nNetwork Configuration and System Integration: Configured the recorder and network settings for centralized access and remote viewing.\\nTesting and Turnover: Tested every device, walked the customer through the system and turned it over.\",\"start\":\"2026-10-24\",\"end\":\"2026-10-24\"}', '2026-10-24 09:22:15', '2026-10-24 09:22:15');

-- --------------------------------------------------------

--
-- Table structure for table `project_updates`
--

CREATE TABLE `project_updates` (
  `update_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `quotation_id` int(11) NOT NULL,
  `quotation_no` varchar(20) DEFAULT NULL,
  `inquiry_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `project_id` int(11) DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `other_charges_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `labor_total` decimal(12,2) NOT NULL DEFAULT 0.00,
  `vat_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('Draft','Pending Superadmin','Sent to Customer','Approved','Declined','Revision Requested') NOT NULL DEFAULT 'Draft',
  `payment_status` enum('Unpaid','Partial','Paid') NOT NULL DEFAULT 'Unpaid',
  `notes` text DEFAULT NULL,
  `superadmin_comment` text DEFAULT NULL,
  `pdf_path` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `expiry_date` date DEFAULT NULL,
  `no_labor` tinyint(1) NOT NULL DEFAULT 0,
  `scope_of_work` text DEFAULT NULL,
  `project_title` varchar(120) DEFAULT NULL,
  `duration` varchar(60) DEFAULT NULL,
  `site_address` varchar(160) DEFAULT NULL,
  `project_incharge` varchar(60) DEFAULT NULL,
  `payment_terms` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotations`
--

INSERT INTO `quotations` (`quotation_id`, `quotation_no`, `inquiry_id`, `customer_id`, `project_id`, `subtotal`, `other_charges_total`, `labor_total`, `vat_amount`, `total_amount`, `status`, `payment_status`, `notes`, `superadmin_comment`, `pdf_path`, `created_by`, `date_created`, `expiry_date`, `no_labor`, `scope_of_work`, `project_title`, `duration`, `site_address`, `project_incharge`, `payment_terms`) VALUES
(1, 'Q-2026-00001', 2, 3, 1, 18500.00, 750.00, 4000.00, 2790.00, 26040.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-07 09:43:35', '2026-11-06', 0, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Tender Juicy', '5555555555555555555', 'Camarin Caloocan City', 'Richiebelle Del Rosario', '100%'),
(2, 'Q-2026-00002', 5, 9, NULL, 76740.00, 5700.00, 21000.00, 12412.80, 115852.80, 'Sent to Customer', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-07 13:47:32', '2026-11-06', 0, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'Information Management', '5 Days', 'Makati City', 'Richie', '50% Payment'),
(3, 'Q-2026-00003', 6, 10, 2, 10000.00, 50.00, 0.00, 1206.00, 11256.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-19 12:05:53', '2026-11-18', 1, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'Jasper\'s Security', 'pppppp', 'Mabolo Camarin Caloocan City', 'Richiebelle', '50% down payment'),
(4, 'Q-2026-00004', 4, 9, NULL, 23200.00, 40.00, 0.00, 2788.80, 26028.80, 'Pending Superadmin', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-19 12:29:46', '2026-11-18', 1, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Security', NULL, 'Brgy. 176 Caloocan City', 'Richiebelle', '50% Downpayment'),
(5, 'Q-2026-00005', 7, 10, 3, 8500.00, 500.00, 0.00, 1080.00, 10080.00, 'Approved', 'Partial', NULL, NULL, NULL, 2, '2026-10-20 03:21:00', '2026-11-19', 1, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'Jasper Veranda', '1 day', 'Kaagapay Street Caloocan City', 'Richiebelle Del Rosario', 'Full payment before installation'),
(6, 'Q-2026-00006', 8, 10, 4, 75000.00, 0.00, 0.00, 9000.00, 84000.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-20 03:45:05', '2026-11-19', 1, 'Scope of work: supply of CCTV and related accessories.', 'Jasper Store', '7 days', 'Camaro Street Brixtone Caloocan City', 'Richiebelle Del Rosario', 'Full payment before installation'),
(7, 'Q-2026-00007', 9, 10, NULL, 35000.00, 258.00, 0.00, 4230.96, 39488.96, 'Declined', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-20 04:15:27', '2026-11-19', 1, 'Scope of work: supply of CCTV and related accessories.', 'Jasper Business', '4 days', 'Phase 8A Quezon City', 'Richiebelle Del Rosario', '50% down payment, then the remaining 50% after installation'),
(8, 'Q-2026-00008', 10, 10, 5, 52000.00, 0.00, 0.00, 6240.00, 58240.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-20 04:18:44', '2026-11-19', 1, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Jasper St. Claire College', '4 days', 'Parañaque City', 'Richiebelle Del Rosario', 'Full payment before installation'),
(9, 'Q-2026-00009', 13, 12, 6, 7710.00, 0.00, 0.00, 925.20, 8635.20, 'Approved', 'Partial', NULL, NULL, NULL, 2, '2026-10-21 12:22:19', '2026-11-20', 1, 'Scope of work: supply of CCTV and related accessories.', 'First Project', '4 days', 'Lot 5 Blk Rosal Street. 190, Badio, Pinili, Ilocos Norte', 'Richiebelle', '50% down payment, then the remaining 50% after installation'),
(10, 'Q-2026-00010', 15, 16, 7, 8800.00, 500.00, 0.00, 1116.00, 10416.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-21 18:31:20', '2026-11-20', 1, 'Scope of work: supply of CCTV and related accessories.', 'Project 1', '1 day', 'Lot 5 Blk 2, Banglolao, Bucay, Abra', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(11, 'Q-2026-00011', 12, 15, NULL, 38650.00, 0.00, 0.00, 4638.00, 43288.00, 'Sent to Customer', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-21 18:39:14', '2026-11-20', 1, 'Scope of work: supply of CCTV and related accessories.', 'Vicas', '1 day', 'Lot 5 Blk 2 Kaagapay Street, Poblacion, Peñarrubia, Abra', 'Richiebelle Del Rosario', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(12, 'Q-2026-00012', 11, 15, 8, 33000.00, 0.00, 0.00, 3960.00, 36960.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-22 03:02:52', '2026-11-21', 1, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Jasper\'s Sari Sari Store', '2 days', 'Phase 77 LohbadbBcj 893830, Sulbec, Pasuquin, Ilocos Norte', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(13, 'Q-2026-00013', 16, 16, 9, 18300.00, 0.00, 0.00, 2196.00, 20496.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-22 03:09:46', '2026-11-21', 1, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'Allexis Grocery Store', '4 days', 'Kaagapay Street, Atok, Flora, Apayao', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(14, 'Q-2026-00014', 17, 16, 10, 10700.00, 0.00, 0.00, 1284.00, 11984.00, 'Approved', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-22 03:25:50', '2026-11-21', 1, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'Allexis New House', '7 days', 'Lot 5 Blk 2 Bagong Silang, Bendita II, Magallanes, Cavite', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(15, 'Q-2026-00015', 18, 16, 11, 3200.00, 0.00, 0.00, 384.00, 3584.00, 'Approved', 'Partial', NULL, NULL, NULL, 2, '2026-10-22 11:25:01', '2026-11-21', 1, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Library', '1 day', 'Yuuu 45577 9090, Kalawakan, Doña Remedios Trinidad, Bulacan', 'Clarrise', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(16, 'Q-2026-00016', 19, 18, 12, 5000.00, 150.00, 0.00, 618.00, 5768.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-22 11:58:49', '2026-11-21', 1, 'Scope of work: supply of CCTV and related accessories.', 'Library', '1 day', 'Phase 10b Package 5 Block 34 Lot 1 Bagong Silang, Barangay 176-F, Caloocan City, Metro Manila', 'Mr. Yujin Isabbelo', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(17, 'Q-2026-00017', 22, 19, NULL, 12500.00, 0.00, 0.00, 1500.00, 14000.00, 'Revision Requested', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-22 14:19:25', '2026-11-21', 1, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'UCC', '2 days', 'Lot 44 Blk 109 Bagong Silang, Bucal III B, Maragondon, Cavite', 'Yujin Isabello', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(18, 'Q-2026-00018', 23, 19, 13, 11200.00, 0.00, 0.00, 1344.00, 12544.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-22 14:25:42', '2026-11-21', 1, 'Scope of work: supply of CCTV and related accessories.', 'UCC', '10 days', 'Lot 5 Blk 2 B.S.C.C, Anislag, Daraga, Albay', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(19, 'Q-2026-00019', 26, 12, NULL, 4400.00, 100.00, 0.00, 540.00, 5040.00, 'Sent to Customer', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-24 01:46:25', '2026-11-23', 1, 'Scope of work: supply of CCTV and related accessories.', 'For Checking', '3 days', 'Kaagapay Street, Bail, Santo Tomas, La Union', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(20, 'Q-2026-00020', 29, 20, 14, 13440.00, 500.00, 0.00, 1672.80, 15612.80, 'Approved', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-24 04:30:04', '2026-11-23', 1, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'BeyondWires Security', '14 days', 'Kaagapay Street, Kalumsing, San Emilio, Ilocos Sur', 'Richiebelle', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(21, 'Q-2026-00021', 30, 20, 15, 6000.00, 500.00, 3500.00, 1200.00, 11200.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-24 04:38:59', '2026-11-23', 0, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Harry Styles Concert', '2 days', 'Kaagapay Street, Canadam, Maconacon, Isabela', 'Louis Tomlinson', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(22, 'Q-2026-00022', 33, 15, 16, 3500.00, 0.00, 3000.00, 780.00, 7280.00, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-24 08:20:33', '2026-11-23', 0, 'Scope of work: installation, configuration and commissioning of CCTV and related accessories.', 'Jasper Dunkin Donut', '2 days', 'Lot 44 Blk 108 Pkg 5a, Balasbas, Manito, Albay', 'Richiebelle Del Rosario', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(23, 'Q-2026-00023', 37, 15, 17, 17992.00, 0.00, 1000.00, 2279.04, 21271.04, 'Approved', 'Paid', NULL, NULL, NULL, 2, '2026-10-24 09:18:36', '2026-11-23', 0, 'Scope of work: supply and installation of CCTV and related accessories, including testing and commissioning.', 'Jasper and his turtle', '2 days', 'Lot 44 Blk 108 Pkg 5a, Bantonan, Camalig, Albay', 'Richiebelle Del Rosario', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)'),
(24, 'Q-2026-00024', 35, 15, NULL, 17292.00, 0.00, 0.00, 2075.04, 19367.04, 'Pending Superadmin', 'Unpaid', NULL, NULL, NULL, 2, '2026-10-24 09:25:51', '2026-11-23', 1, 'Scope of work: supply of CCTV and related accessories.', 'Jasper Cheese/Pastillas Business', '7 days', 'Lot 44 Blk 108 Pkg 5a, Cagandungan, Luna, Apayao', 'Richiebelle Del Rosario', 'Half payment upon quotation or Full payment upon quotation (chosen by the customer upon approval)');

-- --------------------------------------------------------

--
-- Table structure for table `quotation_approvals`
--

CREATE TABLE `quotation_approvals` (
  `approval_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `payment_agreement` enum('Half upon quotation','Full upon quotation','Full after installation') NOT NULL,
  `payment_method` enum('Online','Over the counter') NOT NULL,
  `preferred_install_date` date DEFAULT NULL,
  `preferred_install_slot` varchar(10) DEFAULT NULL,
  `process_step` varchar(60) DEFAULT NULL,
  `date_submitted` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_approvals`
--

INSERT INTO `quotation_approvals` (`approval_id`, `quotation_id`, `payment_agreement`, `payment_method`, `preferred_install_date`, `preferred_install_slot`, `process_step`, `date_submitted`) VALUES
(1, 1, 'Full upon quotation', 'Online', '2026-10-09', '1:00 PM', 'Approved by customer', '2026-10-07 09:47:48'),
(2, 3, 'Half upon quotation', 'Online', '2026-10-21', '1:00 PM', 'Approved by customer', '2026-10-19 12:15:10'),
(3, 5, 'Half upon quotation', 'Online', '2026-10-24', '3:30 PM', 'Approved by customer', '2026-10-20 03:26:24'),
(4, 6, 'Full upon quotation', 'Over the counter', '2026-10-27', '10:30 AM', 'Approved by customer', '2026-10-20 03:47:03'),
(5, 8, 'Full upon quotation', 'Online', '2026-10-28', '10:30 AM', 'Approved by customer', '2026-10-20 04:19:11'),
(6, 9, 'Half upon quotation', 'Online', '2026-10-23', '1:00 PM', 'Approved by customer', '2026-10-21 12:25:42'),
(7, 10, 'Half upon quotation', 'Online', '2026-10-23', '3:20 PM', 'Approved by customer', '2026-10-21 18:43:54'),
(8, 12, 'Full upon quotation', 'Online', '2026-10-27', '1:00 PM', 'Approved by customer', '2026-10-22 03:05:31'),
(9, 13, 'Half upon quotation', 'Online', '2026-10-28', '9:00 AM', 'Approved by customer', '2026-10-22 03:10:59'),
(10, 14, 'Half upon quotation', 'Online', '2026-10-24', '3:30 PM', 'Approved by customer', '2026-10-22 03:26:44'),
(11, 15, 'Half upon quotation', 'Online', '2026-10-24', '10:30 AM', 'Approved by customer', '2026-10-22 11:26:51'),
(12, 16, 'Half upon quotation', 'Over the counter', '2026-11-06', '9:00 AM', 'Approved by customer', '2026-10-22 12:03:10'),
(13, 18, 'Half upon quotation', 'Online', '2026-10-23', '10:30 AM', 'Approved by customer', '2026-10-22 14:27:24'),
(14, 20, 'Half upon quotation', 'Online', '2026-10-27', '3:30 PM', 'Approved by customer', '2026-10-24 04:40:53'),
(15, 21, 'Half upon quotation', 'Over the counter', '2026-10-27', '9:00 AM', 'Approved by customer', '2026-10-24 04:47:33'),
(16, 22, 'Full upon quotation', 'Online', '2026-11-03', '3:30 PM', 'Approved by customer', '2026-10-24 08:22:15'),
(17, 23, 'Full upon quotation', 'Over the counter', '2026-10-31', '3:30 PM', 'Approved by customer', '2026-10-24 09:20:37');

-- --------------------------------------------------------

--
-- Table structure for table `quotation_charges`
--

CREATE TABLE `quotation_charges` (
  `charge_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `label` varchar(120) NOT NULL,
  `amount` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_charges`
--

INSERT INTO `quotation_charges` (`charge_id`, `quotation_id`, `label`, `amount`) VALUES
(1, 1, 'Transpo', 500.00),
(2, 1, 'Meal', 250.00),
(5, 2, 'Transportation', 700.00),
(6, 2, 'Meal', 5000.00),
(8, 3, 'Transport', 50.00),
(9, 4, 'Transport', 40.00),
(11, 5, 'Meal', 500.00),
(12, 7, 'Transport', 200.00),
(13, 7, 'Meal', 58.00),
(15, 10, 'Transport', 500.00),
(16, 16, 'Transportation Gas', 150.00),
(17, 19, 'Transport', 100.00),
(18, 20, 'Transpo', 500.00),
(19, 21, 'Harry Styles Concert', 500.00);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_events`
--

CREATE TABLE `quotation_events` (
  `event_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `event` varchar(160) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_events`
--

INSERT INTO `quotation_events` (`event_id`, `quotation_id`, `event`, `created_by`, `created_at`) VALUES
(1, 1, 'Draft created', 2, '2026-10-07 09:43:35'),
(2, 1, 'Sent to superadmin', 2, '2026-10-07 09:43:35'),
(3, 1, 'Approved by superadmin. Sent to customer', 1, '2026-10-07 09:44:47'),
(4, 1, 'Approved by customer. Project #1 created', 5, '2026-10-07 09:47:48'),
(5, 2, 'Draft created', 2, '2026-10-07 13:47:32'),
(6, 2, 'Sent to superadmin', 2, '2026-10-07 13:47:32'),
(7, 2, 'Edited by superadmin', 1, '2026-10-07 14:00:59'),
(8, 2, 'Approved by superadmin. Sent to customer', 1, '2026-10-07 14:01:11'),
(9, 3, 'Draft created', 2, '2026-10-19 12:05:53'),
(10, 3, 'Quotation edited', 2, '2026-10-19 12:06:04'),
(11, 3, 'Sent to superadmin', 2, '2026-10-19 12:06:04'),
(12, 3, 'Approved by superadmin. Sent to customer', 1, '2026-10-19 12:08:59'),
(13, 3, 'Approved by customer. Project #2 created', 12, '2026-10-19 12:15:10'),
(14, 4, 'Draft created', 2, '2026-10-19 12:29:46'),
(15, 4, 'Sent to superadmin', 2, '2026-10-19 12:29:46'),
(16, 5, 'Draft created', 2, '2026-10-20 03:21:00'),
(17, 5, 'Sent to superadmin', 2, '2026-10-20 03:21:00'),
(18, 5, 'Edited by superadmin', 1, '2026-10-20 03:23:46'),
(19, 5, 'Approved by superadmin. Sent to customer', 1, '2026-10-20 03:25:40'),
(20, 5, 'Approved by customer. Project #3 created', 12, '2026-10-20 03:26:24'),
(21, 6, 'Draft created', 2, '2026-10-20 03:45:05'),
(22, 6, 'Sent to superadmin', 2, '2026-10-20 03:45:05'),
(23, 6, 'Approved by superadmin. Sent to customer', 1, '2026-10-20 03:45:16'),
(24, 6, 'Approved by customer. Project #4 created', 12, '2026-10-20 03:47:03'),
(25, 7, 'Draft created', 2, '2026-10-20 04:15:27'),
(26, 7, 'Sent to superadmin', 2, '2026-10-20 04:15:27'),
(27, 7, 'Approved by superadmin. Sent to customer', 1, '2026-10-20 04:15:47'),
(28, 7, 'Declined by customer: negotiation cancelled', 12, '2026-10-20 04:16:38'),
(29, 8, 'Draft created', 2, '2026-10-20 04:18:44'),
(30, 8, 'Sent to superadmin', 2, '2026-10-20 04:18:44'),
(31, 8, 'Approved by superadmin. Sent to customer', 1, '2026-10-20 04:18:51'),
(32, 8, 'Approved by customer. Project #5 created', 12, '2026-10-20 04:19:11'),
(33, 9, 'Draft created', 2, '2026-10-21 12:22:19'),
(34, 9, 'Sent to superadmin', 2, '2026-10-21 12:22:19'),
(35, 9, 'Approved by superadmin. Sent to customer', 1, '2026-10-21 12:23:58'),
(36, 9, 'Approved by customer. Project #6 created', 14, '2026-10-21 12:25:42'),
(37, 10, 'Draft created', 2, '2026-10-21 18:31:20'),
(38, 10, 'Sent to superadmin', 2, '2026-10-21 18:31:20'),
(39, 10, 'Edited by superadmin', 1, '2026-10-21 18:35:05'),
(40, 10, 'Approved by superadmin. Sent to customer', 1, '2026-10-21 18:35:08'),
(41, 11, 'Draft created', 2, '2026-10-21 18:39:14'),
(42, 11, 'Sent to superadmin', 2, '2026-10-21 18:39:14'),
(43, 11, 'Approved by superadmin. Sent to customer', 1, '2026-10-21 18:40:43'),
(44, 10, 'Approved by customer. Project #7 created', 18, '2026-10-21 18:43:54'),
(45, 12, 'Draft created', 2, '2026-10-22 03:02:52'),
(46, 12, 'Sent to superadmin', 2, '2026-10-22 03:02:52'),
(47, 12, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 03:04:23'),
(48, 12, 'Approved by customer. Project #8 created', 17, '2026-10-22 03:05:31'),
(49, 13, 'Draft created', 2, '2026-10-22 03:09:46'),
(50, 13, 'Sent to superadmin', 2, '2026-10-22 03:09:46'),
(51, 13, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 03:10:01'),
(52, 13, 'Approved by customer. Project #9 created', 18, '2026-10-22 03:10:59'),
(53, 14, 'Draft created', 2, '2026-10-22 03:25:50'),
(54, 14, 'Sent to superadmin', 2, '2026-10-22 03:25:50'),
(55, 14, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 03:26:07'),
(56, 14, 'Approved by customer. Project #10 created', 18, '2026-10-22 03:26:44'),
(57, 15, 'Draft created', 2, '2026-10-22 11:25:01'),
(58, 15, 'Sent to superadmin', 2, '2026-10-22 11:25:01'),
(59, 15, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 11:25:45'),
(60, 15, 'Approved by customer. Project #11 created', 18, '2026-10-22 11:26:51'),
(61, 16, 'Draft created', 2, '2026-10-22 11:58:49'),
(62, 16, 'Sent to superadmin', 2, '2026-10-22 11:58:49'),
(63, 16, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 12:00:35'),
(64, 16, 'Approved by customer. Project #12 created', 20, '2026-10-22 12:03:10'),
(65, 17, 'Draft created', 2, '2026-10-22 14:19:25'),
(66, 17, 'Sent to superadmin', 2, '2026-10-22 14:19:25'),
(67, 17, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 14:22:19'),
(68, 17, 'Declined by customer: new quotation requested', 21, '2026-10-22 14:23:45'),
(69, 18, 'Draft created', 2, '2026-10-22 14:25:42'),
(70, 18, 'Sent to superadmin', 2, '2026-10-22 14:25:42'),
(71, 18, 'Approved by superadmin. Sent to customer', 1, '2026-10-22 14:26:05'),
(72, 18, 'Approved by customer. Project #13 created', 21, '2026-10-22 14:27:24'),
(73, 19, 'Draft created', 2, '2026-10-24 01:46:25'),
(74, 19, 'Sent to superadmin', 2, '2026-10-24 01:46:25'),
(75, 19, 'Approved by superadmin. Sent to customer', 1, '2026-10-24 01:47:45'),
(76, 20, 'Draft created', 2, '2026-10-24 04:30:04'),
(77, 20, 'Sent to superadmin', 2, '2026-10-24 04:30:04'),
(78, 21, 'Draft created', 2, '2026-10-24 04:38:59'),
(79, 21, 'Sent to superadmin', 2, '2026-10-24 04:38:59'),
(80, 20, 'Approved by superadmin. Sent to customer', 1, '2026-10-24 04:40:19'),
(81, 20, 'Approved by customer. Project #14 created', 22, '2026-10-24 04:40:53'),
(82, 21, 'Approved by superadmin. Sent to customer', 1, '2026-10-24 04:45:59'),
(83, 21, 'Approved by customer. Project #15 created', 22, '2026-10-24 04:47:33'),
(84, 22, 'Draft created', 2, '2026-10-24 08:20:33'),
(85, 22, 'Sent to superadmin', 2, '2026-10-24 08:20:33'),
(86, 22, 'Approved by superadmin. Sent to customer', 1, '2026-10-24 08:21:01'),
(87, 22, 'Approved by customer. Project #16 created', 17, '2026-10-24 08:22:15'),
(88, 23, 'Draft created', 2, '2026-10-24 09:18:36'),
(89, 23, 'Sent to superadmin', 2, '2026-10-24 09:18:36'),
(90, 23, 'Approved by superadmin. Sent to customer', 1, '2026-10-24 09:20:03'),
(91, 23, 'Approved by customer. Project #17 created', 17, '2026-10-24 09:20:37'),
(92, 24, 'Draft created', 2, '2026-10-24 09:25:51'),
(93, 24, 'Sent to superadmin', 2, '2026-10-24 09:25:51');

-- --------------------------------------------------------

--
-- Table structure for table `quotation_items`
--

CREATE TABLE `quotation_items` (
  `item_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(160) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `cost_price` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_items`
--

INSERT INTO `quotation_items` (`item_id`, `quotation_id`, `product_id`, `description`, `quantity`, `unit_price`, `total_amount`, `cost_price`) VALUES
(1, 1, 14, '4-Camera Home CCTV Package', 1, 18500.00, 18500.00, NULL),
(5, 2, 3, 'DVR 4-Channel', 7, 3500.00, 24500.00, NULL),
(6, 2, 13, 'Rough-ins, Piping, Molding', 2, 120.00, 240.00, NULL),
(7, 2, 15, '8-Camera Business CCTV Package', 1, 52000.00, 52000.00, NULL),
(10, 3, 3, 'DVR 4-Channel', 1, 3500.00, 3500.00, NULL),
(11, 3, 4, 'NVR 8-Channel', 1, 6500.00, 6500.00, NULL),
(12, 4, 6, 'Smart Door Lock', 2, 9500.00, 19000.00, NULL),
(13, 4, 9, 'CAT6 Cable (305m)', 1, 4200.00, 4200.00, NULL),
(16, 5, 23, 'Magnetic Door Lock 600lbs', 1, 5000.00, 5000.00, NULL),
(17, 5, 3, 'DVR 4-Channel', 1, 3500.00, 3500.00, NULL),
(18, 6, 156, '15-Channel CCTV Set, 5MP/3K Standard', 1, 75000.00, 75000.00, NULL),
(19, 7, 112, '10-Channel CCTV Set, 2MP/1080P Standard', 1, 35000.00, 35000.00, NULL),
(20, 8, 15, '8-Camera Business CCTV Package', 1, 52000.00, 52000.00, NULL),
(21, 9, 1, 'IR CCTV Camera 2MP', 1, 1500.00, 1500.00, NULL),
(22, 9, 37, 'Dahua 2MP 4CH HDCVI Kit (DH-KIT1B04)', 1, 6210.00, 6210.00, NULL),
(24, 10, 5, 'Biometric Access Terminal', 1, 8800.00, 8800.00, NULL),
(25, 11, 5, 'Biometric Access Terminal', 1, 7800.00, 7800.00, NULL),
(26, 11, 23, 'Magnetic Door Lock 600lbs', 1, 2800.00, 2800.00, NULL),
(27, 11, 2, 'IP CCTV Camera 4MP', 1, 3200.00, 3200.00, NULL),
(28, 11, 24, 'Exit Push Button', 1, 350.00, 350.00, NULL),
(29, 11, 25, 'Solar Streetlight 100W', 1, 24500.00, 24500.00, NULL),
(30, 12, 25, 'Solar Streetlight 100W', 1, 24500.00, 24500.00, NULL),
(31, 12, 45, '2-Channel CCTV Package', 1, 8500.00, 8500.00, NULL),
(32, 13, 23, 'Magnetic Door Lock 600lbs', 1, 2800.00, 2800.00, NULL),
(33, 13, 9, 'CAT6 Cable (305m)', 1, 4200.00, 4200.00, NULL),
(34, 13, 5, 'Biometric Access Terminal', 1, 7800.00, 7800.00, NULL),
(35, 13, 3, 'DVR 4-Channel', 1, 3500.00, 3500.00, NULL),
(36, 14, 23, 'Magnetic Door Lock 600lbs', 2, 2800.00, 5600.00, NULL),
(37, 14, 19, 'IP Camera 4MP (Turret)', 1, 3600.00, 3600.00, NULL),
(38, 14, 1, 'IR CCTV Camera 2MP', 1, 1500.00, 1500.00, NULL),
(39, 15, 23, 'Magnetic Door Lock 600lbs', 1, 2800.00, 2800.00, NULL),
(40, 15, 24, 'Exit Push Button', 1, 400.00, 400.00, NULL),
(41, 16, 1, 'IR CCTV Camera 2MP', 1, 1500.00, 1500.00, NULL),
(42, 16, 3, 'DVR 4-Channel', 1, 3500.00, 3500.00, NULL),
(43, 17, 5, 'Biometric Access Terminal', 1, 7800.00, 7800.00, NULL),
(44, 17, 23, 'Magnetic Door Lock 600lbs', 1, 2800.00, 2800.00, NULL),
(45, 17, 24, 'Exit Push Button', 1, 400.00, 400.00, NULL),
(46, 17, 171, 'CCTV Footage Retrieval and Review Fee', 1, 1500.00, 1500.00, NULL),
(47, 18, 23, 'Magnetic Door Lock 600lbs', 4, 2800.00, 11200.00, NULL),
(48, 19, 24, 'Exit Push Button', 11, 400.00, 4400.00, NULL),
(49, 20, 23, 'Magnetic Door Lock 600lbs', 4, 3360.00, 13440.00, 2800.00),
(50, 21, 169, 'Installation - with Molding', 1, 2000.00, 2000.00, NULL),
(51, 21, 170, 'Installation - with Rough-ins', 1, 2500.00, 2500.00, NULL),
(52, 21, 171, 'CCTV Footage Retrieval and Review Fee', 1, 1500.00, 1500.00, NULL),
(53, 22, 168, 'Installation - Open / Exposed Wiring', 1, 1500.00, 1500.00, NULL),
(54, 22, 169, 'Installation - with Molding', 1, 2000.00, 2000.00, NULL),
(55, 23, 2, 'IP CCTV Camera 4MP', 1, 3840.00, 3840.00, 3200.00),
(56, 23, 3, 'DVR 4-Channel', 1, 4200.00, 4200.00, 3500.00),
(57, 23, 12, 'Mobile Viewing Configuration', 1, 1000.00, 1000.00, NULL),
(58, 23, 39, 'Dahua 2MP 4CH WizSense Kit (DH-KIT-CVI2MP2B2T-I)', 1, 7452.00, 7452.00, 6210.00),
(59, 23, 171, 'CCTV Footage Retrieval and Review Fee', 1, 1500.00, 1500.00, NULL),
(60, 24, 5, 'Biometric Access Terminal', 1, 9360.00, 9360.00, 7800.00),
(61, 24, 24, 'Exit Push Button', 1, 480.00, 480.00, 400.00),
(62, 24, 39, 'Dahua 2MP 4CH WizSense Kit (DH-KIT-CVI2MP2B2T-I)', 1, 7452.00, 7452.00, 6210.00);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_labor`
--

CREATE TABLE `quotation_labor` (
  `labor_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `role` varchar(40) NOT NULL,
  `workers` int(11) NOT NULL,
  `days` int(11) NOT NULL,
  `daily_rate` decimal(12,2) NOT NULL,
  `amount` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_labor`
--

INSERT INTO `quotation_labor` (`labor_id`, `quotation_id`, `role`, `workers`, `days`, `daily_rate`, `amount`) VALUES
(1, 1, 'Senior Installer', 1, 2, 2000.00, 4000.00),
(2, 2, 'Head Technician', 4, 2, 2500.00, 20000.00),
(3, 2, 'Helper', 1, 1, 1000.00, 1000.00),
(4, 21, 'Junior Installer', 1, 1, 1500.00, 1500.00),
(5, 21, 'Senior Installer', 1, 1, 2000.00, 2000.00),
(6, 22, 'Helper', 1, 1, 1000.00, 1000.00),
(7, 22, 'Senior Installer', 1, 1, 2000.00, 2000.00),
(8, 23, 'Helper', 1, 1, 1000.00, 1000.00);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_rejections`
--

CREATE TABLE `quotation_rejections` (
  `rejection_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `action` enum('revise','cancel') NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_rejections`
--

INSERT INTO `quotation_rejections` (`rejection_id`, `quotation_id`, `action`, `reason`, `comments`, `created_at`) VALUES
(1, 7, 'cancel', NULL, NULL, '2026-10-20 04:16:38'),
(2, 17, 'revise', NULL, NULL, '2026-10-22 14:23:45');

-- --------------------------------------------------------

--
-- Table structure for table `quotation_revisions`
--

CREATE TABLE `quotation_revisions` (
  `revision_id` int(11) NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `adjusted_amount` decimal(12,2) DEFAULT NULL,
  `revised_validity` date DEFAULT NULL,
  `scope_notes` text DEFAULT NULL,
  `revised_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_revisions`
--

INSERT INTO `quotation_revisions` (`revision_id`, `quotation_id`, `adjusted_amount`, `revised_validity`, `scope_notes`, `revised_by`, `created_at`) VALUES
(1, 2, 82440.00, '2026-11-06', 'Edited by owner', 1, '2026-10-07 14:00:59'),
(2, 3, 11256.00, '2026-11-18', 'Edited by admin', 2, '2026-10-19 12:06:04'),
(3, 5, 9000.00, '2026-11-19', 'Edited by owner', 1, '2026-10-20 03:23:46'),
(4, 10, 9300.00, '2026-11-20', 'Edited by owner', 1, '2026-10-21 18:35:05');

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `receipt_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `receipt_no` varchar(20) NOT NULL,
  `issued_by` int(11) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `issued_at` datetime NOT NULL DEFAULT current_timestamp(),
  `sent_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`receipt_id`, `payment_id`, `receipt_no`, `issued_by`, `file_path`, `issued_at`, `sent_at`) VALUES
(1, 1, 'OR-2026-00001', 2, NULL, '2026-10-07 09:50:15', '2026-10-07 09:50:31'),
(2, 2, 'OR-2026-00002', 2, NULL, '2026-10-19 12:17:16', '2026-10-19 12:20:57'),
(3, 3, 'OR-2026-00003', 2, NULL, '2026-10-19 12:22:25', '2026-10-19 12:22:27'),
(4, 4, 'OR-2026-00004', 2, NULL, '2026-10-20 03:29:17', '2026-10-20 03:29:26'),
(5, 6, 'OR-2026-00006', 2, NULL, '2026-10-20 03:47:47', '2026-10-20 03:47:51'),
(6, 7, 'OR-2026-00007', 2, NULL, '2026-10-20 04:20:52', '2026-10-20 04:20:56'),
(7, 8, 'OR-2026-00008', 2, NULL, '2026-10-21 12:27:28', '2026-10-21 12:27:38'),
(8, 10, 'OR-2026-00010', 2, NULL, '2026-10-21 18:51:39', '2026-10-21 18:52:15'),
(9, 11, 'OR-2026-00011', 2, NULL, '2026-10-21 19:04:29', '2026-10-21 19:04:47'),
(10, 12, 'OR-2026-00012', 2, NULL, '2026-10-22 03:08:14', '2026-10-22 03:08:23'),
(11, 13, 'OR-2026-00013', 2, NULL, '2026-10-22 03:11:27', '2026-10-22 03:11:35'),
(12, 14, 'OR-2026-00014', 2, NULL, '2026-10-22 03:12:31', '2026-10-22 03:17:06'),
(13, 17, 'OR-2026-00017', 2, NULL, '2026-10-22 11:29:44', NULL),
(14, 19, 'OR-2026-00019', 2, NULL, '2026-10-22 12:06:23', '2026-10-22 12:11:04'),
(15, 20, 'OR-2026-00020', 2, NULL, '2026-10-22 12:10:18', '2026-10-22 12:11:05'),
(16, 21, 'OR-2026-00021', 2, NULL, '2026-10-22 14:31:00', '2026-10-22 14:31:24'),
(17, 22, 'OR-2026-00022', 2, NULL, '2026-10-22 14:34:56', NULL),
(18, 25, 'OR-2026-00025', 2, NULL, '2026-10-24 04:53:42', '2026-10-24 04:53:51'),
(19, 26, 'OR-2026-00026', 2, NULL, '2026-10-24 04:57:49', '2026-10-24 04:57:56'),
(20, 27, 'OR-2026-00027', 2, NULL, '2026-10-24 08:24:57', '2026-10-24 08:25:06'),
(21, 28, 'OR-2026-00028', 2, NULL, '2026-10-24 09:21:25', '2026-10-24 09:21:35');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_availability`
--

CREATE TABLE `schedule_availability` (
  `available_date` date NOT NULL,
  `time_slot` varchar(10) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `schedule_availability`
--

INSERT INTO `schedule_availability` (`available_date`, `time_slot`, `created_by`, `created_at`) VALUES
('2026-10-08', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-08', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-08', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-08', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-09', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-09', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-09', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-09', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-10', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-10', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-10', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-10', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-12', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-12', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-12', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-12', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-13', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-13', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-13', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-13', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-14', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-14', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-14', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-14', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-15', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-15', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-15', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-15', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-16', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-16', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-16', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-16', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-17', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-17', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-17', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-17', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-19', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-19', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-19', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-19', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-20', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-20', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-20', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-20', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-21', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-21', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-21', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-21', '6:30 PM', 2, '2026-10-19 12:18:32'),
('2026-10-21', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-22', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-22', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-22', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-22', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-23', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-23', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-23', '3:20 PM', 2, '2026-10-19 12:18:52'),
('2026-10-23', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-23', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-23', '9:50 AM', 2, '2026-10-21 19:27:22'),
('2026-10-24', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-24', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-24', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-24', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-26', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-26', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-26', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-26', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-27', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-27', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-27', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-27', '9:00 AM', 2, '2026-10-22 11:15:22'),
('2026-10-28', '1:00 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-28', '1:20 PM', 2, '2026-10-19 12:19:09'),
('2026-10-28', '10:30 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-28', '3:30 PM', NULL, '2026-10-07 05:45:27'),
('2026-10-28', '9:00 AM', NULL, '2026-10-07 05:45:27'),
('2026-10-29', '1:00 PM', 2, '2026-10-22 11:15:22'),
('2026-10-29', '10:30 AM', 2, '2026-10-22 11:15:22'),
('2026-10-29', '3:30 PM', 2, '2026-10-22 11:15:22'),
('2026-10-29', '9:00 AM', 2, '2026-10-22 11:15:22'),
('2026-10-30', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-10-30', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-10-30', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-10-30', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-10-31', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-10-31', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-10-31', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-10-31', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-02', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-02', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-02', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-02', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-03', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-03', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-03', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-03', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-04', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-04', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-04', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-04', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-05', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-05', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-05', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-05', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-06', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-06', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-06', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-06', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-07', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-07', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-07', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-07', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-09', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-09', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-09', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-09', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-10', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-10', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-10', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-10', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-11', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-11', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-11', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-11', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-12', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-12', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-12', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-12', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-13', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-13', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-13', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-13', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-14', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-14', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-14', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-14', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-16', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-16', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-16', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-16', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-17', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-17', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-17', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-17', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-18', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-18', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-18', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-18', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-19', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-19', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-19', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-19', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-20', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-20', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-20', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-20', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-21', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-21', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-21', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-21', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-23', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-23', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-23', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-23', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-24', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-24', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-24', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-24', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-25', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-25', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-25', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-25', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-26', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-26', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-26', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-26', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-27', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-27', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-27', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-27', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-28', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-28', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-28', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-28', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-11-30', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-11-30', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-11-30', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-11-30', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-01', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-01', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-01', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-01', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-02', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-02', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-02', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-02', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-03', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-03', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-03', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-03', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-04', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-04', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-04', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-04', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-05', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-05', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-05', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-05', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-07', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-07', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-07', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-07', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-08', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-08', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-08', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-08', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-09', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-09', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-09', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-09', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-10', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-10', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-10', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-10', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-11', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-11', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-11', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-11', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-12', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-12', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-12', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-12', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-14', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-14', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-14', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-14', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-15', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-15', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-15', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-15', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-16', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-16', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-16', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-16', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-17', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-17', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-17', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-17', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-18', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-18', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-18', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-18', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-19', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-19', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-19', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-19', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-21', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-21', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-21', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-21', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-22', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-22', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-22', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-22', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-23', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-23', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-23', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-23', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-24', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-24', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-24', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-24', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-25', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-25', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-25', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-25', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-26', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-26', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-26', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-26', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-28', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-28', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-28', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-28', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-29', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-29', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-29', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-29', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-30', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-30', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-30', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-30', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2026-12-31', '1:00 PM', 2, '2026-10-22 05:48:22'),
('2026-12-31', '10:30 AM', 2, '2026-10-22 05:48:22'),
('2026-12-31', '3:30 PM', 2, '2026-10-22 05:48:22'),
('2026-12-31', '9:00 AM', 2, '2026-10-22 05:48:22'),
('2027-01-01', '1:00 PM', 2, '2026-10-22 11:15:22'),
('2027-01-01', '10:30 AM', 2, '2026-10-22 11:15:22'),
('2027-01-01', '3:30 PM', 2, '2026-10-22 11:15:22'),
('2027-01-01', '9:00 AM', 2, '2026-10-22 11:15:22'),
('2027-01-02', '1:00 PM', 2, '2026-10-22 11:15:22'),
('2027-01-02', '10:30 AM', 2, '2026-10-22 11:15:22'),
('2027-01-02', '3:30 PM', 2, '2026-10-22 11:15:22'),
('2027-01-02', '9:00 AM', 2, '2026-10-22 11:15:22'),
('2027-01-04', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-04', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-04', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-04', '9:00 AM', 2, '2026-10-22 11:15:22'),
('2027-01-05', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-05', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-05', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-05', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-06', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-06', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-06', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-06', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-07', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-07', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-07', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-07', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-08', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-08', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-08', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-08', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-09', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-09', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-09', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-09', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-11', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-11', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-11', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-11', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-12', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-12', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-12', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-12', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-13', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-13', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-13', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-13', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-14', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-14', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-14', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-14', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-15', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-15', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-15', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-15', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-16', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-16', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-16', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-16', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-18', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-18', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-18', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-18', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-19', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-19', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-19', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-19', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-20', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-20', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-20', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-20', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-21', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-21', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-21', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-21', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-22', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-22', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-22', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-22', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-23', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-23', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-23', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-23', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-25', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-25', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-25', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-25', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-26', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-26', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-26', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-26', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-27', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-27', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-27', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-27', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-28', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-28', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-28', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-28', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-29', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-29', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-29', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-29', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-01-30', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-01-30', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-01-30', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-01-30', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-02-01', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-02-01', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-02-01', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-02-01', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-02-02', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-02-02', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-02-02', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-02-02', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-02-03', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-02-03', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-02-03', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-02-03', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-02-04', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-02-04', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-02-04', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-02-04', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-02-05', '1:00 PM', 2, '2026-10-22 11:15:23'),
('2027-02-05', '10:30 AM', 2, '2026-10-22 11:15:23'),
('2027-02-05', '3:30 PM', 2, '2026-10-22 11:15:23'),
('2027-02-05', '9:00 AM', 2, '2026-10-22 11:15:23'),
('2027-02-06', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-06', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-06', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-06', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-08', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-08', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-08', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-08', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-09', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-09', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-09', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-09', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-10', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-10', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-10', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-10', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-11', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-11', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-11', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-11', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-12', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-12', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-12', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-12', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-13', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-13', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-13', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-13', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-15', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-15', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-15', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-15', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-16', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-16', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-16', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-16', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-17', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-17', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-17', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-17', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-18', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-18', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-18', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-18', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-19', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-19', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-19', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-19', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-20', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-20', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-20', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-20', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-22', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-22', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-22', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-22', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-23', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-23', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-23', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-23', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-24', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-24', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-24', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-24', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-25', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-25', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-25', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-25', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-26', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-26', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-26', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-26', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-02-27', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-02-27', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-02-27', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-02-27', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-01', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-01', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-01', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-01', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-02', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-02', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-02', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-02', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-03', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-03', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-03', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-03', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-04', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-04', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-04', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-04', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-05', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-05', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-05', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-05', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-06', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-06', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-06', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-06', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-08', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-08', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-08', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-08', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-09', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-09', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-09', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-09', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-10', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-10', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-10', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-10', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-11', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-11', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-11', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-11', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-12', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-12', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-12', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-12', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-13', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-13', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-13', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-13', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-15', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-15', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-15', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-15', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-16', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-16', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-16', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-16', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-17', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-17', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-17', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-17', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-18', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-18', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-18', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-18', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-19', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-19', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-19', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-19', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-20', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-20', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-20', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-20', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-22', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-22', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-22', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-22', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-23', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-23', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-23', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-23', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-24', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-24', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-24', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-24', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-25', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-25', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-25', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-25', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-26', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-26', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-26', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-26', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-27', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-27', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-27', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-27', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-29', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-29', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-29', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-29', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-30', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-30', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-30', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-30', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-03-31', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-03-31', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-03-31', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-03-31', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-01', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-01', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-01', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-01', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-02', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-02', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-02', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-02', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-03', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-03', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-03', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-03', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-05', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-05', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-05', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-05', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-06', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-06', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-06', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-06', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-07', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-07', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-07', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-07', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-08', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-08', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-08', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-08', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-09', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-09', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-09', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-09', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-10', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-10', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-10', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-10', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-12', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-12', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-12', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-12', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-13', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-13', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-13', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-13', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-14', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-14', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-14', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-14', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-15', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-15', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-15', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-15', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-16', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-16', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-16', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-16', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-17', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-17', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-17', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-17', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-19', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-19', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-19', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-19', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-20', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-20', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-20', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-20', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-21', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-21', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-21', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-21', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-22', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-22', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-22', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-22', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-23', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-23', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-23', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-23', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-24', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-24', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-24', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-24', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-26', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-26', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-26', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-26', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-27', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-27', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-27', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-27', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-28', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-28', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-28', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-28', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-29', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-29', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-29', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-29', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-04-30', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-04-30', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-04-30', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-04-30', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-01', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-01', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-01', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-01', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-03', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-03', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-03', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-03', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-04', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-04', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-04', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-04', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-05', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-05', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-05', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-05', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-06', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-06', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-06', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-06', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-07', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-07', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-07', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-07', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-08', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-08', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-08', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-08', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-10', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-10', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-10', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-10', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-11', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-11', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-11', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-11', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-12', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-12', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-12', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-12', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-13', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-13', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-13', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-13', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-14', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-14', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-14', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-14', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-15', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-15', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-15', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-15', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-17', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-17', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-17', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-17', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-18', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-18', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-18', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-18', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-19', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-19', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-19', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-19', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-20', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-20', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-20', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-20', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-21', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-21', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-21', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-21', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-22', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-22', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-22', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-22', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-24', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-24', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-24', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-24', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-25', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-25', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-25', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-25', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-26', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-26', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-26', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-26', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-27', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-27', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-27', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-27', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-28', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-28', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-28', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-28', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-29', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-29', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-29', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-29', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-05-31', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-05-31', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-05-31', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-05-31', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-01', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-01', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-01', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-01', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-02', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-02', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-02', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-02', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-03', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-03', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-03', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-03', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-04', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-04', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-04', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-04', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-05', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-05', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-05', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-05', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-07', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-07', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-07', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-07', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-08', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-08', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-08', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-08', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-09', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-09', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-09', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-09', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-10', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-10', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-10', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-10', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-11', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-11', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-11', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-11', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-12', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-12', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-12', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-12', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-14', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-14', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-14', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-14', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-15', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-15', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-15', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-15', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-16', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-16', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-16', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-16', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-17', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-17', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-17', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-17', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-18', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-18', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-18', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-18', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-19', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-19', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-19', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-19', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-21', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-21', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-21', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-21', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-22', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-22', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-22', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-22', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-23', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-23', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-23', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-23', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-24', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-24', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-24', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-24', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-25', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-25', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-25', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-25', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-26', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-26', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-26', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-26', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-28', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-28', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-28', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-28', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-29', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-29', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-29', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-29', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-06-30', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-06-30', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-06-30', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-06-30', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-01', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-01', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-01', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-01', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-02', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-02', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-02', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-02', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-03', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-03', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-03', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-03', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-05', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-05', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-05', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-05', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-06', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-06', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-06', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-06', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-07', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-07', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-07', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-07', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-08', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-08', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-08', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-08', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-09', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-09', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-09', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-09', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-10', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-10', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-10', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-10', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-12', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-12', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-12', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-12', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-13', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-13', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-13', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-13', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-14', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-14', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-14', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-14', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-15', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-15', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-15', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-15', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-16', '1:00 PM', 2, '2026-10-22 11:15:53');
INSERT INTO `schedule_availability` (`available_date`, `time_slot`, `created_by`, `created_at`) VALUES
('2027-07-16', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-16', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-16', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-17', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-17', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-17', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-17', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-19', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-19', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-19', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-19', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-20', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-20', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-20', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-20', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-21', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-21', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-21', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-21', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-22', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-22', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-22', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-22', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-23', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-23', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-23', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-23', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-24', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-24', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-24', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-24', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-26', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-26', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-26', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-26', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-27', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-27', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-27', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-27', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-28', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-28', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-28', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-28', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-29', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-29', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-29', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-29', '9:00 AM', 2, '2026-10-22 11:15:53'),
('2027-07-30', '1:00 PM', 2, '2026-10-22 11:15:53'),
('2027-07-30', '10:30 AM', 2, '2026-10-22 11:15:53'),
('2027-07-30', '3:30 PM', 2, '2026-10-22 11:15:53'),
('2027-07-30', '9:00 AM', 2, '2026-10-22 11:15:53');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_changes`
--

CREATE TABLE `schedule_changes` (
  `change_id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `kind` varchar(30) NOT NULL,
  `old_date` date DEFAULT NULL,
  `old_slot` varchar(10) DEFAULT NULL,
  `new_date` date DEFAULT NULL,
  `new_slot` varchar(10) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_changes`
--

INSERT INTO `schedule_changes` (`change_id`, `schedule_id`, `kind`, `old_date`, `old_slot`, `new_date`, `new_slot`, `reason`, `changed_by`, `created_at`) VALUES
(1, 24, 'Admin confirmed', NULL, NULL, '2026-10-29', '1:00 PM', NULL, 2, '2026-10-24 01:42:32'),
(2, 25, 'Admin confirmed', NULL, NULL, '2026-12-04', '9:00 AM', NULL, 2, '2026-10-24 04:27:48'),
(3, 27, 'Customer request', '2026-10-27', '3:30 PM', '2026-10-30', '3:30 PM', 'Emergency / personal matter', 22, '2026-10-24 04:56:18'),
(4, 31, 'Admin proposal', '2026-10-26', '10:30 AM', '2026-10-28', '10:30 AM', 'Weather concerns', 2, '2026-10-24 09:16:44'),
(5, 31, 'Customer accepted', '2026-10-26', '10:30 AM', '2026-10-28', '10:30 AM', NULL, 17, '2026-10-24 09:19:12');

-- --------------------------------------------------------

--
-- Table structure for table `service_inquiries`
--

CREATE TABLE `service_inquiries` (
  `inquiry_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `installation_address` varchar(255) NOT NULL,
  `province` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `district` varchar(40) DEFAULT NULL,
  `barangay` varchar(60) DEFAULT NULL,
  `landmark` varchar(120) DEFAULT NULL,
  `place_type` enum('Residential','Commercial') NOT NULL,
  `purchase_option` enum('service','product','both','package') NOT NULL,
  `requirements` text DEFAULT NULL,
  `budget_range` varchar(60) DEFAULT NULL,
  `urgency_level` enum('Low','Normal','Very Urgent') NOT NULL DEFAULT 'Normal',
  `needs_site_visit` tinyint(1) NOT NULL DEFAULT 0,
  `preferred_visit_at` datetime DEFAULT NULL,
  `site_visit_done` tinyint(1) NOT NULL DEFAULT 0,
  `status` varchar(30) NOT NULL DEFAULT 'New Inquiry',
  `date_submitted` datetime NOT NULL DEFAULT current_timestamp(),
  `submission_ref` varchar(24) DEFAULT NULL,
  `rejection_reason` varchar(120) DEFAULT NULL,
  `rejection_note` varchar(400) DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `cancel_reason` varchar(120) DEFAULT NULL,
  `cancel_note` varchar(400) DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service_inquiries`
--

INSERT INTO `service_inquiries` (`inquiry_id`, `customer_id`, `installation_address`, `province`, `city`, `district`, `barangay`, `landmark`, `place_type`, `purchase_option`, `requirements`, `budget_range`, `urgency_level`, `needs_site_visit`, `preferred_visit_at`, `site_visit_done`, `status`, `date_submitted`, `submission_ref`, `rejection_reason`, `rejection_note`, `rejected_at`, `cancel_reason`, `cancel_note`, `cancelled_at`) VALUES
(1, 3, 'Kaagapay Street Caloocan City', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Residential', 'service', NULL, NULL, 'Normal', 1, '2026-10-21 13:00:00', 1, 'Failed', '2026-10-07 09:19:39', 'S2610070919393', 'Outside service area (NCR only)', 'Thank you for your interest in Beyond Wires. We currently serve Metro Manila (NCR) only, so we are unable to take on a project at your location.', '2026-10-07 12:54:27', NULL, NULL, NULL),
(2, 3, 'Camarin Caloocan City', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Commercial', 'package', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-07 09:19:39', 'S2610070919393', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 4, 'caloocan city', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Residential', 'package', NULL, NULL, 'Normal', 1, '2026-10-13 09:00:00', 0, 'Failed', '2026-10-07 12:25:53', NULL, 'Outside service area (NCR only)', 'Thank you for your interest in Beyond Wires. We currently serve Metro Manila (NCR) only, so we are unable to take on a project at your location.', '2026-10-07 12:54:11', NULL, NULL, NULL),
(4, 9, 'Brgy. 176 Caloocan City', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Residential', 'package', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Accepted', '2026-10-07 13:23:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 9, 'Makati City', 'Metro Manila', 'Makati City', NULL, NULL, NULL, 'Commercial', 'service', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Accepted', '2026-10-07 13:27:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 10, 'Mabolo Camarin Caloocan City', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Residential', 'service', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-19 12:00:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 10, 'Kaagapay Street Caloocan City', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Commercial', 'service', NULL, NULL, 'Normal', 1, '2026-10-28 13:20:00', 1, 'Quoted', '2026-10-19 12:27:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 10, 'Camaro Street Brixtone Caloocan City', 'Metro Manila', 'Caloocan City', NULL, NULL, NULL, 'Commercial', 'product', NULL, '₱10,000 - ₱25,000', 'Normal', 0, NULL, 0, 'Quoted', '2026-10-20 03:40:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 10, 'Phase 8A Quezon City', 'Metro Manila', 'Quezon City', NULL, NULL, NULL, 'Residential', 'product', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Failed', '2026-10-20 04:11:42', 'S26102004114210', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 10, 'Parañaque City', 'Metro Manila', 'Parañaque City', NULL, NULL, NULL, 'Commercial', 'package', NULL, '₱10,000 - ₱25,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-20 04:11:42', 'S26102004114210', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 15, 'Phase 77 LohbadbBcj 893830, Sulbec, Pasuquin, Ilocos Norte', 'Ilocos Norte', 'Pasuquin', NULL, 'Sulbec', NULL, 'Residential', 'package', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'Quoted', '2026-10-21 11:03:47', 'S26102111034715', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 15, 'Lot 5 Blk 2 Kaagapay Street, Poblacion, Peñarrubia, Abra', 'Abra', 'Peñarrubia', NULL, 'Poblacion', 'Ice Cream House', 'Commercial', 'product', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Accepted', '2026-10-21 11:03:47', 'S26102111034715', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 12, 'Lot 5 Blk Rosal Street. 190, Badio, Pinili, Ilocos Norte', 'Ilocos Norte', 'Pinili', NULL, 'Badio', 'Beside 7/11', 'Residential', 'product', NULL, NULL, 'Normal', 1, '2026-10-23 13:00:00', 1, 'Quoted', '2026-10-21 12:07:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 12, 'Camaro Street Tala, Bugnay, Tinglayan, Kalinga', 'Kalinga', 'Tinglayan', NULL, 'Bugnay', NULL, 'Commercial', 'service', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Failed', '2026-10-21 12:10:01', NULL, 'Outside service area (mainland Luzon only)', 'Thank you for your interest in Beyond Wires. We currently serve mainland Luzon only, so we are unable to take on a project at your location.', '2026-10-21 12:12:01', NULL, NULL, NULL),
(15, 16, 'Lot 5 Blk 2, Banglolao, Bucay, Abra', 'Abra', 'Bucay', NULL, 'Banglolao', 'Ice Cream House', 'Commercial', 'product', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-21 18:23:07', 'S26102118230716', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 16, 'Kaagapay Street, Atok, Flora, Apayao', 'Apayao', 'Flora', NULL, 'Atok', NULL, 'Residential', 'service', NULL, NULL, 'Normal', 1, '2026-10-28 13:00:00', 1, 'Completed', '2026-10-21 18:23:07', 'S26102118230716', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 16, 'Lot 5 Blk 2 Bagong Silang, Bendita II, Magallanes, Cavite', 'Cavite', 'Magallanes', NULL, 'Bendita II', NULL, 'Residential', 'service', NULL, NULL, 'Normal', 1, '2026-10-28 10:30:00', 1, 'Quoted', '2026-10-22 03:24:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 16, 'Yuuu 45577 9090, Kalawakan, Doña Remedios Trinidad, Bulacan', 'Bulacan', 'Doña Remedios Trinidad', NULL, 'Kalawakan', NULL, 'Commercial', 'package', NULL, NULL, 'Normal', 1, '2026-10-23 10:30:00', 1, 'Quoted', '2026-10-22 11:23:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 18, 'Phase 10b Package 5 Block 34 Lot 1 Bagong Silang, Barangay 176-F, Caloocan City, Metro Manila', 'Metro Manila', 'Caloocan City', NULL, 'Barangay 176-F', 'Uncle Johns', 'Residential', 'product', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-22 11:49:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 19, 'phase 10 package 5 block 34 lot 1 bagong silang, Barangay 176-F, Caloocan City, Metro Manila', 'Metro Manila', 'Caloocan City', NULL, 'Barangay 176-F', NULL, 'Commercial', 'both', NULL, NULL, 'Normal', 1, '2026-10-26 10:30:00', 0, 'Failed', '2026-10-22 14:03:51', 'S26102214035119', 'Outside service area (mainland Luzon only)', 'Thank you for your interest in Beyond Wires. We currently serve mainland Luzon only, so we are unable to take on a project at your location.', '2026-10-22 14:08:13', NULL, NULL, NULL),
(21, 19, 'phase 10 package 5 block 34 lot 1, Barangay 176-F, Caloocan City, Metro Manila', 'Metro Manila', 'Caloocan City', NULL, 'Barangay 176-F', NULL, 'Commercial', 'both', NULL, '₱10,000 - ₱25,000', 'Normal', 0, NULL, 0, 'Failed', '2026-10-22 14:03:51', 'S26102214035119', 'Outside service area (mainland Luzon only)', 'Thank you for your interest in Beyond Wires. We currently serve mainland Luzon only, so we are unable to take on a project at your location.', '2026-10-22 14:09:17', NULL, NULL, NULL),
(22, 19, 'Lot 44 Blk 109 Bagong Silang, Bucal III B, Maragondon, Cavite', 'Cavite', 'Maragondon', NULL, 'Bucal III B', NULL, 'Residential', 'both', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Accepted', '2026-10-22 14:12:15', 'S26102214121519', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 19, 'Lot 5 Blk 2 B.S.C.C, Anislag, Daraga, Albay', 'Albay', 'Daraga', NULL, 'Anislag', '7-Eleven', 'Commercial', 'product', NULL, NULL, 'Normal', 1, '2026-10-27 15:30:00', 1, 'Completed', '2026-10-22 14:12:15', 'S26102214121519', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 15, 'Kaagapay Street, Barangay II, Enrile, Cagayan', 'Cagayan', 'Enrile', NULL, 'Barangay II', NULL, 'Commercial', 'both', NULL, '₱50,000 - ₱100,000', 'Normal', 0, NULL, 0, 'Accepted', '2026-10-24 00:38:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 12, 'Lot Blk 2 Kaagapay Road, Calaocan, Dipaculao, Aurora', 'Aurora', 'Dipaculao', NULL, 'Calaocan', NULL, 'Residential', 'product', NULL, NULL, 'Normal', 1, '2026-10-28 09:00:00', 0, 'Cancelled', '2026-10-24 00:44:07', NULL, NULL, NULL, NULL, 'Schedule doesn\'t work', NULL, '2026-10-24 00:53:12'),
(26, 12, 'Kaagapay Street, Bail, Santo Tomas, La Union', 'La Union', 'Santo Tomas', NULL, 'Bail', NULL, 'Residential', 'product', NULL, NULL, 'Normal', 1, '2026-10-29 13:00:00', 1, 'Accepted', '2026-10-24 00:55:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 15, 'yjgyu, Allig, Flora, Apayao', 'Apayao', 'Flora', NULL, 'Allig', NULL, 'Commercial', 'package', NULL, '₱10,000 - ₱25,000', 'Normal', 0, NULL, 0, 'New Inquiry', '2026-10-24 01:50:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 20, '77 99 Lokal Camarin Caloocan City, Anggacan Sur, Tanudan, Kalinga', 'Kalinga', 'Tanudan', NULL, 'Anggacan Sur', NULL, 'Commercial', 'service', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'New Inquiry', '2026-10-24 04:25:09', 'S26102404250920', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 20, 'Kaagapay Street, Kalumsing, San Emilio, Ilocos Sur', 'Ilocos Sur', 'San Emilio', NULL, 'Kalumsing', NULL, 'Residential', 'service', NULL, NULL, 'Normal', 1, '2026-12-04 09:00:00', 1, 'Quoted', '2026-10-24 04:25:09', 'S26102404250920', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 20, 'Kaagapay Street, Canadam, Maconacon, Isabela', 'Isabela', 'Maconacon', NULL, 'Canadam', '7-11', 'Residential', 'both', NULL, '₱10,000 - ₱25,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-24 04:31:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 20, '90 Street Langit Road, Banoen, Quirino, Ilocos Sur', 'Ilocos Sur', 'Quirino', NULL, 'Banoen', 'Puregold', 'Commercial', 'package', NULL, NULL, 'Normal', 1, '2026-10-31 10:30:00', 0, 'New Inquiry', '2026-10-24 04:33:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 15, 'Lot 5 Building 66, Iba, Hagonoy, Bulacan', 'Bulacan', 'Hagonoy', NULL, 'Iba', 'Blue gate', 'Commercial', 'both', NULL, NULL, 'Normal', 1, '2026-11-02 09:00:00', 0, 'Pending Visit', '2026-10-24 07:54:01', 'S26102407540115', NULL, NULL, NULL, NULL, NULL, NULL),
(33, 15, 'Lot 44 Blk 108 Pkg 5a, Balasbas, Manito, Albay', 'Albay', 'Manito', NULL, 'Balasbas', NULL, 'Residential', 'service', NULL, '₱10,000', 'Normal', 0, NULL, 0, 'Completed', '2026-10-24 07:54:01', 'S26102407540115', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 15, 'Lot 44 Blk 108 Pkg 5a, Allangigan, Conner, Apayao', 'Apayao', 'Conner', NULL, 'Allangigan', NULL, 'Commercial', 'both', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'Changes Requested', '2026-10-24 08:00:27', NULL, 'Outside our service area', NULL, '2026-10-24 08:00:52', NULL, NULL, NULL),
(35, 15, 'Lot 44 Blk 108 Pkg 5a, Cagandungan, Luna, Apayao', 'Apayao', 'Luna', NULL, 'Cagandungan', NULL, 'Commercial', 'product', NULL, '₱25,000 - ₱50,000', 'Normal', 0, NULL, 0, 'Accepted', '2026-10-24 08:34:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 15, 'Lot 44 Blk 108 Pkg 5a, Kalumsing, San Emilio, Ilocos Sur', 'Ilocos Sur', 'San Emilio', NULL, 'Kalumsing', NULL, 'Commercial', 'package', NULL, NULL, 'Normal', 1, '2026-10-28 10:30:00', 0, 'New Inquiry', '2026-10-24 09:16:11', 'S26102409161115', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 15, 'Lot 44 Blk 108 Pkg 5a, Bantonan, Camalig, Albay', 'Albay', 'Camalig', NULL, 'Bantonan', NULL, 'Residential', 'both', NULL, '₱100,000 and above', 'Normal', 0, NULL, 0, 'Completed', '2026-10-24 09:16:11', 'S26102409161115', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `role` enum('customer','admin','superadmin') NOT NULL,
  `status` enum('Active','Disabled') NOT NULL DEFAULT 'Active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `email_verified_at` datetime DEFAULT NULL,
  `recovery_email` varchar(120) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `status`, `created_at`, `email_verified_at`, `recovery_email`, `birth_date`, `gender`) VALUES
(1, 'Owner', 'BeyondWires', 'owner@beyondwires.com', '$2y$10$cp2GOL.LFJDb4p026ohNZ.nEVSvsAcTj13Mal5dmbCtPQNLsm1NmC', NULL, 'superadmin', 'Active', '2026-10-07 05:45:27', '2026-10-21 05:52:29', NULL, NULL, NULL),
(2, 'Admin', 'NOC', 'admin@beyondwires.com', '$2y$10$Ny14ssMur08OiEJiGdCOdOeL4EOqnKjhkHBCIDWYZfZKk6r5AEscy', NULL, 'admin', 'Active', '2026-10-07 05:45:27', '2026-10-21 05:52:29', NULL, NULL, NULL),
(3, 'John', 'Doe', 'johndoe@gmail.com', '$2y$10$Ua3IsZVts5WfJshqb7xibOyqeIf0RMzhafyVFAbefVHScvdnrd332', NULL, 'customer', 'Active', '2026-10-07 06:20:13', '2026-10-21 05:52:29', NULL, NULL, NULL),
(4, 'Richiebelle', 'Del Rosairo', 'richiebelle@gmail.com', '$2y$10$mTm99wY1JKe/wT1RzZMSMeMdcl8mdVA91fMsvl8Wa0VsqQo0n084q', NULL, 'customer', 'Active', '2026-10-07 07:07:48', '2026-10-21 05:52:29', NULL, NULL, NULL),
(5, 'Tender', 'Juicy', 'tender@gmail.com', '$2y$10$SlM0CjZj2lrVgTiLncq5Fu3MDuvuiU82GOi3jT15JUcffc1DQTLby', NULL, 'customer', 'Active', '2026-10-07 09:18:21', '2026-10-21 05:52:29', NULL, NULL, NULL),
(6, 'john', 'doe', 'richie@gmail.com', '$2y$10$hkuY57aHFe5L0lu5XfMMH./ZIYlG0ZHm6QXX0w8.PK8KNFLz7DgX6', NULL, 'customer', 'Active', '2026-10-07 12:24:22', '2026-10-21 05:52:29', NULL, NULL, NULL),
(7, 'Rich', 'Del', 'richiee@gmail.com', '$2y$10$YQOefskmGHEPR4SAPUVvx.1zpEa0AVf9Xg3j00frthreULVSiSuCu', NULL, 'customer', 'Active', '2026-10-07 13:11:48', '2026-10-21 05:52:29', NULL, NULL, NULL),
(8, 'Allexis', 'Monday', 'allexis@gmail.com', '$2y$10$0Sw5Hh2d19Vi5/Bghj1L3.Q74ucGs352QkWQrJP0b.x..iOSYvs7i', NULL, 'customer', 'Active', '2026-10-07 13:12:54', '2026-10-21 05:52:29', NULL, NULL, NULL),
(9, 'Angelyn', 'Eduarte', 'angelyn@gmail.com', '$2y$10$syCTDpACt6mEb7aVBJP1e.G1VZIsyaLLRkPLkr5B63cntb7oj7xBm', NULL, 'customer', 'Active', '2026-10-07 13:16:13', '2026-10-21 05:52:29', NULL, NULL, NULL),
(10, 'Dustin', 'Yu', 'dustin@gmail.com', '$2y$10$Iu3wBggqbbYQ9mSVT9gWOOpMr9/9wWjujbsAA0F4ptdWw9tYpplGS', NULL, 'customer', 'Active', '2026-10-07 13:17:02', '2026-10-21 05:52:29', NULL, NULL, NULL),
(11, 'Allexis', 'Benlota', 'allexisbenlota@gmail.com', '$2y$10$JLRmGco33Wi6YeUsdPOFB.DdiwU1oWPkiAwk/f50kWWrCyXg0xwdC', NULL, 'customer', 'Active', '2026-10-07 13:18:36', '2026-10-21 05:52:29', NULL, NULL, NULL),
(12, 'Jasper', 'Olarte', 'jasper123@gmail.com', '$2y$10$Qaf/EOx29ok1CCm479UvD.lmrv/ZrhMNzNzfmJq5nvrCMNWazJyqK', '+63 985 391 0140', 'customer', 'Active', '2026-10-19 11:24:30', '2026-10-21 05:52:29', NULL, NULL, NULL),
(13, 'Jaycee', 'Bagnol', 'growtopianijc@gmail.com', '$2y$10$bn./H71lTmEcdMKpKDNpuuTSfFtotvGqjtzXeYMoBEmISQ/0f8OyC', NULL, 'customer', 'Active', '2026-10-21 04:52:22', '2026-10-21 05:52:29', NULL, NULL, NULL),
(14, 'Richiebelle', 'Del Rosario', 'richiebelled@gmail.com', '$2y$10$H9W.R2ZF.V7i.E6pIGTtceC2zH50z7gGGmBueLVdbJ0k6s073kC9q', '+63 951 611 0173', 'customer', 'Active', '2026-10-21 05:07:58', '2026-10-21 05:52:29', NULL, NULL, NULL),
(15, 'Chibel', 'Del Rosario', 'richiebelledelrosario@gmail.com', '$2y$10$TcltvNoEe5DDiX6g7dki8./J24uiQcgpJGhuXmJWiHGC5mg09JNK2', NULL, 'customer', 'Active', '2026-10-21 06:02:48', NULL, NULL, NULL, NULL),
(16, 'Chibel', 'Del Rosario', 'delrosariorichiebellemanoza.08@gmail.com', '$2y$10$I05q7qO2slav/jwY0ImDruv6h/epWTvH/AK5SI.g96cIsGqGTQc1y', NULL, 'customer', 'Active', '2026-10-21 06:12:39', '2026-10-21 06:14:13', NULL, NULL, NULL),
(17, 'Jasper', 'Olarte', 'jasperolarte2007@gmail.com', '$2y$10$PLclW/wOQjwp4nGA77gbUufplt34k02jsiuTp9rQIBypiZXsSTbaK', NULL, 'customer', 'Active', '2026-10-21 06:17:31', '2026-10-21 06:18:16', NULL, NULL, NULL),
(18, 'Allexis', 'Gomez', 'allexisl.benlota@gmail.com', '$2y$10$HN2/ILE5rLLyrJiv5SpnGOw35xYcKPjhZwztFhf1gFHPVA734oLvi', NULL, 'customer', 'Active', '2026-10-21 18:15:35', '2026-10-21 18:15:59', NULL, NULL, NULL),
(19, 'John', 'Mark', 'johnmark18@gmail.com', '$2y$10$8bxEIw4zrklIrE5hSja.suPIb85MOpNtwtg912xeaFdpuaVbvW0C2', NULL, 'customer', 'Active', '2026-10-22 02:57:09', NULL, NULL, NULL, NULL),
(20, 'Angelyn', 'ed', 'eduarteangelyn@gmail.com', '$2y$10$C8W2iWb0uxK5zQOUpfiNFuav1mH.HhnRqfjydHWekcZ3LQY/aReUG', NULL, 'customer', 'Active', '2026-10-22 11:38:23', '2026-10-22 11:39:20', NULL, NULL, NULL),
(21, 'Dustin', 'Yu', 'dustinmarkyu0906@gmail.com', '$2y$10$VTNeQJj7f6FvGVY3IvNyOulcX5esGSg9psbcqqBytNBN9WC.B/D3i', NULL, 'customer', 'Active', '2026-10-22 13:45:30', '2026-10-22 13:46:15', NULL, NULL, NULL),
(22, 'Harry', 'Styles', 'bsisbeyondwires@gmail.com', '$2y$10$tEfVjtMNdTAiQsm/pdawquux9DdqlrYKv/7O2Z6s3pnil.Kp2pRN2', NULL, 'customer', 'Active', '2026-10-24 04:20:08', '2026-10-24 04:20:40', NULL, '1994-02-01', 'Male');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `certificate_photos`
--
ALTER TABLE `certificate_photos`
  ADD PRIMARY KEY (`photo_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `customer_activity_logs`
--
ALTER TABLE `customer_activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `customer_documents`
--
ALTER TABLE `customer_documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `email_codes`
--
ALTER TABLE `email_codes`
  ADD PRIMARY KEY (`code_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`),
  ADD KEY `summary_id` (`summary_id`);

--
-- Indexes for table `expense_history`
--
ALTER TABLE `expense_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `idx_eh_expense` (`expense_id`);

--
-- Indexes for table `financial_summaries`
--
ALTER TABLE `financial_summaries`
  ADD PRIMARY KEY (`summary_id`),
  ADD UNIQUE KEY `month_year` (`month_year`);

--
-- Indexes for table `inquiry_items`
--
ALTER TABLE `inquiry_items`
  ADD PRIMARY KEY (`inquiry_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `installation_schedules`
--
ALTER TABLE `installation_schedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD UNIQUE KEY `uq_active_slot` (`active_key`),
  ADD KEY `quotation_id` (`quotation_id`),
  ADD KEY `inquiry_id` (`inquiry_id`),
  ADD KEY `technician_id` (`technician_id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`reset_id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `quotation_id` (`quotation_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `confirmed_by` (`confirmed_by`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_price_history`
--
ALTER TABLE `product_price_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `inquiry_id` (`inquiry_id`);

--
-- Indexes for table `project_certificates`
--
ALTER TABLE `project_certificates`
  ADD PRIMARY KEY (`project_id`);

--
-- Indexes for table `project_updates`
--
ALTER TABLE `project_updates`
  ADD PRIMARY KEY (`update_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`quotation_id`),
  ADD UNIQUE KEY `quotation_no` (`quotation_no`),
  ADD KEY `inquiry_id` (`inquiry_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `quotation_approvals`
--
ALTER TABLE `quotation_approvals`
  ADD PRIMARY KEY (`approval_id`),
  ADD KEY `quotation_id` (`quotation_id`);

--
-- Indexes for table `quotation_charges`
--
ALTER TABLE `quotation_charges`
  ADD PRIMARY KEY (`charge_id`),
  ADD KEY `quotation_id` (`quotation_id`);

--
-- Indexes for table `quotation_events`
--
ALTER TABLE `quotation_events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `quotation_id` (`quotation_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `quotation_items`
--
ALTER TABLE `quotation_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `quotation_id` (`quotation_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `quotation_labor`
--
ALTER TABLE `quotation_labor`
  ADD PRIMARY KEY (`labor_id`),
  ADD KEY `quotation_id` (`quotation_id`);

--
-- Indexes for table `quotation_rejections`
--
ALTER TABLE `quotation_rejections`
  ADD PRIMARY KEY (`rejection_id`),
  ADD KEY `quotation_id` (`quotation_id`);

--
-- Indexes for table `quotation_revisions`
--
ALTER TABLE `quotation_revisions`
  ADD PRIMARY KEY (`revision_id`),
  ADD KEY `quotation_id` (`quotation_id`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD UNIQUE KEY `payment_id` (`payment_id`),
  ADD UNIQUE KEY `receipt_no` (`receipt_no`),
  ADD KEY `issued_by` (`issued_by`);

--
-- Indexes for table `schedule_availability`
--
ALTER TABLE `schedule_availability`
  ADD PRIMARY KEY (`available_date`,`time_slot`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `schedule_changes`
--
ALTER TABLE `schedule_changes`
  ADD PRIMARY KEY (`change_id`),
  ADD KEY `idx_sc_schedule` (`schedule_id`);

--
-- Indexes for table `service_inquiries`
--
ALTER TABLE `service_inquiries`
  ADD PRIMARY KEY (`inquiry_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uq_recovery_email` (`recovery_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=508;

--
-- AUTO_INCREMENT for table `certificate_photos`
--
ALTER TABLE `certificate_photos`
  MODIFY `photo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `customer_activity_logs`
--
ALTER TABLE `customer_activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `customer_documents`
--
ALTER TABLE `customer_documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `email_codes`
--
ALTER TABLE `email_codes`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `expense_history`
--
ALTER TABLE `expense_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `financial_summaries`
--
ALTER TABLE `financial_summaries`
  MODIFY `summary_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `installation_schedules`
--
ALTER TABLE `installation_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=320;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `reset_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `product_price_history`
--
ALTER TABLE `product_price_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `project_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `project_updates`
--
ALTER TABLE `project_updates`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `quotation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `quotation_approvals`
--
ALTER TABLE `quotation_approvals`
  MODIFY `approval_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `quotation_charges`
--
ALTER TABLE `quotation_charges`
  MODIFY `charge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `quotation_events`
--
ALTER TABLE `quotation_events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `quotation_items`
--
ALTER TABLE `quotation_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `quotation_labor`
--
ALTER TABLE `quotation_labor`
  MODIFY `labor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `quotation_rejections`
--
ALTER TABLE `quotation_rejections`
  MODIFY `rejection_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quotation_revisions`
--
ALTER TABLE `quotation_revisions`
  MODIFY `revision_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `schedule_changes`
--
ALTER TABLE `schedule_changes`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `service_inquiries`
--
ALTER TABLE `service_inquiries`
  MODIFY `inquiry_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `certificate_photos`
--
ALTER TABLE `certificate_photos`
  ADD CONSTRAINT `certificate_photos_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `customer_activity_logs`
--
ALTER TABLE `customer_activity_logs`
  ADD CONSTRAINT `customer_activity_logs_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `customer_documents`
--
ALTER TABLE `customer_documents`
  ADD CONSTRAINT `customer_documents_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `email_codes`
--
ALTER TABLE `email_codes`
  ADD CONSTRAINT `email_codes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`summary_id`) REFERENCES `financial_summaries` (`summary_id`);

--
-- Constraints for table `inquiry_items`
--
ALTER TABLE `inquiry_items`
  ADD CONSTRAINT `inquiry_items_ibfk_1` FOREIGN KEY (`inquiry_id`) REFERENCES `service_inquiries` (`inquiry_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `inquiry_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `installation_schedules`
--
ALTER TABLE `installation_schedules`
  ADD CONSTRAINT `installation_schedules_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`),
  ADD CONSTRAINT `installation_schedules_ibfk_2` FOREIGN KEY (`inquiry_id`) REFERENCES `service_inquiries` (`inquiry_id`),
  ADD CONSTRAINT `installation_schedules_ibfk_3` FOREIGN KEY (`technician_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`confirmed_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `product_price_history`
--
ALTER TABLE `product_price_history`
  ADD CONSTRAINT `product_price_history_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_price_history_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`inquiry_id`) REFERENCES `service_inquiries` (`inquiry_id`);

--
-- Constraints for table `project_certificates`
--
ALTER TABLE `project_certificates`
  ADD CONSTRAINT `project_certificates_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE;

--
-- Constraints for table `project_updates`
--
ALTER TABLE `project_updates`
  ADD CONSTRAINT `project_updates_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_updates_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `quotations`
--
ALTER TABLE `quotations`
  ADD CONSTRAINT `quotations_ibfk_1` FOREIGN KEY (`inquiry_id`) REFERENCES `service_inquiries` (`inquiry_id`),
  ADD CONSTRAINT `quotations_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `quotations_ibfk_3` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`),
  ADD CONSTRAINT `quotations_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `quotation_approvals`
--
ALTER TABLE `quotation_approvals`
  ADD CONSTRAINT `quotation_approvals_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`);

--
-- Constraints for table `quotation_charges`
--
ALTER TABLE `quotation_charges`
  ADD CONSTRAINT `quotation_charges_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`) ON DELETE CASCADE;

--
-- Constraints for table `quotation_events`
--
ALTER TABLE `quotation_events`
  ADD CONSTRAINT `quotation_events_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotation_events_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `quotation_items`
--
ALTER TABLE `quotation_items`
  ADD CONSTRAINT `quotation_items_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quotation_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `quotation_labor`
--
ALTER TABLE `quotation_labor`
  ADD CONSTRAINT `quotation_labor_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`) ON DELETE CASCADE;

--
-- Constraints for table `quotation_rejections`
--
ALTER TABLE `quotation_rejections`
  ADD CONSTRAINT `quotation_rejections_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`) ON DELETE CASCADE;

--
-- Constraints for table `quotation_revisions`
--
ALTER TABLE `quotation_revisions`
  ADD CONSTRAINT `quotation_revisions_ibfk_1` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`quotation_id`) ON DELETE CASCADE;

--
-- Constraints for table `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `receipts_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`),
  ADD CONSTRAINT `receipts_ibfk_2` FOREIGN KEY (`issued_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `schedule_availability`
--
ALTER TABLE `schedule_availability`
  ADD CONSTRAINT `schedule_availability_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `service_inquiries`
--
ALTER TABLE `service_inquiries`
  ADD CONSTRAINT `service_inquiries_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
