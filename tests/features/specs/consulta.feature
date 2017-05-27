#language:pt

Funcionalidade: Consulta de usuários

Cenario: Obter lista de usuários

    Quando faço uma consulta através do serviço "/users"
    Então o código de resposta é "200"
        E o sistema retorna uma lista de usuários cadastrados

Cenario: Obter único usuário

    Dado que eu tenho um usuário cadastrado
    Quando faço a consulta desse usuário através do serviço "/users"
    Então o código de resposta é "200"
        E o sistema retorna os dados desse usuário

Cenario: Usuário não cadastrado

    Dado que o usuário não está cadastrado
    Quando faço a consulta desse usuário através do serviço "/users"
    Então o código de resposta é "404"
        E vejo a mensagem "Usuário não encontrado!"
    





