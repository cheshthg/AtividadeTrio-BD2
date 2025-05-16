-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `CPF` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos` (
  `idPedidos` INT NOT NULL,
  `DataPedido` DATE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  `Clientes_CPF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPedidos`, `Clientes_CPF`),
  INDEX `fk_Pedidos_Clientes1_idx` (`Clientes_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`Clientes_CPF`)
    REFERENCES `mydb`.`Clientes` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AreasConhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AreasConhecimento` (
  `idAreaConhecimento` INT(11) NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAreaConhecimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Livros` (
  `ISBN` VARCHAR(13) NOT NULL,
  `DataPublicacao` DATE NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `Genero` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Numero_Paginas` VARCHAR(45) NOT NULL,
  `AreaConhecimento` VARCHAR(45) NOT NULL,
  `AreasConhecimento_idAreaConhecimento` INT(11) NOT NULL,
  PRIMARY KEY (`ISBN`, `AreasConhecimento_idAreaConhecimento`),
  INDEX `fk_Livros_AreasConhecimento1_idx` (`AreasConhecimento_idAreaConhecimento` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_AreasConhecimento1`
    FOREIGN KEY (`AreasConhecimento_idAreaConhecimento`)
    REFERENCES `mydb`.`AreasConhecimento` (`idAreaConhecimento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Exemplares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Exemplares` (
  `NumeroSerie` VARCHAR(13) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Localizacao` VARCHAR(45) NOT NULL,
  `Livros_ISBN1` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`NumeroSerie`, `Livros_ISBN1`),
  INDEX `fk_Exemplares_Livros1_idx` (`Livros_ISBN1` ASC) VISIBLE,
  CONSTRAINT `fk_Exemplares_Livros1`
    FOREIGN KEY (`Livros_ISBN1`)
    REFERENCES `mydb`.`Livros` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ItensPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ItensPedido` (
  `Exemplares_NumeroSerie` VARCHAR(13) NOT NULL,
  `Exemplares_Livros_ISBN1` VARCHAR(13) NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  `Pedidos_Clientes_CPF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Exemplares_NumeroSerie`, `Exemplares_Livros_ISBN1`, `Pedidos_idPedidos`, `Pedidos_Clientes_CPF`),
  INDEX `fk_ItensPedido_Pedidos1_idx` (`Pedidos_idPedidos` ASC, `Pedidos_Clientes_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_ItensPedido_Exemplares1`
    FOREIGN KEY (`Exemplares_NumeroSerie` , `Exemplares_Livros_ISBN1`)
    REFERENCES `mydb`.`Exemplares` (`NumeroSerie` , `Livros_ISBN1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItensPedido_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos` , `Pedidos_Clientes_CPF`)
    REFERENCES `mydb`.`Pedidos` (`idPedidos` , `Clientes_CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Autores` (
  `CPF_Autor` VARCHAR(14) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Biografia` VARCHAR(45) NOT NULL,
  `Nacionalidade` VARCHAR(45) NOT NULL,
  `DataNasc` DATE NOT NULL,
  PRIMARY KEY (`CPF_Autor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LivroAutores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LivroAutores` (
  `Livros_ISBN` VARCHAR(13) NOT NULL,
  `Autores_CPF_Autor` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`Livros_ISBN`, `Autores_CPF_Autor`),
  INDEX `fk_LivroAutores_Livros1_idx` (`Livros_ISBN` ASC) VISIBLE,
  INDEX `fk_LivroAutores_Autores1_idx` (`Autores_CPF_Autor` ASC) VISIBLE,
  CONSTRAINT `fk_LivroAutores_Livros1`
    FOREIGN KEY (`Livros_ISBN`)
    REFERENCES `mydb`.`Livros` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LivroAutores_Autores1`
    FOREIGN KEY (`Autores_CPF_Autor`)
    REFERENCES `mydb`.`Autores` (`CPF_Autor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PalavraChave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PalavraChave` (
  `idPalavraChave` INT(11) NOT NULL,
  `Palavra` VARCHAR(45) NOT NULL,
  `Significado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPalavraChave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LivroPalavras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LivroPalavras` (
  `PalavraChave_idPalavraChave` INT(11) NOT NULL,
  `Livros_ISBN1` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`PalavraChave_idPalavraChave`, `Livros_ISBN1`),
  INDEX `fk_LivroPalavras_PalavraChave1_idx` (`PalavraChave_idPalavraChave` ASC) VISIBLE,
  INDEX `fk_LivroPalavras_Livros1_idx` (`Livros_ISBN1` ASC) VISIBLE,
  CONSTRAINT `fk_LivroPalavras_PalavraChave1`
    FOREIGN KEY (`PalavraChave_idPalavraChave`)
    REFERENCES `mydb`.`PalavraChave` (`idPalavraChave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LivroPalavras_Livros1`
    FOREIGN KEY (`Livros_ISBN1`)
    REFERENCES `mydb`.`Livros` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Funcionarios` (
  `CPF_Func` VARCHAR(14) NOT NULL,
  `NomeFunc` VARCHAR(45) NOT NULL,
  `Sexo` CHAR NOT NULL,
  `dataNasc` DATE NOT NULL,
  `ch` INT(11) NOT NULL,
  `Salario` DECIMAL(7,2) NOT NULL,
  `dataAdm` DATE NOT NULL,
  PRIMARY KEY (`CPF_Func`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Vendas` (
  `idVendas` INT NOT NULL,
  `DataVenda` DATE NOT NULL,
  `Valor` DECIMAL(6,2) NOT NULL,
  `Desconto` DECIMAL(4,2) NOT NULL,
  `Funcionarios_CPF_Func` VARCHAR(14) NULL,
  `Pedidos_idPedidos1` INT NOT NULL,
  PRIMARY KEY (`idVendas`, `Pedidos_idPedidos1`),
  INDEX `fk_Vendas_Funcionarios1_idx` (`Funcionarios_CPF_Func` ASC) VISIBLE,
  INDEX `fk_Vendas_Pedidos1_idx` (`Pedidos_idPedidos1` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Funcionarios1`
    FOREIGN KEY (`Funcionarios_CPF_Func`)
    REFERENCES `mydb`.`Funcionarios` (`CPF_Func`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendas_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos1`)
    REFERENCES `mydb`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`FormaPag` (
  `idFormaPag` INT(11) NOT NULL,
  `ValorPago` DECIMAL(6,2) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Vendas_idVendas` INT NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Vendas1_idx` (`Vendas_idVendas` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Vendas1`
    FOREIGN KEY (`Vendas_idVendas`)
    REFERENCES `mydb`.`Vendas` (`idVendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Departamento` (
  `ID_Departamento` INT(11) NOT NULL,
  `NomeDepartamento` VARCHAR(45) NOT NULL,
  `Descricao_Departamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Departamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EnderecoFunc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EnderecoFunc` (
  `Funcionarios_CPF_Func` VARCHAR(14) NOT NULL,
  `UF` CHAR(2) NOT NULL,
  `Cidade` VARCHAR(60) NOT NULL,
  `Bairro` VARCHAR(60) NOT NULL,
  `Rua` VARCHAR(70) NOT NULL,
  `Numero` VARCHAR(11) NOT NULL,
  `Comp` VARCHAR(45) NOT NULL,
  `CEP` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`Funcionarios_CPF_Func`),
  INDEX `fk_EnderecoFunc_Funcionarios_idx` (`Funcionarios_CPF_Func` ASC) VISIBLE,
  CONSTRAINT `fk_EnderecoFunc_Funcionarios`
    FOREIGN KEY (`Funcionarios_CPF_Func`)
    REFERENCES `mydb`.`Funcionarios` (`CPF_Func`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EnderecoCli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EnderecoCli` (
  `Clientes_CPF` VARCHAR(45) NOT NULL,
  `UF` CHAR(2) NOT NULL,
  `Cidade` VARCHAR(60) NOT NULL,
  `Bairro` VARCHAR(60) NOT NULL,
  `Rua` VARCHAR(70) NOT NULL,
  `Numero` VARCHAR(11) NOT NULL,
  `Comp` VARCHAR(45) NOT NULL,
  `CEP` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`Clientes_CPF`),
  INDEX `fk_EnderecoCli_Clientes1_idx` (`Clientes_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_EnderecoCli_Clientes1`
    FOREIGN KEY (`Clientes_CPF`)
    REFERENCES `mydb`.`Clientes` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trabalhar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trabalhar` (
  `Funcionarios_CPF_Func` VARCHAR(14) NOT NULL,
  `Departamento_ID_Departamento` INT(11) NOT NULL,
  PRIMARY KEY (`Funcionarios_CPF_Func`, `Departamento_ID_Departamento`),
  INDEX `fk_Trabalhar_Departamento1_idx` (`Departamento_ID_Departamento` ASC) VISIBLE,
  CONSTRAINT `fk_Trabalhar_Funcionarios1`
    FOREIGN KEY (`Funcionarios_CPF_Func`)
    REFERENCES `mydb`.`Funcionarios` (`CPF_Func`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trabalhar_Departamento1`
    FOREIGN KEY (`Departamento_ID_Departamento`)
    REFERENCES `mydb`.`Departamento` (`ID_Departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contato` (
  `idContato` INT(11) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Clientes_CPF` VARCHAR(14) NULL,
  `Funcionarios_CPF_Func` VARCHAR(14) NULL,
  `Departamento_ID_Departamento` INT(11) NULL,
  PRIMARY KEY (`idContato`),
  INDEX `fk_Contato_Clientes1_idx` (`Clientes_CPF` ASC) VISIBLE,
  INDEX `fk_Contato_Funcionarios1_idx` (`Funcionarios_CPF_Func` ASC) VISIBLE,
  INDEX `fk_Contato_Departamento1_idx` (`Departamento_ID_Departamento` ASC) VISIBLE,
  CONSTRAINT `fk_Contato_Clientes1`
    FOREIGN KEY (`Clientes_CPF`)
    REFERENCES `mydb`.`Clientes` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contato_Funcionarios1`
    FOREIGN KEY (`Funcionarios_CPF_Func`)
    REFERENCES `mydb`.`Funcionarios` (`CPF_Func`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contato_Departamento1`
    FOREIGN KEY (`Departamento_ID_Departamento`)
    REFERENCES `mydb`.`Departamento` (`ID_Departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;