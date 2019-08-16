User.create!(
  name:  "Admin",
  email: "admin@admin.com",
  password: "123123",
  password_confirmation: "123123",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

40.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "p4ssW0rD"

  User.create!(
    name:  name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.order('created_at DESC').take(5)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create(content: content) }
end
