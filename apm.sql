create table access_points (
    -- Access Points Unique characteristics
    `id` integer primary key autoincrement,
    `name` varchar(255) NOT NULL,
    `fqln` varchar(255) DEFAULT NULL,
    `flags` varchar(255) DEFAULT NULL,
    `group_name` varchar(255) DEFAULT NULL,
    `ip_address` varchar(45) DEFAULT NULL,
    `mac_address` varchar(17) DEFAULT NULL,
    `wired_mac_address` varchar(17) DEFAULT NULL,
    `outer_ip` varchar(45) DEFAULT NULL,
    `port` varchar(10) DEFAULT NULL,
    `serial_number` varchar(255) DEFAULT NULL,
    `standby_ip` varchar(45) DEFAULT NULL,
    `status` enum('online','offline','maintenance','error') DEFAULT 'offline',
    `switch_ip` varchar(45) DEFAULT NULL,
    `user_info` text DEFAULT NULL,
    `deployment_date` date DEFAULT NULL,
    `client_count` int(11) DEFAULT 0,
    `last_seen` timestamp NULL DEFAULT NULL,
    `uptime` varchar(100) DEFAULT NULL,
    `description` text DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `deleted_at` timestamp NULL DEFAULT NULL,
    `is_deleted` boolean DEFAULT false,

    -- Foreign Key Relationships
    `location_id` integer DEFAULT NULL,
    `model_id` integer DEFAULT NULL,
    `firmware_id` integer DEFAULT NULL,
    `inventory_id` integer DEFAULT NULL,

    FOREIGN KEY (`location_id`) REFERENCES locations(`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`model_id`) REFERENCES models(`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`firmware_id`) REFERENCES firmwares(`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`inventory_id`) REFERENCES inventories(`id`) ON DELETE SET NULL ON UPDATE CASCADE,

    -- Indexes
    UNIQUE (`mac_address`),
    UNIQUE (`serial_number`),
    INDEX `idx_access_points_name` (`name`),
    INDEX `idx_access_points_ip_address` (`ip_address`),
    INDEX `idx_access_points_mac_address` (`mac_address`),
    INDEX `idx_access_points_serial_number` (`serial_number`),
    INDEX `idx_access_points_location_id` (`location_id`),
    INDEX `idx_access_points_model_id` (`model_id`),
    INDEX `idx_access_points_firmware_id` (`firmware_id`),
    INDEX `idx_access_points_inventory_id` (`inventory_id`)
);

create table `access_point_models` (
    -- Access Point Models Unique characteristics
    `id` integer primary key autoincrement,
    `manufacturer` varchar(255) NOT NULL,
    `name` varchar(255) NOT NULL,
    `model_number` varchar(255) DEFAULT NULL,
    `category_id` integer DEFAULT NULL,
    `frequency_bands` varchar(255) NOT NULL,
    `max_tx_power` int(11) DEFAULT NULL,
    `antenna_type` varchar(255) DEFAULT NULL,
    `antenna_gain` decimal(5,2) DEFAULT NULL,
    `wifi_standard` varchar(50) DEFAULT NULL,
    `max_throughput` varchar(100) DEFAULT NULL,
    `ethernet_ports` int(11) DEFAULT NULL,
    `poe_requirement` varchar(100) DEFAULT NULL,
    `power_consumption` decimal(6,2) DEFAULT NULL,
    `operating_temp_min` int(11) DEFAULT NULL,
    `operating_temp_max` int(11) DEFAULT NULL,
    `dimensions` varchar(255) DEFAULT NULL,
    `weight` decimal(6,2) DEFAULT NULL,
    `mounting_type` varchar(100) DEFAULT NULL,
    `ip_rating` varchar(20) DEFAULT NULL,
    `datasheet_url` text DEFAULT NULL,
    `firmware_version` varchar(100) DEFAULT NULL,
    `coverage_range` decimal(8,2) DEFAULT 10.00,
    `notes` text DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),

    -- Foreign Key Relationships
    `manufacturer_id` integer DEFAULT NULL,
    `category_id` integer DEFAULT NULL,

    -- Foreign Key Constraints
    FOREIGN KEY (`manufacturer_id`) REFERENCES manufacturers(`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`category_id`) REFERENCES categories(`id`) ON DELETE SET NULL ON UPDATE CASCADE,

    -- Indexes
    UNIQUE (`model_number`),
    UNIQUE (`name`, `manufacturer_id`),
    INDEX `idx_access_point_models_manufacturer` (`manufacturer_id`),
    INDEX `idx_access_point_models_name` (`name`)
);

create table `access_point_model_categories` (
    -- Access Point Model Categories Unique characteristics
    `id` integer primary key autoincrement,
    `name` varchar(255) NOT NULL,
    `description` text DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),

    -- Indexes
    UNIQUE (`name`),
    INDEX `idx_access_point_model_categories_name` (`name`)
);