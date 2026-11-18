const mysql = require('mysql2');

const connection = mysql.createConnection({
    host:root,
    user:root,
    password:root,
    database:'',
    dateStrings:true
});

connection.connect((erro) => {
if (erro) {
    console.log('Erro ao conectar:', erro);
    return;
    }

console.log('Banco conectado com sucesso!');
});

module.exports = connection;
