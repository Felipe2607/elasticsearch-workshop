# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
vowels = ['a','e','i','o','u']
5.times do |i|
  user = User.create(name: 'Alvar' + vowels[i.modulo(5)], latitude: -34.91192022711873, longitude: -56.159201971185134) # XL casa 1
  5.times do |j|
    Product.create(user_id: user.id, name: 'Pandor' + vowels[i.modulo(5)] + j.to_s, latitude: -34.9122201746336, longitude: -56.15873333669135) # XL casa 2
  end
end
5.times do |i|
  user = User.create(name: 'Zorro' + vowels[i.modulo(5)], latitude: -56.15873333669135, longitude: -56.15873333669135) #CDS
  5.times do |j|
    Product.create(user_id: user.id, name: 'Penarol' + vowels[i.modulo(5)] + j.to_s, latitude: -34.79107277251573, longitude: -56.07101505030062) # zonaamerica
  end
end
5.times do |i|
  user = User.create(name: 'Felif' + vowels[i.modulo(5)], latitude: 40.45321005670132, longitude: -3.6883444424904073) # bernabeu
  5.times do |j|
    Product.create(user_id: user.id, name: 'Hala Madrid' + vowels[i.modulo(5)] + j.to_s, latitude: 39.98010079691288, longitude: -8.048595923507209) #madeira CR7
  end
end

user = User.create(name: 'Alverso', latitude: -34.8382925142876, longitude: -55.983743227626285) # Lagomar
Product.create(user_id: user.id, name: "Alverso's product", latitude: -34.8382925142876, longitude: -55.983743227626285)
