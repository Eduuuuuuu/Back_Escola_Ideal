/*********************************************************************************************************
 * Objetivo: Local onde irá ficar todos os EndPoints do projeto final escola ideal. 
 * Nome: Eduardo Vilas Boas
 * Data: 21/05/2024
 * Versão: 1.0.0
 *********************************************************************************************************/

 /*
    Para realizar o acesso a Banco de Dados precisamos instalar algumas bibliotecas:

        - SEQUELIZE     - É uma biblioteca mais antiga
        - PRISMA ORM    - É uma biblioteca mais atual (será utilizado no projeto)
        - FASTFY ORM    - É uma biblioteca mais atual

        para instalar o PRISMA:
            - npm install prisma --save  (Irá realizar a conexão com BD)
            - npm install @prisma/client --save (Irá executar os scripts SQl no BD)

        Após a instalação das bibliotecas, devemos inicializar o prisma no projeto:
            - npx prisma init (Irá inicializar o PRISMA)

        Para reinstalar o prisma e atualizar as dependências:   
            - npm i (Irá atualizar todas as dependências)
            - no package.json caso não queira atualizar todas as dependências basta tirar o "^" do @prisma/client

        Caso troque de máquina e sincronizar o Banco de Dados novamente: 
            - npx prisma generate (Serve para ressincronizar o Banco de Dados)

 */

//Import das bibliotecas do projeto
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')

const app = express()

app.use((request, response, next) => {

    response.header('Access-Control-Allow-Origin', '*')
    response.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')

    app.use(cors())

    next()

})

/*****************************  Import dos arquivos da controller do projeto  ******************************************/
    const controllerMatriculas = require('./controller/controller_matricula.js');
    const controllerProfessores = require('./controller/controller_professores.js');
    const controllerAlunos = require('./controller/controller_alunos.js')
    const controllerResponsaveis = require('./controller/controller_responsaveis.js')
/***********************************************************************************************************************/

////Criando um objeto para controlar a chegada dos dados da requisição em formato JSON
const bodyParserJSON = bodyParser.json();

app.get('/v1/escolaIdeal/matriculas', cors(), async function(request, response) {

    let dadosMatricula = await controllerMatriculas.getListarMatriculas();

    if (dadosMatricula) {
        response.json(dadosMatricula);
        response.status(200);
    } else {
        response.json({message: 'Nenhum registro foi encontrado'});
        response.status(404);
    }
})

app.get('/v1/escolaIdeal/matricula/:id', cors(), async function(request, response) {

    let idMatricula = request.params

    let dadosMatricula = await controllerMatriculas.getBuscarMatricula(idMatricula);

    response.json(dadosMatricula);
    response.status(dadosMatricula.status_code);
})

app.delete('/v1/escolaIdeal/deleteMatricula/:id', cors(), async function(request, response) {

    let idMatricula = request.params.id

    let  dadosMatricula = await controllerMatriculas.setExcluirMatricula(idMatricula);

    response.json(dadosMatricula);
    response.status(dadosMatricula.status_code);
})

app.post('/v1/escolaIdeal/matricula', cors(), bodyParserJSON, async function(request, response) {

    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let resultDadosNovaMatricula = await controllerMatriculas.setInserirNovaMatricula(dadosBody, contentType);

    response.json(resultDadosNovaMatricula);
    response.status(resultDadosNovaMatricula.status_code);
})

app.put('/v1/escolaIdeal/updateMatricula/:id', cors(), bodyParserJSON, async function(request, response) {

    let contentType = request.headers['content-type']

    let dadosBody = request.body
    
    let idMatricula = request.params.id

    let resultDadosNovaMatricula = await controllerMatriculas.setAtualizarMatricula(idMatricula, dadosBody, contentType);

    response.json(resultDadosNovaMatricula)
    response.status(resultDadosNovaMatricula.status_code)
})

/**************************************************** ENDPOINTS PROFESSORES ****************************************************/

app.get('/v1/escolaIdeal/professores', cors(), async function(request, response) {
    
    let dadosProfessor = await controllerProfessores.getListarProfessores();

    if (dadosProfessor) {
        response.json(dadosProfessor);
        response.status(200);
    } else {
        response.json({message: 'Nenhum registro foi encontrado'});
        response.status(404);
    }
})

app.get('/v1/escolaIdeal/professor/:id', cors(), async function(request, response) {

    let idProfessor = request.params

    let dadosProfessor = await controllerProfessores.getBuscarProfessor(idProfessor);

    response.json(dadosProfessor);
    response.status(dadosProfessor.status_code);
})

app.delete('/v1/escolaIdeal/deleteProfessor/:id', cors(), async function(request, response) {

    let idProfessor = request.params.id

    let  dadosProfessor = await controllerProfessores.setExcluirProfessor(idProfessor);

    response.json(dadosProfessor);
    response.status(dadosProfessor.status_code);
})

app.post('/v1/escolaIdeal/professor', cors(), bodyParserJSON, async function(request, response) {

    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let resultDadosNovoProfessor = await controllerProfessores.setInserirNovoProfessor(dadosBody, contentType);

    response.json(resultDadosNovoProfessor);
    response.status(resultDadosNovoProfessor.status_code);
})

app.put('/v1/escolaIdeal/updateProfessor/:id', cors(), bodyParserJSON, async function(request, response) {

    let contentType = request.headers['content-type']

    let dadosBody = request.body
    
    let idProfessor = request.params.id

    let resultDadosNovoProfessor = await controllerProfessores.setAtualizarProfessor(idProfessor, dadosBody, contentType);

    response.json(resultDadosNovoProfessor)
    response.status(resultDadosNovoProfessor.status_code)
})

/**************************************************** ENDPOINTS ALUNOS ****************************************************/

app.get('/v1/escolaideal/alunos', cors(), async function(request, response) {
    
    let dadosAlunos = await controllerAlunos.getListarAlunos()
    
    response.status(dadosAlunos.status_code)
    response.json(dadosAlunos)
})

app.get('/v1/escolaideal/aluno/:id', cors(), async function(request, response) {
    
    let idAluno = request.params.id
    
    let dadosAluno = await controllerAlunos.getBuscarAlunoPeloID(idAluno)
    
    response.status(dadosAluno.status_code)
    response.json(dadosAluno)
})

app.get('/v1/escolaideal/alunos/turma/:id', cors(), async function(request, response) {
    
    let idTurma = request.params.id
    
    let dadosAluno = await controllerAlunos.getBuscarAlunosPelaTurma(idTurma)
    
    response.status(dadosAluno.status_code)
    response.json(dadosAluno)
})

app.post('/v1/escolaideal/aluno/insert',cors(), bodyParserJSON, async function(request, response) {
    
    let contentType = request.headers['content-type']
    
    let dadosBody = request.body
    
    let resultDadosNovoAluno = await controllerAlunos.setInserirNovoAluno(dadosBody, contentType)
    
    response.status(resultDadosNovoAluno.status_code)
    response.json(resultDadosNovoAluno)
})

app.put('/v1/escolaideal/aluno/update/:id', cors(), bodyParserJSON, async function(request, response) {
    
    let idAluno = request.params.id

    let contentType = request.headers['content-type']

    let dadosBody = request.body
    
    let resultDadosAlunoAtualizado = await controllerAlunos.setAtualizarAluno(idAluno, dadosBody, contentType)
    
    response.status(resultDadosAlunoAtualizado.status_code)
    response.json(resultDadosAlunoAtualizado)
})

app.delete('/v1/escolaideal/aluno/delete/:id', cors(), async function(request, response) {

    let idAluno = request.params.id

    let resultAlunoDeletado = await controllerAlunos.setDeletarAluno(idAluno)
    
    response.status(resultAlunoDeletado.status_code)
    response.json(resultAlunoDeletado)
})

/**************************************************** ENDPOINTS RESPONSAVEIS ****************************************************/

app.get('/v1/escolaideal/responsaveis', cors(), async function(request, response) {
    
    let dadosResponsaveis = await controllerResponsaveis.getListarResponsaveis()
    
    response.status(dadosResponsaveis.status_code)
    response.json(dadosResponsaveis)
})

app.post('/v1/escolaideal/responsavel/insert', cors(), bodyParserJSON, async function(request, response) {
    
    let contentType = request.headers['content-type']
    
    let dadosBody = request.body
    
    let resultDadosNovoAluno = await controllerResponsaveis.setInserirNovoResponsavel(dadosBody, contentType)
    
    response.status(resultDadosNovoAluno.status_code)
    response.json(resultDadosNovoAluno)
})

app.listen('8080', function() {
    console.log('API Funcionando!!')
})