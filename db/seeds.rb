# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'faker'
# primeiro apagar as doses porque e o que tem foreign keys

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")

if Rails.env.development?
  Dose.destroy_all
  Cocktail.destroy_all
  puts 'Creating 10 fake cocktails...'

  10.times do |index|
    puts "Creating cocktail #{index}..."
    image_url = Faker::LoremFlickr.image(size: "500x500", search_terms: ['cocktails'])
    file = URI.open(image_url)
    cocktail = Cocktail.new(name: Faker::Artist.unique.name)
    cocktail.photo.attach(io: file, filename: 'file.png', content_type: 'image/png')
    cocktail.save!
  end
end

Ingredient.destroy_all

response = RestClient.get(Ingredient::API_URL)

json = JSON.parse(response.body, symbolize_names: true)

json[:drinks].each do |drink|
  ingredient = Ingredient.new(name: drink[:strIngredient1])
  ingredient.save!

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

puts 'Creating doses...'

  Cocktail.all.each do |cocktail|
    dose = Dose.new(
      description: Faker::Measurement.metric_volume,
      cocktail: cocktail,
      ingredient: Ingredient.all.sample
    )

    dose.save!
  end

puts "Finished!"
