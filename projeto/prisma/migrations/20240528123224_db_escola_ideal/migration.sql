-- CreateTable
CREATE TABLE `tbl_administrador` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `login` VARCHAR(15) NOT NULL,
    `senha` VARCHAR(20) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_alunos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `data_nascimento` DATE NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `foto` VARCHAR(300) NOT NULL,
    `cpf` VARCHAR(11) NOT NULL,
    `id_sexo` INTEGER NOT NULL,

    INDEX `fk_tbl_alunos_tbl_sexo1_idx`(`id_sexo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_comunicados` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `assunto` VARCHAR(150) NOT NULL,
    `data` DATE NOT NULL,
    `mensagem` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_disciplinas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(44) NOT NULL,
    `carga_horaria` VARCHAR(2) NOT NULL,
    `id_professor` INTEGER NOT NULL,

    INDEX `fk_tbl_disciplinas_tbl_professores1_idx`(`id_professor`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_endereco_aluno` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_endereco` INTEGER NOT NULL,
    `id_aluno` INTEGER NOT NULL,

    INDEX `FK_ENDERECO_ENDERECOALUNO`(`id_endereco`),
    INDEX `fk_tbl_endereco_aluno_tbl_alunos1_idx`(`id_aluno`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_enderecos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cep` INTEGER NOT NULL,
    `logradouro` VARCHAR(100) NOT NULL,
    `número` DECIMAL(10, 0) NOT NULL,
    `bairro` VARCHAR(100) NOT NULL,
    `cidade` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_frequencia` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `data` DATE NOT NULL,
    `status` TINYINT NOT NULL,
    `id_matricula` INTEGER NOT NULL,
    `id_disciplina` INTEGER NOT NULL,

    INDEX `fk_tbl_frequencia_tbl_disciplinas1_idx`(`id_disciplina`),
    INDEX `fk_tbl_frequencia_tbl_matriculas1_idx`(`id_matricula`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_matricula_turma` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_matricula` INTEGER NOT NULL,
    `id_turma` INTEGER NOT NULL,
    `data` DATE NOT NULL,

    INDEX `fk_tbl_matricula_turma_tbl_matriculas1_idx`(`id_matricula`),
    INDEX `fk_tbl_matricula_turma_tbl_turmas1_idx`(`id_turma`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_matriculas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `data_inicio` DATE NOT NULL,
    `id_aluno` INTEGER NOT NULL,
    `data_fim` DATE NULL,

    INDEX `fk_tbl_matriculas_tbl_alunos1_idx`(`id_aluno`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_notas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nota` VARCHAR(3) NOT NULL,
    `semestre` VARCHAR(1) NOT NULL,
    `id_matricula` INTEGER NOT NULL,
    `id_disciplina` INTEGER NOT NULL,

    INDEX `fk_tbl_notas_tbl_disciplinas1_idx`(`id_disciplina`),
    INDEX `fk_tbl_notas_tbl_matriculas1_idx`(`id_matricula`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_professores` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `data_nascimento` DATE NOT NULL,
    `telefone` VARCHAR(11) NOT NULL,
    `id_sexo` INTEGER NOT NULL,

    INDEX `fk_tbl_professores_tbl_sexo1`(`id_sexo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_responsaveis` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `data_nascimento` DATE NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `cpf` VARCHAR(11) NOT NULL,
    `telefone` VARCHAR(11) NOT NULL,
    `id_endereco` INTEGER NOT NULL,
    `id_sexo` INTEGER NOT NULL,

    INDEX `fk_tbl_responsaveis_tbl_enderecos1_idx`(`id_endereco`),
    INDEX `fk_tbl_responsaveis_tbl_sexo1_idx`(`id_sexo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_responsavel_aluno` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_responsavel` INTEGER NOT NULL,
    `id_aluno` INTEGER NOT NULL,

    INDEX `FK_RESPONSAVEL_RESPONSAVELALUNO`(`id_responsavel`),
    INDEX `fk_tbl_responsavel_aluno_tbl_alunos1_idx`(`id_aluno`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_sexo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(12) NOT NULL,
    `sigla` VARCHAR(1) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tbl_turmas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(6) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `tbl_alunos` ADD CONSTRAINT `fk_tbl_alunos_tbl_sexo1` FOREIGN KEY (`id_sexo`) REFERENCES `tbl_sexo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_disciplinas` ADD CONSTRAINT `fk_tbl_disciplinas_tbl_professores1` FOREIGN KEY (`id_professor`) REFERENCES `tbl_professores`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_endereco_aluno` ADD CONSTRAINT `FK_ENDERECO_ENDERECOALUNO` FOREIGN KEY (`id_endereco`) REFERENCES `tbl_enderecos`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_endereco_aluno` ADD CONSTRAINT `fk_tbl_endereco_aluno_tbl_alunos1` FOREIGN KEY (`id_aluno`) REFERENCES `tbl_alunos`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_frequencia` ADD CONSTRAINT `fk_tbl_frequencia_tbl_disciplinas1` FOREIGN KEY (`id_disciplina`) REFERENCES `tbl_disciplinas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_frequencia` ADD CONSTRAINT `fk_tbl_frequencia_tbl_matriculas1` FOREIGN KEY (`id_matricula`) REFERENCES `tbl_matriculas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_matricula_turma` ADD CONSTRAINT `fk_tbl_matricula_turma_tbl_matriculas1` FOREIGN KEY (`id_matricula`) REFERENCES `tbl_matriculas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_matricula_turma` ADD CONSTRAINT `fk_tbl_matricula_turma_tbl_turmas1` FOREIGN KEY (`id_turma`) REFERENCES `tbl_turmas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_matriculas` ADD CONSTRAINT `fk_tbl_matriculas_tbl_alunos1` FOREIGN KEY (`id_aluno`) REFERENCES `tbl_alunos`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_notas` ADD CONSTRAINT `fk_tbl_notas_tbl_disciplinas1` FOREIGN KEY (`id_disciplina`) REFERENCES `tbl_disciplinas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_notas` ADD CONSTRAINT `fk_tbl_notas_tbl_matriculas1` FOREIGN KEY (`id_matricula`) REFERENCES `tbl_matriculas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_professores` ADD CONSTRAINT `fk_tbl_professores_tbl_sexo1` FOREIGN KEY (`id_sexo`) REFERENCES `tbl_sexo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_responsaveis` ADD CONSTRAINT `fk_tbl_responsaveis_tbl_enderecos1` FOREIGN KEY (`id_endereco`) REFERENCES `tbl_enderecos`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_responsaveis` ADD CONSTRAINT `fk_tbl_responsaveis_tbl_sexo1` FOREIGN KEY (`id_sexo`) REFERENCES `tbl_sexo`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_responsavel_aluno` ADD CONSTRAINT `FK_RESPONSAVEL_RESPONSAVELALUNO` FOREIGN KEY (`id_responsavel`) REFERENCES `tbl_responsaveis`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tbl_responsavel_aluno` ADD CONSTRAINT `fk_tbl_responsavel_aluno_tbl_alunos1` FOREIGN KEY (`id_aluno`) REFERENCES `tbl_alunos`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
