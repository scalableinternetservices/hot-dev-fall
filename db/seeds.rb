# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  for x in 1..100
    Joiner.create(user_id: x, service: "Netflix", status: "Pending")
  end

  for x in 101..200
    Sharer.create(user_id: x, service: "Netflix", size: 5, account_id:"helpme@me.com", account_password:"MOUSE", status: "Pending", plan_cost: 10)
  end

