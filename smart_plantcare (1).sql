-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 22, 2026 at 06:10 PM
-- Server version: 5.7.40
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_plantcare`
--

-- --------------------------------------------------------

--
-- Table structure for table `care_tasks`
--

DROP TABLE IF EXISTS `care_tasks`;
CREATE TABLE IF NOT EXISTS `care_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plant_id` int(11) NOT NULL,
  `task_type` varchar(50) NOT NULL,
  `scheduled_date` date NOT NULL,
  `status` enum('pending','completed') DEFAULT 'pending',
  `notes` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `plant_id` (`plant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `diagnoses`
--

DROP TABLE IF EXISTS `diagnoses`;
CREATE TABLE IF NOT EXISTS `diagnoses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plant_id` int(11) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `problem` varchar(150) DEFAULT NULL,
  `confidence` decimal(5,2) DEFAULT NULL,
  `questions` text,
  `suggestion` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disease_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plant_id` (`plant_id`),
  KEY `disease_id` (`disease_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `diseases`
--

DROP TABLE IF EXISTS `diseases`;
CREATE TABLE IF NOT EXISTS `diseases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `symptoms` text,
  `possible_causes` text,
  `treatment` text,
  `prevention` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `growth_logs`
--

DROP TABLE IF EXISTS `growth_logs`;
CREATE TABLE IF NOT EXISTS `growth_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plant_id` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `notes` text,
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `plant_id` (`plant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `task_id` int(11) DEFAULT NULL,
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
CREATE TABLE IF NOT EXISTS `pet` (
  `pet_id` int(11) NOT NULL AUTO_INCREMENT,
  `pet_name` varchar(100) NOT NULL,
  `pet_type` varchar(50) NOT NULL,
  `breed` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `fk_pet_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `plants`
--

DROP TABLE IF EXISTS `plants`;
CREATE TABLE IF NOT EXISTS `plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `species_id` int(11) DEFAULT NULL,
  `plant_name` varchar(100) NOT NULL,
  `nickname` varchar(100) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `environment` enum('indoor','outdoor') DEFAULT 'indoor',
  `pot_type` varchar(50) DEFAULT NULL,
  `last_watered` date DEFAULT NULL,
  `health_status` varchar(50) DEFAULT 'Healthy',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `species_id` (`species_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `plant_pet_safety`
--

DROP TABLE IF EXISTS `plant_pet_safety`;
CREATE TABLE IF NOT EXISTS `plant_pet_safety` (
  `safety_id` int(11) NOT NULL AUTO_INCREMENT,
  `species_id` int(11) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `safety_status` varchar(50) NOT NULL,
  `safety_notes` text NOT NULL,
  PRIMARY KEY (`safety_id`),
  KEY `pet_id` (`pet_id`),
  KEY `species_id` (`species_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `plant_species`
--

DROP TABLE IF EXISTS `plant_species`;
CREATE TABLE IF NOT EXISTS `plant_species` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `scientific_name` varchar(150) DEFAULT NULL,
  `description` text,
  `water_frequency` int(11) DEFAULT '3',
  `sunlight` varchar(100) DEFAULT NULL,
  `soil` varchar(150) DEFAULT NULL,
  `humidity` varchar(100) DEFAULT NULL,
  `fertilizer` varchar(255) DEFAULT NULL,
  `pet_safety` enum('safe','unsafe','unknown') DEFAULT 'unknown',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `plant_species`
--

INSERT INTO `plant_species` (`id`, `name`, `scientific_name`, `description`, `water_frequency`, `sunlight`, `soil`, `humidity`, `fertilizer`, `pet_safety`, `created_at`) VALUES
(1, 'Rose', 'Rosa', 'A flowering plant that needs good sunlight and well-drained soil.', 3, 'Full Sun', 'Well-drained soil', 'Moderate', 'Balanced fertilizer', 'unknown', '2026-09-18 16:58:48'),
(2, 'Tulsi', 'Ocimum tenuiflorum', 'A common aromatic plant that grows well in sunlight.', 2, 'Full Sun', 'Well-drained soil', 'Moderate', 'Organic fertilizer', 'safe', '2026-09-18 16:58:48'),
(3, 'Money Plant', 'Epipremnum aureum', 'A popular indoor plant that can grow in indirect sunlight.', 4, 'Indirect Light', 'Well-drained potting soil', 'High', 'Balanced fertilizer', 'unsafe', '2026-09-18 16:58:48'),
(4, 'Aloe Vera', 'Aloe barbadensis miller', 'A succulent plant that requires relatively little watering.', 7, 'Bright Light', 'Sandy well-drained soil', 'Low', 'Low fertilizer', 'unsafe', '2026-09-18 16:58:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Srushti', 'srushti@gmail.com', '12345', 'user', '2026-09-22 18:04:21');

-- --------------------------------------------------------

--
-- Table structure for table `weather_logs`
--

DROP TABLE IF EXISTS `weather_logs`;
CREATE TABLE IF NOT EXISTS `weather_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL,
  `humidity` decimal(5,2) DEFAULT NULL,
  `rainfall` decimal(8,2) DEFAULT NULL,
  `weather_condition` varchar(100) DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `care_tasks`
--
ALTER TABLE `care_tasks`
  ADD CONSTRAINT `care_tasks_ibfk_1` FOREIGN KEY (`plant_id`) REFERENCES `plants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `diagnoses`
--
ALTER TABLE `diagnoses`
  ADD CONSTRAINT `diagnoses_ibfk_1` FOREIGN KEY (`plant_id`) REFERENCES `plants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `diagnoses_ibfk_2` FOREIGN KEY (`disease_id`) REFERENCES `diseases` (`id`);

--
-- Constraints for table `growth_logs`
--
ALTER TABLE `growth_logs`
  ADD CONSTRAINT `growth_logs_ibfk_1` FOREIGN KEY (`plant_id`) REFERENCES `plants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `care_tasks` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pet`
--
ALTER TABLE `pet`
  ADD CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `plants`
--
ALTER TABLE `plants`
  ADD CONSTRAINT `plants_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plants_ibfk_2` FOREIGN KEY (`species_id`) REFERENCES `plant_species` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `plant_pet_safety`
--
ALTER TABLE `plant_pet_safety`
  ADD CONSTRAINT `plant_pet_safety_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `pet` (`pet_id`),
  ADD CONSTRAINT `plant_pet_safety_ibfk_2` FOREIGN KEY (`species_id`) REFERENCES `plant_species` (`id`);

--
-- Constraints for table `weather_logs`
--
ALTER TABLE `weather_logs`
  ADD CONSTRAINT `weather_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
