CREATE TABLE IF NOT EXISTS `zt_tailor_modifications` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `citizenid` VARCHAR(50) NOT NULL,
    `component_id` INT NOT NULL,
    `drawable_id` INT NOT NULL,
    `texture_id` INT NOT NULL,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `unique_char_comp` (`citizenid`, `component_id`)
);
