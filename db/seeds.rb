User.create!(
  name: "hoge",
  email: "hoge@example.com",
  password: "password",
  password_confirmation: "password"
)

# dummy users
5.times do |n|
  User.create!(
    name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password"
  )
end

# dummy books
users = User.all
5.times do |k|
  5.times do |n|
    users[k].books.create!(
      title: Faker::Book.unique.title,
      body: Faker::Lorem.sentence
    )
  end
end