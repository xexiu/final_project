# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Sergio Mironescu",
             email: "ser@ser.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

users = User.order(:created_at).take(6)
10.times do
  title= Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(40)
  users.each { |user| user.entries.create!(title: title, content: content) }
end

6.times do |n|
  name  = Faker::Name.name
  email = "test#{n+1}@test.com"
  password = "foobar"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
