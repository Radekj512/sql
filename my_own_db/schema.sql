USE my_own_database;

CREATE TABLE `user` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`rank_id` INT NOT NULL,
	`username` varchar(30) NOT NULL,
	`password` varchar(30) NOT NULL,
	`email` varchar(50) NOT NULL,
	`registration_date` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `news` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`category_id` INT NOT NULL,
	`adding_time` DATETIME NOT NULL,
	`content` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `category` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`category_name` varchar(30) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `ranks` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`rank_name` varchar(30) NOT NULL,
	`access_level` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `comment` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
	`news_id` INT NOT NULL,
	`adding_time` DATETIME NOT NULL,
	`content` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `user` ADD CONSTRAINT `user_fk0` FOREIGN KEY (`rank_id`) REFERENCES `ranks`(`id`);

ALTER TABLE `news` ADD CONSTRAINT `news_fk0` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);

ALTER TABLE `news` ADD CONSTRAINT `news_fk1` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`);

ALTER TABLE `comment` ADD CONSTRAINT `comment_fk0` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);

ALTER TABLE `comment` ADD CONSTRAINT `comment_fk1` FOREIGN KEY (`news_id`) REFERENCES `news`(`id`);

CREATE VIEW full_user AS
    SELECT 
        u.id,
        r.rank_name,
        u.username,
        u.password,
        u.email,
        u.registration_date
    FROM
        user u
            INNER JOIN
        ranks r ON r.id = u.rank_id;
        SELECT MIN(registration_date) from user;
        
delimiter //
DROP FUNCTION find_oldest_user//
CREATE FUNCTION find_oldest_user() RETURNS DATETIME DETERMINISTIC
BEGIN
DECLARE oldest DATETIME;
	SET oldest = 0;
SELECT 
    MIN(registration_date)
INTO oldest FROM
    user;
  RETURN oldest;
END 
//

DROP PROCEDURE get_all_comments_from_news//
CREATE PROCEDURE get_all_comments_from_news(id INT)
BEGIN
	SELECT * FROM comment WHERE news_id = id;
END
//

delimiter ;

