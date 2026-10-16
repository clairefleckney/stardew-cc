CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unlocked` bool DEFAULT 0,
  `done` bool DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `bundles` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slots` int,
  `done` bool DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `room_bundles` (
  `room_id` int NOT NULL,
  `bundle_id` int NOT NULL,
  PRIMARY KEY (`room_id`, `bundle_id`)
);

CREATE TABLE IF NOT EXISTS `items` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `quality` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `bundle_items` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `bundle_id` int NOT NULL,
  `item_id` int NOT NULL,
  `qual_id` int NOT NULL,
  `qty` int,
  `done` bool DEFAULT 0
);

ALTER TABLE `room_bundles` ADD FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);

ALTER TABLE `room_bundles` ADD FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`);

ALTER TABLE `bundle_items` ADD FOREIGN KEY (`bundle_id`) REFERENCES `bundles` (`id`);

ALTER TABLE `bundle_items` ADD FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

ALTER TABLE `bundle_items` ADD FOREIGN KEY (`qual_id`) REFERENCES `quality` (`id`);