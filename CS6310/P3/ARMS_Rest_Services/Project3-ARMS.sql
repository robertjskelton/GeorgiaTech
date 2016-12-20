-- MySQL Script generated by MySQL Workbench
-- Tue Jul 19 20:08:49 2016
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ARMS_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ARMS_DB` ;

-- -----------------------------------------------------
-- Schema ARMS_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ARMS_DB` DEFAULT CHARACTER SET utf8 ;
USE `ARMS_DB` ;

-- -----------------------------------------------------
-- Table `ARMS_DB`.`University`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ARMS_DB`.`University` ;

CREATE TABLE IF NOT EXISTS `ARMS_DB`.`University` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ARMS_DB`.`Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ARMS_DB`.`Courses` ;

CREATE TABLE IF NOT EXISTS `ARMS_DB`.`Courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(256) NULL,
  `availableTerms` VARCHAR(45) NULL,
  `enrollmentLimit` INT NULL,
  `creationDate` TIMESTAMP NOT NULL DEFAULT now(),
  `University_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Courses_University1_idx` (`University_id` ASC),
  CONSTRAINT `fk_Courses_University1`
    FOREIGN KEY (`University_id`)
    REFERENCES `ARMS_DB`.`University` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ARMS_DB`.`Students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ARMS_DB`.`Students` ;

CREATE TABLE IF NOT EXISTS `ARMS_DB`.`Students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `studentId` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `enrollmentDate` TIMESTAMP NULL,
  `creationDate` TIMESTAMP NULL DEFAULT now(),
  `University_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Students_University1_idx` (`University_id` ASC),
  CONSTRAINT `fk_Students_University1`
    FOREIGN KEY (`University_id`)
    REFERENCES `ARMS_DB`.`University` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ARMS_DB`.`ScheduleRequests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ARMS_DB`.`ScheduleRequests` ;

CREATE TABLE IF NOT EXISTS `ARMS_DB`.`ScheduleRequests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Students_id` INT NOT NULL,
  `addedByAdmin` BOOL NULL DEFAULT false,
  `creationDate` TIMESTAMP NULL DEFAULT now(),
  PRIMARY KEY (`id`),
  INDEX `fk_ScheduleRequests_Students1_idx` (`Students_id` ASC),
  CONSTRAINT `fk_ScheduleRequests_Students1`
    FOREIGN KEY (`Students_id`)
    REFERENCES `ARMS_DB`.`Students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ARMS_DB`.`ScheduleRequests_has_Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ARMS_DB`.`ScheduleRequests_has_Courses` ;

CREATE TABLE IF NOT EXISTS `ARMS_DB`.`ScheduleRequests_has_Courses` (
  `ScheduleRequests_id` INT NOT NULL,
  `Courses_id` INT NOT NULL,
  `idTermAvailable` INT NULL,
  `TermAvailableText` VARCHAR(45) NULL,
  PRIMARY KEY (`ScheduleRequests_id`, `Courses_id`),
  INDEX `fk_ScheduleRequests_has_Courses_Courses1_idx` (`Courses_id` ASC),
  INDEX `fk_ScheduleRequests_has_Courses_ScheduleRequests1_idx` (`ScheduleRequests_id` ASC),
  CONSTRAINT `fk_ScheduleRequests_has_Courses_ScheduleRequests1`
    FOREIGN KEY (`ScheduleRequests_id`)
    REFERENCES `ARMS_DB`.`ScheduleRequests` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ScheduleRequests_has_Courses_Courses1`
    FOREIGN KEY (`Courses_id`)
    REFERENCES `ARMS_DB`.`Courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ARMS_DB`.`Prerequisites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ARMS_DB`.`Prerequisites` ;

CREATE TABLE IF NOT EXISTS `ARMS_DB`.`Prerequisites` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `MainId` INT NOT NULL,
  `PrerequisiteId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prerequisites_Courses1_idx` (`MainId` ASC),
  CONSTRAINT `fk_Prerequisites_Courses1`
    FOREIGN KEY (`MainId`)
    REFERENCES `ARMS_DB`.`Courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
