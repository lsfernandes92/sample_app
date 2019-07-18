User.create!(
  name:  "Admin",
  email: "admin@admin.com",
  password: "123123",
  password_confirmation: "123123",
  admin: true
)

40.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "p4ssW0rD"

  User.create!(
    name:  name,
    email: email,
    password: password,
    password_confirmation: password
  )
end
