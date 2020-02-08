# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'faker'
# primeiro apagar as doses porque e o que tem foreign keys

Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")

puts 'Creating 10 fake cocktails...'

10.times do
  cocktail = Cocktail.new(
    name: Faker::Artist.name
  )
  if cocktail.save
    cocktail.save!
  end
end

response = RestClient.get(Ingredient::API_URL)

json = JSON.parse(response.body, symbolize_names: true)

json[:drinks].each do |drink|
  ingredient = Ingredient.new(name: drink[:strIngredient1])
  if ingredient.save
    ingredient.save!
  end
  puts drink[:strIngredient1]
end

# puts 'Creating 10 fake ingredients...'

# 10.times do
#   ingredient = Ingredient.new(
#     name: Faker::Food.ingredient
#   )
#   if ingredient.save
#     # if it can passes all the validations, then it saves it!
#     ingredient.save!
#   end
# end

puts 'Creating 10 fake doses...'

10.times do
  dose = Dose.new(
    description: Faker::Measurement.metric_volume,
    cocktail: Cocktail.all.sample,
    ingredient: Ingredient.all.sample
  )
  if dose.save
    dose.save!
  end
end
puts "Finished!"
