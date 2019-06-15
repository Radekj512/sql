show databases;
use my_own_database;

CREATE TABLE `user`
(
  `user_id` int PRIMARY KEY,
  `rank_id` int,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(50) UNIQUE NOT NULL,
  `registration_date` datetime
);

CREATE TABLE `news`
(
  `id` int PRIMARY KEY,
  `user_id` int,
  `category_id` int,
  `adding_time` datetime,
  `content` varchar(10000)
);

CREATE TABLE `comment`
(
  `id` int PRIMARY KEY,
  `user_id` int,
  `news_id` int,
  `adding_time` datetime,
  `content` varchar(255)
);

CREATE TABLE `category`
(
  `id` int PRIMARY KEY,
  `category_name` varchar(30)
);

CREATE TABLE `ranks`
(
  `id` int PRIMARY KEY,
  `rank_name` varchar(30),
  `access_level` int
);

ALTER TABLE comment MODIFY user_id INT(11) NOT NULL;
ALTER TABLE comment MODIFY user_id INT(11) UNIQUE;


ALTER TABLE `user` ADD CONSTRAINT `user_comment_fk` FOREIGN KEY (`user_id`) REFERENCES `comment`(`user_id`);


ALTER TABLE `user` ADD FOREIGN KEY (`user_id`) REFERENCES `comment` (`user_id`);
ALTER TABLE `news` ADD FOREIGN KEY (`id`) REFERENCES `comment` (`news_id`);
ALTER TABLE `category` ADD FOREIGN KEY (`id`) REFERENCES `news` (`category_id`);
ALTER TABLE `user` ADD FOREIGN KEY (`user_id`) REFERENCES `news` (`user_id`);
ALTER TABLE `user` ADD FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`id`);