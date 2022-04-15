CREATE TABLE `customer` (
  `SSN` int NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `telephone` decimal(10,0) DEFAULT NULL,
  `DriverLicense` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`SSN`)
);

CREATE TABLE `dependents` (
  `SSN` int NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `DriverLicense` varchar(15) DEFAULT NULL,
  `SSN_customer` int NOT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `SSN_customer` FOREIGN KEY (`SSN`) REFERENCES `customer` (`SSN`)
);

CREATE TABLE `policy` (
  `policy_no` int NOT NULL,
  `term_price` float DEFAULT NULL,
  `coverage` varchar(15) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `SSN` int DEFAULT NULL,
  PRIMARY KEY (`policy_no`),
  FOREIGN KEY (`SSN`) REFERENCES `customer` (`SSN`)
);

CREATE TABLE `life_policy` (
  `id_policy` int NOT NULL,
  `value` float DEFAULT NULL,
  `min_age` int DEFAULT NULL,
  `max_age` int DEFAULT NULL,
  `policy_num` int DEFAULT NULL,
  PRIMARY KEY (`id_policy`),
  FOREIGN KEY (`policy_num`) REFERENCES `policy` (`policy_no`)
);

CREATE TABLE `payment` (
  `id_payment` int NOT NULL,
  `due_date` date DEFAULT NULL,
  `payment_amount` float DEFAULT NULL,
  `policy_numb` int DEFAULT NULL,
  PRIMARY KEY (`id_payment`),
  FOREIGN KEY (`policy_numb`) REFERENCES `policy` (`policy_no`)
);

CREATE TABLE `vehicle` (
  `VIN_no` int NOT NULL,
  `plate` varchar(20) DEFAULT NULL,
  `registered_state` varchar(20) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `year` year DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`VIN_no`)
);

CREATE TABLE `vehicle_policy` (
  `id_policy` int NOT NULL,
  `VIN_num` int DEFAULT NULL,
  `type` ENUM ('old','new') DEFAULT NULL,
  `driver_driving_history` varchar(40) DEFAULT NULL,
  `policy_num` int DEFAULT NULL,
  PRIMARY KEY (`id_policy`),
  FOREIGN KEY (`VIN_num`) REFERENCES `vehicle` (`VIN_no`),
  FOREIGN KEY (`policy_num`) REFERENCES `policy` (`policy_no`)
);

CREATE TABLE `cars` (
  `VIN_no` int NOT NULL,
  `car_type` varchar(20) DEFAULT NULL,
  `transmission_type` ENUM ('automatic','manual') DEFAULT NULL,
  `size`  ENUM ('subcompact','compact','midsize','large') DEFAULT NULL,
  PRIMARY KEY (`VIN_no`)
);

CREATE TABLE `motorcycles` (
  `VIN_no` int NOT NULL,
  `type` ENUM ('standard','cruiser','scooters','sport bike') DEFAULT NULL,
  `weight` float DEFAULT NULL,
   PRIMARY KEY (`VIN_no`)
);

CREATE TABLE `report` (
  `report_no` int NOT NULL,
  `date` date DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL,
  `damage_cost` float DEFAULT NULL,
  `DriverLicense` varchar(15) DEFAULT NULL,
  `VIN_numb` int DEFAULT NULL,
  PRIMARY KEY (`report_no`),
  FOREIGN KEY (`VIN_numb`) REFERENCES `vehicle` (`VIN_no`)
);