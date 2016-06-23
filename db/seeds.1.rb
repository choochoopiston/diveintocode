# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do |n|
 User.create(name: "defaultname#{n+1}",
             email: "default#{n+1}@default.com",
             password: "password",
             password_confirmation: "password",
             uid: "default#{n+1}",
             provider: "default")
             
 Blog.create(title: "test#{n+1}",
             content: "aaa#{n+1}",
             user_id: n+1)
             
end