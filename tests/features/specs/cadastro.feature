#language: pt

Funcionalidade: Cadastrar usuário

Cenario: Cadastro de novo usuário

    Dado que eu tenho um novo usuário
    Quando faço o cadastro desse usuário
    Então o código de resposta é "200"
        E vejo este usuário cadastrado no sistema

Cenario: Email deve ser obrigatório

    Dado que eu tenho um novo usuário
        Mas esse usuário não possui "email"
    Quando faço o cadastro desse usuário
    Então o código de resposta é "409"
        E vejo a mensagem "Email deve ser obrigatório!"
    
Cenario: Nome deve ser obrigatório

    Dado que eu tenho um novo usuário
        Mas esse usuário não possui "name"
    Quando faço o cadastro desse usuário
    Então o código de resposta é "409"
        E vejo a mensagem "Nome deve ser obrigatório!"

Cenario: Senha deve ser obrigatório

    Dado que eu tenho um novo usuário
        Mas esse usuário não possui "password"
    Quando faço o cadastro desse usuário
    Então o código de resposta é "409"
        E vejo a mensagem "Senha deve ser obrigatório!"
