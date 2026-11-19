const API = 'http://localhost:3025';

async function buscarJson(caminho) {
    const resposta = await fetch(API + caminho);
    return resposta.json();

async function enviarJson(caminho, metodo, dados) {
    const opcoes = {method: metodo}

    if(dados){
        opcoes.headers = {'Content-Type': 'application/json'};
        opcoes.body = JSON.stringify(dados);
    }

    const resposta = await fetch(API + caminho, opcoes);
    return { ok: resposta.ok, dados: await resposta.json()};
}

async function enviar(caminho, metodo, dados) {
    const {ok, dados: json} = await enviarJson(caminho, metodo, dados);
    alert(json.mensagem);
    return ok;
}


    
}