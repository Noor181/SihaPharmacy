-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 20, 2025 at 09:01 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `koshy`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int NOT NULL,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Pending','Accepted','Rejected') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `doctor_id`, `appointment_date`, `created_at`, `status`) VALUES
(1, 2, 1, '2024-11-19 15:50:00', '2024-11-19 09:50:43', 'Accepted'),
(2, 2, 6, '2024-11-22 10:30:00', '2024-11-19 11:28:45', 'Pending'),
(3, 2, 4, '2024-11-22 16:54:00', '2024-11-20 10:54:47', 'Accepted'),
(4, 8, 9, '2025-01-30 10:30:00', '2025-01-27 05:20:50', 'Accepted'),
(5, 11, 12, '2025-01-29 14:24:00', '2025-01-29 11:24:25', 'Rejected'),
(6, 11, 12, '2025-01-29 14:24:00', '2025-01-29 11:24:41', 'Accepted');

-- --------------------------------------------------------

--
-- Table structure for table `diagnoses`
--

CREATE TABLE `diagnoses` (
  `id` int NOT NULL,
  `appointment_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `symptoms` text,
  `diagnosis` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `diagnoses`
--

INSERT INTO `diagnoses` (`id`, `appointment_id`, `created_at`, `symptoms`, `diagnosis`) VALUES
(1, 1, '2024-11-20 09:23:48', 'polo', NULL),
(3, 3, '2024-11-20 10:58:50', 'fever', NULL),
(4, 6, '2025-01-29 11:34:15', 'fever\r\npain joints\r\nvomiting', 'Not Diagnosed');

-- --------------------------------------------------------

--
-- Table structure for table `dios`
--

CREATE TABLE `dios` (
  `id` int NOT NULL,
  `appointment_id` int NOT NULL,
  `diagnosis_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exercise_data`
--

CREATE TABLE `exercise_data` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `exercise_type` varchar(255) NOT NULL,
  `duration` int NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Approved','Fair','Not Approved') NOT NULL DEFAULT 'Fair'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exercise_data`
--

INSERT INTO `exercise_data` (`id`, `email`, `exercise_type`, `duration`, `date`, `created_at`, `status`) VALUES
(1, 'alvin@gmail.com', 'pushups', 50, '2024-11-20', '2024-11-20 13:21:02', 'Fair'),
(2, 'abby@gmail.com', 'jogging', 180, '2024-11-21', '2024-11-21 08:11:40', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `nutrition_data`
--

CREATE TABLE `nutrition_data` (
  `id` int NOT NULL,
  `food_name` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `protein_food` varchar(255) NOT NULL,
  `vitamin_food` varchar(255) NOT NULL,
  `carb_food` varchar(255) NOT NULL,
  `status` enum('Approved','Fair','Not Approved') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nutrition_data`
--

INSERT INTO `nutrition_data` (`id`, `food_name`, `date`, `protein_food`, `vitamin_food`, `carb_food`, `status`, `created_at`, `email`) VALUES
(1, 'ugali', '2024-11-20', 'eggs', 'kales', 'ugali', 'Approved', '2024-11-20 12:32:46', 'alvin@gmail.com'),
(2, 'biriani', '2024-11-21', 'meat', 'carrots', 'rice', 'Approved', '2024-11-21 08:02:27', 'abby@gmail.com'),
(3, 'pilau', '2025-01-29', 'meat', 'veggies', 'rice', 'Approved', '2025-01-29 11:29:40', 'mwangi77@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `patients_lab_results`
--

CREATE TABLE `patients_lab_results` (
  `id` int NOT NULL,
  `patient_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients_lab_results`
--

INSERT INTO `patients_lab_results` (`id`, `patient_id`, `file_name`, `file_path`, `uploaded_at`) VALUES
(1, 1, 'Diploma  Degree Log Book.pdf', '/uploads/Diploma  Degree Log Book.pdf', '2025-03-27 06:10:03');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` int NOT NULL,
  `appointment_id` int NOT NULL,
  `medication` text NOT NULL,
  `dosage` varchar(255) DEFAULT NULL,
  `instructions` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `diagnosis` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `appointment_id`, `medication`, `dosage`, `instructions`, `created_at`, `diagnosis`) VALUES
(3, 3, 'pa', '2x3', 'eat first', '2024-11-30 16:48:52', 'malaria'),
(4, 3, 'Mara Moja', '1x1', 'Take with water', '2024-11-30 17:23:37', 'Typhoid'),
(5, 4, 'panadol', '1x1', 'take after a meal', '2025-01-27 05:27:00', 'fever'),
(6, 6, 'panadol', '1x3', 'take after meals', '2025-01-29 11:38:56', 'malaria');

-- --------------------------------------------------------

--
-- Table structure for table `sleep_data`
--

CREATE TABLE `sleep_data` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `hours_slept` float NOT NULL,
  `sleep_quality` enum('Poor','Fair','Good') DEFAULT 'Fair',
  `sleep_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sleep_data`
--

INSERT INTO `sleep_data` (`id`, `email`, `hours_slept`, `sleep_quality`, `sleep_date`, `created_at`) VALUES
(1, 'alvin@gmail.com', 7, 'Fair', '2024-11-20', '2024-11-20 13:24:43'),
(2, 'abby@gmail.com', 6, 'Fair', '2024-11-21', '2024-11-21 08:12:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('patient','doctor') DEFAULT 'patient',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'brenda', 'brenda@gmail.com', '$2y$10$rnTooyyB6Ncb3FiF8SnBIOoKYu2e0PNbgVwU5Nqi5GSHQRcqzbANe', 'doctor', '2024-11-19 08:44:40'),
(2, 'alvin', 'alvin@gmail.com', '$2y$10$2GPU8TeMlAfFiGK99hHW6eM.aHCtdZZV4bal3vdFl.I7dTjJ1T9oO', 'patient', '2024-11-19 08:45:26'),
(4, 'malesi', 'malesi@gmail.com', '$2y$10$cTxPvN9TLjWVZ.8f0ezDAu2tHImWTTEd1t4EdlFiKA9/sp3YNPAl2', 'doctor', '2024-11-19 11:20:43'),
(5, 'abby', 'abby@gmail.com', '$2y$10$P5j6cAxhKnWm/eUwY7FuXumq7HYbQkQWP4qxfD75AtIXCbtQ3OJpO', 'patient', '2024-11-19 11:22:35'),
(6, 'paul', 'paul@gmail.com', '$2y$10$pafzzj.kvxznLfmR2LkOReF6DXEpyKijI.2tt8dWePaSL2tIih/02', 'doctor', '2024-11-19 11:26:41'),
(8, 'koshy nyawira', 'koshy@gmail.com', '$2y$10$vdI7HY4lTviwZ.UEPeF7xeyhKuBCEI5nOa6Hs5G/GQh9ufnHbZuyC', 'patient', '2025-01-27 05:15:54'),
(9, 'leiyan kintei', 'leiyan@gmail.com', '$2y$10$FUuQOmEvFYAXMmvkweguZ.7Uia0QCpURMJ9PRA1FbR8.quXx1ODO.', 'doctor', '2025-01-27 05:18:21'),
(11, 'mwangi', 'mwangi77@gmail.com', '$2y$10$.igV5w.R5coALsDimC0pQO63m/lYThb.qjKRQdl/Lqbf8D.DOANAW', 'patient', '2025-01-29 11:13:10'),
(12, 'mwas g', 'mwas@gmail.com', '$2y$10$k.CFUJ1qhNo/X1qoJ2oRve4/myxYpcai3h4TKujAM4nUJZoqaDLbW', 'doctor', '2025-01-29 11:21:24'),
(13, 'testing1', 't1@mail.com', '$2y$10$jw9Ex/E46Wga2dPlSw4Qme.KHW0m7r9ythq2uuupYUOYyVQ/mpLrO', 'doctor', '2025-02-12 06:41:53');

-- --------------------------------------------------------

--
-- Table structure for table `vaccination`
--

CREATE TABLE `vaccination` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `birth_cert` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `vaccine` varchar(255) NOT NULL,
  `status` enum('Pending','Approved','Denied') NOT NULL DEFAULT 'Pending',
  `applied_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vaccination`
--

INSERT INTO `vaccination` (`id`, `name`, `age`, `gender`, `birth_cert`, `location`, `vaccine`, `status`, `applied_at`) VALUES
(1, 'leiyan kintei', 20, 'Male', '22222', 'nAkuru', 'Influenza', 'Denied', '2025-01-31 05:55:36'),
(2, 'mwas g', 22, 'Male', '01020200000', 'nairobi', 'COVID-19', 'Approved', '2025-01-31 06:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `water_intake_data`
--

CREATE TABLE `water_intake_data` (
  `id` int NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(5,2) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` enum('approved','fair','not approved') DEFAULT 'fair'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `water_intake_data`
--

INSERT INTO `water_intake_data` (`id`, `date`, `amount`, `email`, `status`) VALUES
(1, '2024-11-20', 9.00, 'alvin@gmail.com', 'not approved'),
(2, '2024-11-21', 4.00, 'abby@gmail.com', 'fair');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `diagnoses`
--
ALTER TABLE `diagnoses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `dios`
--
ALTER TABLE `dios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `exercise_data`
--
ALTER TABLE `exercise_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nutrition_data`
--
ALTER TABLE `nutrition_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients_lab_results`
--
ALTER TABLE `patients_lab_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `sleep_data`
--
ALTER TABLE `sleep_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `vaccination`
--
ALTER TABLE `vaccination`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `birth_cert` (`birth_cert`);

--
-- Indexes for table `water_intake_data`
--
ALTER TABLE `water_intake_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `diagnoses`
--
ALTER TABLE `diagnoses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `dios`
--
ALTER TABLE `dios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exercise_data`
--
ALTER TABLE `exercise_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nutrition_data`
--
ALTER TABLE `nutrition_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patients_lab_results`
--
ALTER TABLE `patients_lab_results`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sleep_data`
--
ALTER TABLE `sleep_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `vaccination`
--
ALTER TABLE `vaccination`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `water_intake_data`
--
ALTER TABLE `water_intake_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `diagnoses`
--
ALTER TABLE `diagnoses`
  ADD CONSTRAINT `diagnoses_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);

--
-- Constraints for table `dios`
--
ALTER TABLE `dios`
  ADD CONSTRAINT `dios_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);

--
-- Constraints for table `water_intake_data`
--
ALTER TABLE `water_intake_data`
  ADD CONSTRAINT `water_intake_data_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
