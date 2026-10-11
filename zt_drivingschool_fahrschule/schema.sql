CREATE TABLE IF NOT EXISTS `zt_driving_licenses` (
    `citizenid` VARCHAR(50) NOT NULL PRIMARY KEY,
    `theory_passed` TINYINT(1) DEFAULT 0,
    `practical_passed` TINYINT(1) DEFAULT 0,
    `instructor_id` VARCHAR(50) DEFAULT NULL,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
