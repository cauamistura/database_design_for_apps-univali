-- Apresentação do código SQL com a criação do Banco de Dados, e as suas tabelas, de todo o projeto

CREATE SCHEMA IF NOT EXISTS `LocadoraDB` DEFAULT CHARACTER SET utf8 ;
USE `LocadoraDB` ;

-- -----------------------------------------------------
-- Table `LocadoraDB`.`Marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LocadoraDB`.`Marcas` (
  `codigo` INT NOT NULL auto_increment,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`));

-- -----------------------------------------------------
-- Table `LocadoraDB`.`Modelos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LocadoraDB`.`Modelos` (
  `codigo` INT NOT NULL auto_increment,
  `codigo_marca` INT NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Modelos_Marcas_idx` (`codigo_marca` ASC) ,
  CONSTRAINT `fk_Modelos_Marcas`
    FOREIGN KEY (`codigo_marca`)
    REFERENCES `LocadoraDB`.`Marcas` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `LocadoraDB`.`Carros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LocadoraDB`.`Carros` (
  `codigo` INT NOT NULL auto_increment,
  `ano` INT NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `observacao` VARCHAR(45) NULL,
  `codigo_modelo` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Carros_Modelos1_idx` (`codigo_modelo` ASC) ,
  CONSTRAINT `fk_Carros_Modelos1`
    FOREIGN KEY (`codigo_modelo`)
    REFERENCES `LocadoraDB`.`Modelos` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `LocadoraDB`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LocadoraDB`.`Clientes` (
  `codigo` INT NOT NULL auto_increment,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`codigo`));

-- -----------------------------------------------------
-- Table `LocadoraDB`.`Locacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LocadoraDB`.`Locacao` (
  `codigo` INT NOT NULL auto_increment,
  `data_retirada` DATETIME NOT NULL,
  `data_devolucao` DATETIME NULL,
  `valor` FLOAT NULL,
  `observacao` VARCHAR(100) NULL,
  `codigo_carro` INT NOT NULL,
  `codigo_cliente` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Locacao_Carros1_idx` (`codigo_carro` ASC) ,
  INDEX `fk_Locacao_Clientes1_idx` (`codigo_cliente` ASC) ,
  CONSTRAINT `fk_Locacao_Carros1`
    FOREIGN KEY (`codigo_carro`)
    REFERENCES `LocadoraDB`.`Carros` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locacao_Clientes1`
    FOREIGN KEY (`codigo_cliente`)
    REFERENCES `LocadoraDB`.`Clientes` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
