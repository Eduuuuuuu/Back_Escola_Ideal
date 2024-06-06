const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')

const app = express()

app.use((request, response, next) =>{

    
    response.header('Access-Control-Allow-Origin', '*')

    response.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')

    app.use(cors())


    next()
})

const bodyParserJson = bodyParser.json()

const controllerDisciplinas = require('./controller/controller_disciplinas')
const controllerComunicados = require('./controller/controller.comunicados.js')
const controllerTurmas = require('./controller/controller_turmas.js')
const controllerFrequencia = require('./controller/controller_frequencia.js')
const controllerNotas = require('./controller/controller_notas.js')

/****************************** DISCIPLINAS  ***********************************/


app.get('/v1/escola_ideal/disciplinas', cors(), async function (request, response){
    let dadosDisciplinas = await controllerDisciplinas.getListarDisciplinas()

    if(dadosDisciplinas){
        response.json(dadosDisciplinas)
        response.status(dadosDisciplinas.status_code)
    }else{
        response.json
    }
})

app.delete('/v1/escola_ideal/deleteDisciplina/:id', cors(), async function(request,response){
    let idDisciplina = request.params.id

    let dadosDisciplina = await controllerDisciplinas.setExcluirDisciplina(idDisciplina)

    response.json(dadosDisciplina)
    response.status(dadosDisciplina.status_code)
})

app.post('/v1/escola_ideal/disciplina', cors(), bodyParserJson, async function(request, response){

    
    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let dadosDisciplina = await controllerDisciplinas.setInserirDisciplina(dadosBody, contentType)

    

    response.json(dadosDisciplina)
    response.status(dadosDisciplina.status_code)
})

app.put('/v1/escola_ideal/updateDisciplina/:id', cors(), bodyParserJson,  async function(request,response){
    let idDisciplina = request.params.id
    let contentType = request.headers['content-type']
    let dadosBody = request.body

    let atualizacaoDisciplina = await controllerDisciplinas.setAtualizarDisciplina(idDisciplina,dadosBody, contentType)

    response.json(atualizacaoDisciplina)
    response.status(atualizacaoDisciplina.status_code)
    

})

app.get('/v1/escola_ideal/disciplina/:id', cors(), async function(request, response){
    
    //recebe o id da requisição
    let idDisciplina = request.params.id

    //encaminha o id para a controller buscar o filme
    let dadosDisciplina = await controllerDisciplinas.getDisciplinaById(idDisciplina)
    console.log(dadosDisciplina)

    if(dadosDisciplina){
        response.json(dadosDisciplina)
        response.status(200)
    }else{
        response.json({message: 'Nenhum registro foi encontrado!'})
        response.status(404)
    }
    
    
})

/******************************  COMUNICADOS  ***********************************/


app.get('/v1/escola_ideal/comunicados', cors(), async function (request, response){
    let dadosComunicados = await controllerComunicados.getListarComunicados()

    if(dadosComunicados){
        response.json(dadosComunicados)
        response.status(dadosComunicados.status_code)
    }else{
        response.json
    }
})

app.delete('/v1/escola_ideal/deleteComunicado/:id', cors(), async function(request,response){
    let idComunicado = request.params.id

    let dadosComunicado = await controllerComunicados.setExcluirComunicado(idComunicado)

    response.json(dadosComunicado)
    response.status(dadosComunicado.status_code)
})

app.post('/v1/escola_ideal/comunicado', cors(), bodyParserJson, async function(request, response){

    
    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let dadosComunicado = await controllerComunicados.setInserirComunicado(dadosBody, contentType)

    

    response.json(dadosComunicado)
    response.status(dadosComunicado.status_code)
})

app.put('/v1/escola_ideal/updateComunicado/:id', cors(), bodyParserJson,  async function(request,response){
    let idComunicado = request.params.id
    let contentType = request.headers['content-type']
    let dadosBody = request.body

    let atualizacaoComunicado = await controllerComunicados.setAtualizarComunicado(idComunicado,dadosBody, contentType)

    response.json(atualizacaoComunicado)
    response.status(atualizacaoComunicado.status_code)
    

})

app.get('/v1/escola_ideal/comunicado/:id', cors(), async function(request, response){
    
    //recebe o id da requisição
    let idComunicado = request.params.id

    //encaminha o id para a controller buscar o filme
    let dadosComunicado = await controllerComunicados.getComunicadoById(idComunicado)
    console.log(dadosComunicado)

    if(dadosComunicado){
        response.json(dadosComunicado)
        response.status(200)
    }else{
        response.json({message: 'Nenhum registro foi encontrado!'})
        response.status(404)
    }
    
    
})
/******************************  TURMAS  ***********************************/


app.get('/v1/escola_ideal/turmas', cors(), async function (request, response){
    let dadosTurmas = await controllerTurmas.getListarTurmas()

    if(dadosTurmas){
        response.json(dadosTurmas)
        response.status(dadosTurmas.status_code)
    }else{
        response.json(404)
    }
})

app.delete('/v1/escola_ideal/deleteTurma/:id', cors(), async function(request,response){
    let idTurma = request.params.id

    let dadosTurma = await controllerTurmas.setExcluirTurma(idTurma)

    response.json(dadosTurma)
    response.status(dadosTurma.status_code)
})

app.post('/v1/escola_ideal/turma', cors(), bodyParserJson, async function(request, response){

    
    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let dadosTurma = await controllerTurmas.setInserirTurma(dadosBody, contentType)

    

    response.json(dadosTurma)
    response.status(dadosTurma.status_code)
})

app.put('/v1/escola_ideal/updateTurma/:id', cors(), bodyParserJson,  async function(request,response){
    let idTurma = request.params.id
    let contentType = request.headers['content-type']
    let dadosBody = request.body

    let atualizacaoTurma = await controllerTurmas.setAtualizarTurma(idTurma,dadosBody, contentType)

    response.json(atualizacaoTurma)
    response.status(atualizacaoTurma.status_code)
    

})

app.get('/v1/escola_ideal/turma/:id', cors(), async function(request, response){
    
    //recebe o id da requisição
    let idTurma = request.params.id

    //encaminha o id para a controller buscar o filme
    let dadosTurma = await controllerTurmas.getTurmaById(idTurma)
    console.log(dadosTurma)

    if(dadosTurma){
        response.json(dadosTurma)
        response.status(200)
    }else{
        response.json({message: 'Nenhum registro foi encontrado!'})
        response.status(404)
    }
    
    
})

/**************************************  FREQUENCIA  *************************************/

app.get('/v1/escola_ideal/somaFrequencia/:id', cors(), async function(request, response){


    let idMatricula = request.params.id

    let somaFaltas = await controllerFrequencia.getSomaFaltas(idMatricula)
    
    if(somaFaltas){
        response.json(somaFaltas)
        response.status(200)
    }else{
      
        response.json({message: 'Nenhum registro foi encontrado!'})
        response.status(404)
    }
    
    
})

app.post('/v1/escola_ideal/frequencia', cors(), bodyParserJson, async function(request, response){

    
    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let dadosFrequencia = await controllerFrequencia.setInserirFrequencia(dadosBody, contentType)

    

    response.json(dadosFrequencia)
    response.status(200)
})

/****************************  NOTAS  **************************/

app.post('/v1/escola_ideal/nota', cors(), bodyParserJson, async function(request, response){

    
    let contentType = request.headers['content-type']

    let dadosBody = request.body

    let dadosNota = await controllerNotas.setInserirNota(dadosBody, contentType)

    

    response.json(dadosNota)
    response.status(200)
})

app.put('/v1/escola_ideal/updateNota/:id', cors(), bodyParserJson,  async function(request,response){
    let idNota = request.params.id
    let contentType = request.headers['content-type']
    let dadosBody = request.body

    let atualizacaoNota = await controllerNotas.setAtualizarNota (idNota,dadosBody, contentType)

    response.json(atualizacaoNota)
    response.status(atualizacaoNota.status_code)
    

})

app.get('/v1/escola_ideal/notas/:idMatricula/:idDisciplina', cors(), async function(request, response){


    let idMatricula = request.params.idMatricula
    let idDisciplina = request.params.idDisciplina

    let notasDisciplina = await controllerNotas.getNotasDisciplina(idMatricula, idDisciplina)
    
    if(notasDisciplina){
        response.json(notasDisciplina)
        response.status(200)
    }else{
      
        response.json({message: 'Nenhum registro foi encontrado!'})
        response.status(404)
    }
    
    
})




app.listen('8080', function(){
    console.log('API funcionando!!')
})
