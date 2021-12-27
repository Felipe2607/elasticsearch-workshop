# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
vowels = ['a','e','i','o','u']
5.times do |i|
  user = User.create(name: 'Alvar' + vowels[i.modulo(5)])
  5.times do |j|
    Product.create(user_id: user.id, name: 'Pandor' + vowels[i.modulo(5)] + j.to_s)
  end
end
5.times do |i|
  user = User.create(name: 'Alvarol' + vowels[i.modulo(5)])
  5.times do |j|
    Product.create(user_id: user.id, name: 'Pandorol' + vowels[i.modulo(5)] + j.to_s)
  end
end
5.times do |i|
  user = User.create(name: 'Alvarit' + vowels[i.modulo(5)])
  5.times do |j|
    Product.create(user_id: user.id, name: 'Pandorit' + vowels[i.modulo(5)] + j.to_s)
  end
end
