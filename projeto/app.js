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

app.listen('8080', function() {
    console.log('API Funcionando!!')
})