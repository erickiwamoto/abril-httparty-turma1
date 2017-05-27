#encoding: utf-8

Quando(/^faço uma consulta através do serviço "([^"]*)"$/) do |service|
  @result = HTTParty.get('https://ninjarest.herokuapp.com' + service)
end

Então(/^o código de resposta é "([^"]*)"$/) do |status_code|
   expect(@result.response.code).to eql status_code
end

Então(/^o sistema retorna uma lista de usuários cadastrados$/) do
  expect(@result.parsed_response).not_to be_empty

  @result.parsed_response.each do |u|
    expect(u).to have_key('id')
    expect(u).to have_key('name')
    expect(u).to have_key('email')
    expect(u).to have_key('password')
  end
end

## Unico usuário

Dado(/^que eu tenho um usuário cadastrado$/) do
  list = HTTParty.get('https://ninjarest.herokuapp.com/users')
  @user = OpenStruct.new(list.parsed_response.sample)
end

Quando(/^faço a consulta desse usuário através do serviço "([^"]*)"$/) do |service|
  @result = HTTParty.get("https://ninjarest.herokuapp.com#{service}/#{@user.id}" )
end

Então(/^o sistema retorna os dados desse usuário$/) do
  got = OpenStruct.new(@result.parsed_response)
  expect(got).to eql @user
end

# Get User Not found

Dado(/^que o usuário não está cadastrado$/) do
  @user = OpenStruct.new({ "id": Faker::Crypto.md5 })
end

Então(/^vejo a mensagem "([^"]*)"$/) do |msg|
  expect(@result.parsed_response['message']).to eql msg
end

# Delete

Quando(/^faço a exclusão desse usuário através do serviço "([^"]*)"$/) do |service|
  @result = HTTParty.delete("https://ninjarest.herokuapp.com#{service}/#{@user.id}" )
end

Então(/^esse usuário não deve ser exibido na lista$/) do
  @result = HTTParty.get("https://ninjarest.herokuapp.com/users/#{@user.id}" )
  expect(@result.response.code).to eql "404"
end

# Post

Dado(/^que eu tenho um novo usuário$/) do
    name = Faker::Superhero.name
    @request = {
        name: name,
        email: Faker::Internet.free_email(name),
        password: '123456'
    }.to_json
    @request = JSON.parse(@request)
end

Dado(/^esse usuário não possui "([^"]*)"$/) do |key|
  @request.delete(key)
end

Quando(/^faço o cadastro desse usuário$/) do
    @result = HTTParty.post(
        "https://ninjarest.herokuapp.com/users",
        :body=> @request.to_json,
        :headers=> {'Content-Type' => 'application/json'}
    )
end

Então(/^vejo este usuário cadastrado no sistema$/) do
    @result = HTTParty.get(
        "https://ninjarest.herokuapp.com/users",
        query: { email: @request['email'] }
    )

    got = @result.parsed_response.first

    expect(got['id'].size).to eql 24
    #expect(got['id']).not_to be_empty ///não é tão chique///
    expect(got['name']).to eql @request['name']
    expect(got['email']).to eql @request['email']
    expect(got['password']).to eql @request['password']
end