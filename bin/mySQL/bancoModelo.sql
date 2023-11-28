-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema meuMonitor
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema meuMonitor
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `meuMonitor` DEFAULT CHARACTER SET utf8 ;
USE `meuMonitor` ;

-- -----------------------------------------------------
-- Table `meuMonitor`.`Cadeira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Cadeira` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `duracao` INT NOT NULL,
  `turno` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Centro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Centro` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `turno` VARCHAR(2) NOT NULL,
  `duracao` INT NOT NULL,
  `Centro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Curso_Centro_idx` (`Centro_id` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Centro`
    FOREIGN KEY (`Centro_id`)
    REFERENCES `meuMonitor`.`Centro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Curso_Cadeira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Curso_Cadeira` (
  `Cadeira_id` INT NOT NULL,
  `Curso_id` INT NOT NULL,
  PRIMARY KEY (`Cadeira_id`, `Curso_id`),
  INDEX `fk_Cadeira_has_Curso_Curso1_idx` (`Curso_id` ASC) VISIBLE,
  INDEX `fk_Cadeira_has_Curso_Cadeira1_idx` (`Cadeira_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cadeira_has_Curso_Cadeira1`
    FOREIGN KEY (`Cadeira_id`)
    REFERENCES `meuMonitor`.`Cadeira` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cadeira_has_Curso_Curso1`
    FOREIGN KEY (`Curso_id`)
    REFERENCES `meuMonitor`.`Curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `matricula` INT(7) NOT NULL,
  `senha` INT(8) NOT NULL,
  `is_monitor` TINYINT NOT NULL,
  `Curso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Aluno_Curso1_idx` (`Curso_id` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_Curso1`
    FOREIGN KEY (`Curso_id`)
    REFERENCES `meuMonitor`.`Curso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Cadeira_Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Cadeira_Aluno` (
  `Aluno_id` INT NOT NULL,
  `Cadeira_id` INT NOT NULL,
  PRIMARY KEY (`Aluno_id`, `Cadeira_id`),
  INDEX `fk_Aluno_has_Cadeira_Cadeira1_idx` (`Cadeira_id` ASC) VISIBLE,
  INDEX `fk_Aluno_has_Cadeira_Aluno1_idx` (`Aluno_id` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_has_Cadeira_Aluno1`
    FOREIGN KEY (`Aluno_id`)
    REFERENCES `meuMonitor`.`Aluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aluno_has_Cadeira_Cadeira1`
    FOREIGN KEY (`Cadeira_id`)
    REFERENCES `meuMonitor`.`Cadeira` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Admnistrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Admnistrador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `matricula` INT(7) NOT NULL,
  `senha` INT(8) NOT NULL,
  `Centro_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Admnistrador_Centro1_idx` (`Centro_id` ASC) VISIBLE,
  CONSTRAINT `fk_Admnistrador_Centro1`
    FOREIGN KEY (`Centro_id`)
    REFERENCES `meuMonitor`.`Centro` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `turno` VARCHAR(2) NOT NULL,
  `Cadeira_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Grupo_Estudo_Cadeira1_idx` (`Cadeira_id` ASC) VISIBLE,
  CONSTRAINT `fk_Grupo_Estudo_Cadeira1`
    FOREIGN KEY (`Cadeira_id`)
    REFERENCES `meuMonitor`.`Cadeira` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meuMonitor`.`Grupo_Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meuMonitor`.`Grupo_Aluno` (
  `Grupo_id` INT NOT NULL,
  `Aluno_id` INT NOT NULL,
  PRIMARY KEY (`Grupo_id`, `Aluno_id`),
  INDEX `fk_Grupo_Estudo_has_Aluno_Aluno1_idx` (`Aluno_id` ASC) VISIBLE,
  INDEX `fk_Grupo_Estudo_has_Aluno_Grupo_Estudo1_idx` (`Grupo_id` ASC) VISIBLE,
  CONSTRAINT `fk_Grupo_Estudo_has_Aluno_Grupo_Estudo1`
    FOREIGN KEY (`Grupo_id`)
    REFERENCES `meuMonitor`.`Grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Grupo_Estudo_has_Aluno_Aluno1`
    FOREIGN KEY (`Aluno_id`)
    REFERENCES `meuMonitor`.`Aluno` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
