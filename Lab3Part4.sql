SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `student_data` DEFAULT CHARACTER SET utf8 ;
USE `student_data` ;

-- -----------------------------------------------------
-- Table `student_data`.`address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `student_data`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT ,
  `address_name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`address_id`) )
ENGINE = InnoDB;

INSERT INTO `address`(`address_id`, `address_name`) VALUES ('1', '123 Main Street'),('2','345 Second Street'), ('3', '45 York Street'), ('4', '625 5th Avenue'), ('5', '29 Broad Street');
-- -----------------------------------------------------
-- Table `student_data`.`major`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `student_data`.`major` (
  `major_id` INT NOT NULL AUTO_INCREMENT ,
  `major_name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`major_id`) )
ENGINE = InnoDB;

INSERT INTO `major`(`major_id`, `major_name`) VALUES ('1', 'Programming'),('2','Networking'), ('3', 'Certificate');


-- -----------------------------------------------------
-- Table `student_data`.`major_advisor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `student_data`.`major_advisor` (
  `advisor_id` INT NOT NULL AUTO_INCREMENT ,
  `advisor_name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`advisor_id`) )
ENGINE = InnoDB;

INSERT INTO `major_advisor`(`advisor_id`, `advisor_name`) VALUES ('1', 'Smith'),('2','Jones');

-- -----------------------------------------------------
-- Table `student_data`.`student`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `student_data`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `address_id` INT NOT NULL ,
  `major_id` INT NOT NULL ,
  `major_advisor` INT NOT NULL ,
  PRIMARY KEY (`student_id`) ,
  INDEX `fk_address_id_idx` (`address_id` ASC) ,
  INDEX `fk_major_id_idx` (`major_id` ASC) ,
  INDEX `fk_major_advisor_idx` (`major_advisor` ASC) ,
  CONSTRAINT `fk_address_id`
    FOREIGN KEY (`address_id` )
    REFERENCES `student_data`.`address` (`address_id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_major_id`
    FOREIGN KEY (`major_id` )
    REFERENCES `student_data`.`major` (`major_id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_major_advisor`
    FOREIGN KEY (`major_advisor` )
    REFERENCES `student_data`.`major_advisor` (`advisor_id` )
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `student`(`student_id`, `first_name`, `last_name`, `address_id`, `major_id`, `major_advisor`)
 VALUES ('1', 'Joe', 'Smith', '1', '1', '1'),
('2', 'Sue', 'Brown', '2', '2', '2'), 
('3','Nick', 'Green', '3', '3', '2'), 
('4', 'Andy', 'Andrew', '4', '2', '2'), 
('5', 'Kate', 'Jones', '5', '1', '1');

-- -----------------------------------------------------
-- Table `student_data`.`class`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `student_data`.`class` (
  `class_id` INT NOT NULL AUTO_INCREMENT ,
  `class_code` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`class_id`) )
ENGINE = InnoDB;

INSERT INTO `class`(`class_id`, `class_code`) VALUES ('1', 'IT1025'),('2', 'ENG1010'), ('3','IT1090'), ('4', 'IT1050'), ('5', 'IT2351'), ('6', 'IT1150'), ('7', 'ITN2300');


-- -----------------------------------------------------
-- Table `student_data`.`class_student`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `student_data`.`class_student` (
  `class_id` INT NOT NULL ,
  `student_id` INT NOT NULL ,
  INDEX `fk_class_id_idx` (`class_id` ASC) ,
  INDEX `fk_student_id_idx` (`student_id` ASC) ,
  CONSTRAINT `fk_class_id`
    FOREIGN KEY (`class_id` )
    REFERENCES `student_data`.`class` (`class_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_id`
    FOREIGN KEY (`student_id` )
    REFERENCES `student_data`.`student` (`student_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO `class_student`(`class_id`, `student_id`) VALUES 
('1', '4'), ('1', '1'), ('2', '2'), ('3', '1'), ('4', '5'),
('1', '5'),('5', '2'),('5', '3'),('6', '2'), ('7', '2');

USE `student_data` ;

-- -----------------------------------------------------
-- Placeholder table for view `student_data`.`student_major_advisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `student_data`.`student_major_advisor` (`first_name` INT, `last_name` INT, `major_name` INT, `advisor_name` INT);

-- -----------------------------------------------------
-- View `student_data`.`student_major_advisor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `student_data`.`student_major_advisor`;
USE `student_data`;

CREATE OR REPLACE VIEW `student_data`.`student_major_advisor` AS
SELECT 

 `student_data`.`student`.`first_name`,

 `student_data`.`student`.`last_name`, 

 `student_data`.`major`.`major_name`,

 `student_data`.`major_advisor`.`advisor_name`

FROM 

  `student_data`.`student`

JOIN 

  `student_data`.`major`

ON 

  `student_data`.`student`.`major_id`=`student_data`.`major`.`major_id`

JOIN 

  `student_data`.`major_advisor`

ON 

  `student_data`.`student`.`major_advisor`=`student_data`.`major_advisor`.`advisor_id`;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
