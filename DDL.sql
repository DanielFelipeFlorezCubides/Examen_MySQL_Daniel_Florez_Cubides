-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `metodo_pago` ENUM("Tarjeta credito", "Efectivo", "Nequi") NOT NULL,
  `Clientes_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Clientes_id`),
  INDEX `fk_Pedido_Clientes_idx` (`Clientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Clientes`
    FOREIGN KEY (`Clientes_id`)
    REFERENCES `Pizzeria`.`Clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `precio` INT NOT NULL,
  `categoria` ENUM("Pizza", "Panzerotti", "Bebidas", "Postres") NOT NULL,
  `elaborado` ENUM("si", "no") NOT NULL,
  `disponible` ENUM("si", "no") NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Combo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Combo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `descripcion` VARCHAR(150) NULL,
  `precio` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Adicionales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Adicionales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `precio` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Ingredientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `cantidad` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Producto_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Producto_Pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Producto_id` INT NOT NULL,
  `Pedido_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`, `Producto_id`, `Pedido_id`),
  INDEX `fk_Producto_has_Pedido_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  INDEX `fk_Producto_has_Pedido_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_has_Pedido_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `Pizzeria`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `Pizzeria`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Adicionales_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Adicionales_Pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Adicionales_id` INT NOT NULL,
  `Pedido_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`, `Adicionales_id`, `Pedido_id`),
  INDEX `fk_Adicionales_has_Pedido_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  INDEX `fk_Adicionales_has_Pedido_Adicionales1_idx` (`Adicionales_id` ASC) VISIBLE,
  CONSTRAINT `fk_Adicionales_has_Pedido_Adicionales1`
    FOREIGN KEY (`Adicionales_id`)
    REFERENCES `Pizzeria`.`Adicionales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Adicionales_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `Pizzeria`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Combo_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Combo_Producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Combo_id` INT NOT NULL,
  `Producto_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`, `Combo_id`, `Producto_id`),
  INDEX `fk_Combo_has_Producto_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  INDEX `fk_Combo_has_Producto_Combo1_idx` (`Combo_id` ASC) VISIBLE,
  CONSTRAINT `fk_Combo_has_Producto_Combo1`
    FOREIGN KEY (`Combo_id`)
    REFERENCES `Pizzeria`.`Combo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Combo_has_Producto_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `Pizzeria`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Combo_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Combo_Pedido` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Combo_id` INT NOT NULL,
  `Pedido_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`id`, `Combo_id`, `Pedido_id`),
  INDEX `fk_Combo_has_Pedido_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
  INDEX `fk_Combo_has_Pedido_Combo1_idx` (`Combo_id` ASC) VISIBLE,
  CONSTRAINT `fk_Combo_has_Pedido_Combo1`
    FOREIGN KEY (`Combo_id`)
    REFERENCES `Pizzeria`.`Combo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Combo_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_id`)
    REFERENCES `Pizzeria`.`Pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Ingredientes_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Ingredientes_Producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Ingredientes_id` INT NOT NULL,
  `Producto_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Ingredientes_id`, `Producto_id`),
  INDEX `fk_Ingredientes_has_Producto_Producto1_idx` (`Producto_id` ASC) VISIBLE,
  INDEX `fk_Ingredientes_has_Producto_Ingredientes1_idx` (`Ingredientes_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ingredientes_has_Producto_Ingredientes1`
    FOREIGN KEY (`Ingredientes_id`)
    REFERENCES `Pizzeria`.`Ingredientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredientes_has_Producto_Producto1`
    FOREIGN KEY (`Producto_id`)
    REFERENCES `Pizzeria`.`Producto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;