#language: pt

Funcionalidade: Remover usuário

@new_user
Cenario: Remover usuário com sucesso

    Quando faço a exclusão desse usuário através do serviço "/users"
    Então o código de resposta é "200"
        E esse usuário não deve ser exibido na lista