10.times do
  u = User.create!(
    username: Faker::Name.name,
    email: Faker::Internet.email,
    password: "helloworld",
    )
  u.confirm
end
users = User.all

25.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraphs(4)
  )
end

admin = User.create!(
  username: "Admin",
  email: "admin@admin.admin",
  password: "helloworld"
)
admin.confirm
admin.add_role :admin

premium = User.create!(
  username: "Premium",
  email: "premium@premium.premium",
  password: "helloworld"
)
premium.confirm
premium.add_role :premium

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "Admin and Premium accounts created"
