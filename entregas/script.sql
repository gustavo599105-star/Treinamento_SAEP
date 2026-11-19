-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema saep_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema saep_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `saep_db` DEFAULT CHARACTER SET utf8mb3 ;
USE `saep_db` ;

-- -----------------------------------------------------
-- Table `saep_db`.`responsavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db`.`responsavel` (
  `id_responsavel` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` VARBINARY(30) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_responsavel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `cpf` ON `saep_db`.`responsavel` (`cpf` ASC) VISIBLE;

CREATE UNIQUE INDEX `cpf_unique` ON `saep_db`.`responsavel` (`cpf` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_unique` ON `saep_db`.`responsavel` (`email` ASC) VISIBLE;

CREATE UNIQUE INDEX `telefone_unique` ON `saep_db`.`responsavel` (`telefone` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `saep_db`.`filho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db`.`filho` (
  `id_filho` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `nivel_natacao` ENUM('Iniciante', 'Intermediário', 'Avançado') NOT NULL,
  `responsavel_id_responsavel` INT NOT NULL,
  PRIMARY KEY (`id_filho`, `responsavel_id_responsavel`),
  CONSTRAINT `fk_filho_responsavel`
    FOREIGN KEY (`responsavel_id_responsavel`)
    REFERENCES `saep_db`.`responsavel` (`id_responsavel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_filho_responsavel_idx` ON `saep_db`.`filho` (`responsavel_id_responsavel` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `saep_db`.`aula_agendada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db`.`aula_agendada` (
  `id_aula_agendada` INT NOT NULL,
  `filho` VARCHAR(100) NOT NULL,
  `nome_professor` VARCHAR(100) NOT NULL,
  `data` DATETIME NOT NULL,
  `filho_id_filho` INT NOT NULL,
  `filho_responsavel_id_responsavel` INT NOT NULL,
  PRIMARY KEY (`id_aula_agendada`, `filho_id_filho`, `filho_responsavel_id_responsavel`),
  CONSTRAINT `fk_aula_agendada_filho1`
    FOREIGN KEY (`filho_id_filho` , `filho_responsavel_id_responsavel`)
    REFERENCES `saep_db`.`filho` (`id_filho` , `responsavel_id_responsavel`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_aula_agendada_filho1_idx` ON `saep_db`.`aula_agendada` (`filho_id_filho` ASC, `filho_responsavel_id_responsavel` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `saep_db`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saep_db`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `login_unique` ON `saep_db`.`usuario` (`login` ASC) VISIBLE;

CREATE UNIQUE INDEX `senha_unique` ON `saep_db`.`usuario` (`senha` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- =============================================
-- 1. INSERT NA TABELA RESPONSAVEL
-- =============================================

INSERT INTO responsavel
(id_responsavel, nome, cpf, email, telefone)
VALUES
(1, 'Carlos Eduardo',
 AES_ENCRYPT('111.222.333-44', 'chave123'),
 'carlos@gmail.com', '47999991111'),

(2, 'Mariana Souza',
 AES_ENCRYPT('222.333.444-55', 'chave123'),
 'mariana@gmail.com', '47999992222'),

(3, 'Roberto Almeida',
 AES_ENCRYPT('333.444.555-66', 'chave123'),
 'roberto@gmail.com', '47999993333');


-- =============================================
-- 2. INSERT NA TABELA USUARIO
-- =============================================

INSERT INTO usuario
(id_usuario, nome, login, senha)
VALUES
(1, 'Administrador', 'admin',
 SHA2('admin123', 256)),

(2, 'Atendente', 'atendente',
 SHA2('atendente123', 256)),

(3, 'Professor', 'professor',
 SHA2('professor123', 256));


-- =============================================
-- 3. INSERT NA TABELA FILHO
-- =============================================

INSERT INTO filho
(
    id_filho,
    nome,
    data_nascimento,
    nivel_natacao,
    responsavel_id_responsavel
)
VALUES
(1, 'Pedro Carlos',
 '2015-04-12', 'Iniciante', 1),

(2, 'Ana Mariana',
 '2016-08-25', 'Intermediário', 2),

(3, 'Lucas Roberto',
 '2014-11-03', 'Avançado', 3);


-- =============================================
-- 4. INSERT NA TABELA AULA_AGENDADA
-- =============================================

INSERT INTO aula_agendada
(
    id_aula_agendada,
    filho,
    nome_professor,
    `data`,
    filho_id_filho,
    filho_responsavel_id_responsavel
)
VALUES
(1, 'Pedro Carlos',
 'João Martins', '2026-11-20 09:00:00', 1, 1),

(2, 'Ana Mariana',
 'Fernanda Lima', '2026-11-20 10:00:00', 2, 2),

(3, 'Lucas Roberto',
 'Ricardo Alves', '2026-11-20 11:00:00', 3, 3);