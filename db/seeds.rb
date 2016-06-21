# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

15.times do |n|
 Task.create(title: "default_task#{n+1}",
             user_id: n+1,
             charge_id: n+1,
             content: "default_task_content#{n+1}"
             )
end