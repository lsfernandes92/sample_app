User.create!(
  name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar"
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
