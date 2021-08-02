User.create!(name: "SHIZUE Ota",
                email: "irohanih15@gmail.com",
                password: "123abc456def",
                password_confirmation: "123abc456def")

99.times do |n|
    name = Faker::Name.name
    email = "username#{n+1}@email.org"
    password = "123abc456def"
    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password)
end

users = User.order(:created_at).take(7)
50.times do
  content = Faker::Lorem.sentence(3)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
