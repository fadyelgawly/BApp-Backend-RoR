5.times do
    Article.create({ 
        title: Faker::Book.title,
        body: Faker::Lorem.sentence
     })
end

user = User.create(username: "fady", password: "fady", email: "fgawly@gmail.com", image: "")