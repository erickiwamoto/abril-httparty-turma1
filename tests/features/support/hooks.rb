

Before('@new_user') do
    name = Faker::Pokemon.name
    request = {
        name: name,
        email: Faker::Internet.free_email(name),
        password: '123456'
    }
    result = HTTParty.post(
        "https://ninjarest.herokuapp.com/users",
        :body=> request.to_json,
        :headers=> {'Content-Type' => 'application/json'}
    )

    result = HTTParty.get(
        "https://ninjarest.herokuapp.com/users",
        query: { email: request[:email] }
    )
    puts result.parsed_response.first
    @user = OpenStruct.new(result.parsed_response.first)
end