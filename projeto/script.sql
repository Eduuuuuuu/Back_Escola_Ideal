-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema db_escola_ideal
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_escola_ideal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_escola_ideal` DEFAULT CHARACTER SET utf8 ;
USE `db_escola_ideal` ;

-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_administrador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(15) NOT NULL,
  `senha` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_sexo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(12) NOT NULL,
  `sigla` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

insert into tbl_sexo (nome, sigla) values ("Masculino", "M"), ("Feminino", "F");

-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_alunos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `foto` VARCHAR(300) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `id_sexo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_alunos_tbl_sexo1_idx` (`id_sexo` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_alunos_tbl_sexo1`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `db_escola_ideal`.`tbl_sexo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

insert into tbl_alunos (nome, data_nascimento, email, foto, cpf, id_sexo) values 
(
	"Antonio Meira",
    "2004-05-22",
    "antonio@meira.com",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0D1iGENjSwikmQPCEgt4lLN-8ChYuDu1JQg&s",
    "12350909012",
    "1"
),(
	"João Silva Pinto",
    "2005-03-14",
    "joaosilva@gmail.com",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0D1iGENjSwikmQPCEgt4lLN-8ChYuDu1JQg&s",
    "12350908412",
    "1"
),(
	"Valentina Lopez Batista",
    "2006-12-02",
    "valentina123@gmail.com",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROMwnAqX6pnPbDYO8t9QiEeAAbclqUQof7bg&s",
    "12350905929",
    "2"
);

-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_comunicados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_comunicados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `assunto` VARCHAR(150) NOT NULL,
  `data` DATE NOT NULL,
  `mensagem` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_professores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `id_sexo` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tbl_professores_tbl_sexo1`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `db_escola_ideal`.`tbl_sexo` (`id`)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

insert into tbl_professores (nome, data_nascimento, telefone, id_sexo) values 
(
	"Rosita Alves",
    "1984-12-01",
    "11920190123",
    "2"
);

-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_disciplinas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_disciplinas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(44) NOT NULL,
  `carga_horaria` VARCHAR(2) NOT NULL,
  `id_professor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_disciplinas_tbl_professores1_idx` (`id_professor` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_disciplinas_tbl_professores1`
    FOREIGN KEY (`id_professor`)
    REFERENCES `db_escola_ideal`.`tbl_professores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cep` INT NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `número` DECIMAL NOT NULL,
  `bairro` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_endereco_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_endereco_aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_endereco` INT NOT NULL,
  `id_aluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_ENDERECO_ENDERECOALUNO` (`id_endereco` ASC) VISIBLE,
  INDEX `fk_tbl_endereco_aluno_tbl_alunos1_idx` (`id_aluno` ASC) VISIBLE,
  CONSTRAINT `FK_ENDERECO_ENDERECOALUNO`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `db_escola_ideal`.`tbl_enderecos` (`id`),
  CONSTRAINT `fk_tbl_endereco_aluno_tbl_alunos1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `db_escola_ideal`.`tbl_alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_matriculas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_matriculas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NOT NULL,
  `id_aluno` INT NOT NULL,
  `data_fim` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_matriculas_tbl_alunos1_idx` (`id_aluno` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_matriculas_tbl_alunos1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `db_escola_ideal`.`tbl_alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into tbl_matriculas (data_inicio, id_aluno, data_fim) values ("2023-01-28", "1", null);

-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_frequencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_frequencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `status` TINYINT NOT NULL,
  `id_matricula` INT NOT NULL,
  `id_disciplina` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_frequencia_tbl_matriculas1_idx` (`id_matricula` ASC) VISIBLE,
  INDEX `fk_tbl_frequencia_tbl_disciplinas1_idx` (`id_disciplina` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_frequencia_tbl_matriculas1`
    FOREIGN KEY (`id_matricula`)
    REFERENCES `db_escola_ideal`.`tbl_matriculas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_frequencia_tbl_disciplinas1`
    FOREIGN KEY (`id_disciplina`)
    REFERENCES `db_escola_ideal`.`tbl_disciplinas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_notas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nota` VARCHAR(3) NOT NULL,
  `semestre` VARCHAR(1) NOT NULL,
  `id_matricula` INT NOT NULL,
  `id_disciplina` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_notas_tbl_matriculas1_idx` (`id_matricula` ASC) VISIBLE,
  INDEX `fk_tbl_notas_tbl_disciplinas1_idx` (`id_disciplina` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_notas_tbl_matriculas1`
    FOREIGN KEY (`id_matricula`)
    REFERENCES `db_escola_ideal`.`tbl_matriculas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_notas_tbl_disciplinas1`
    FOREIGN KEY (`id_disciplina`)
    REFERENCES `db_escola_ideal`.`tbl_disciplinas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_responsaveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_responsaveis` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `id_endereco` INT NOT NULL,
  `id_sexo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_responsaveis_tbl_enderecos1_idx` (`id_endereco` ASC) VISIBLE,
  INDEX `fk_tbl_responsaveis_tbl_sexo1_idx` (`id_sexo` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_responsaveis_tbl_enderecos1`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `db_escola_ideal`.`tbl_enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_responsaveis_tbl_sexo1`
    FOREIGN KEY (`id_sexo`)
    REFERENCES `db_escola_ideal`.`tbl_sexo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_responsavel_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_responsavel_aluno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_responsavel` INT NOT NULL,
  `id_aluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_RESPONSAVEL_RESPONSAVELALUNO` (`id_responsavel` ASC) VISIBLE,
  INDEX `fk_tbl_responsavel_aluno_tbl_alunos1_idx` (`id_aluno` ASC) VISIBLE,
  CONSTRAINT `FK_RESPONSAVEL_RESPONSAVELALUNO`
    FOREIGN KEY (`id_responsavel`)
    REFERENCES `db_escola_ideal`.`tbl_responsaveis` (`id`),
  CONSTRAINT `fk_tbl_responsavel_aluno_tbl_alunos1`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `db_escola_ideal`.`tbl_alunos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_turmas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

insert into tbl_turmas (nome) values ("1º ANO"), ("2º ANO"), ("3º ANO");

-- -----------------------------------------------------
-- Table `db_escola_ideal`.`tbl_matricula_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_escola_ideal`.`tbl_matricula_turma` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_matricula` INT NOT NULL,
  `id_turma` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_matricula_turma_tbl_matriculas1_idx` (`id_matricula` ASC) VISIBLE,
  INDEX `fk_tbl_matricula_turma_tbl_turmas1_idx` (`id_turma` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_matricula_turma_tbl_matriculas1`
    FOREIGN KEY (`id_matricula`)
    REFERENCES `db_escola_ideal`.`tbl_matriculas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_matricula_turma_tbl_turmas1`
    FOREIGN KEY (`id_turma`)
    REFERENCES `db_escola_ideal`.`tbl_turmas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into tbl_matricula_turma (id_matricula, id_turma, data) values ("1", "3", "2024-06-04"), ("3", "1", "2013-09-30"), ("2", "2", "2009-07-04");

-- ALTER TABLE tbl_disciplinas
-- ADD FOREIGN KEY fk_tbl_disciplinas_tbl_professores1;

ALTER TABLE tbl_disciplinas
ADD CONSTRAINT fk_tbl_disciplinas_tbl_professores1 FOREIGN KEY (id_professor)
REFERENCES tbl_professores(id);

drop table tbl_professores;

select * from tbl_alunos;

select * from tbl_matriculas;

select * from tbl_turmas;

select * from tbl_matricula_turma;

select tbl_matriculas.id, data_inicio, id_aluno, data_fim
from tbl_matriculas
join tbl_matricula_turma on tbl_matriculas.id = tbl_matricula_turma.id_matricula
where tbl_matricula_turma.id_matricula = 2;

select m.id as matricula, t.nome as turma, m.data_inicio, m.data_fim from tbl_matricula_turma as i
join tbl_matriculas as m on m.id=i.id_matricula
join tbl_turmas as t on t.id=i.id_turma;

SELECT tbl_turmas.id, nome
FROM tbl_matricula_turma
JOIN tbl_turmas ON tbl_matricula_turma.id_turma = tbl_turmas.id
WHERE tbl_matricula_turma.id_matricula = 5;


select m.id as matricula, t.nome as turma, m.data_inicio, m.data_fim from tbl_matricula_turma as i
        join tbl_matriculas as m on m.id = i.id_matricula
        join tbl_turmas as t on t.id = i.id_turma
        where i.id_turma = 1;

update tbl_matriculas set data_inicio = "2025-03-17", id_aluno = "3", data_fim = null where id = 5;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
