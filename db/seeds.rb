# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'recipes.csv'))
if ! csv_text.valid_encoding?
  csv_text = csv_text.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
end
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  # t = Recipe.new
  t = Recipe.new
  t.name = row['name']
  t.description = row['description']
  t.instructions = row['instructions']
  t.servings = row['servings']

  t.recipe_image = Rails.root.join("db/images/" + row['recipe_image']).open

  t.user_id = row['user_id']
  t.flavor = row['flavor']
  # t.source = row['recipe_source']

  # i = t.ingredients.build
    # t.ingredient_id = row['ingredient_id']
    # row['ingredients_name'].each_with_index do |ingredient, index|
    #   i.name = row['ingredients_name'][index]
    #   i.recipe_id = t.id
    #   i.quantity = row['ingredients_quantity'][index]
    #   i.measurement = row['ingredient_measurement'][index]
    #   i.category = row['ingredients_category'][index]
    # end

  t.save!
  puts "#{t.name} saved"
end

puts "There are now #{Recipe.count} rows in the transactions table"
nameArr = ["Patty Puterbaugh", "Enedina Esterlin", "Arturo Abe", "Angeline Asberry", "Natalia Nickles", "Matilde Miranda", "Gerard Geissler", "Tyree Taul", "Elbert Eastin", "Mistie Mack", "Latoya Lenzen", "Keri Kincade", "Nana Natal", "Temple Thor", "Mitsue Mahi", "Eileen Escobedo", "Jacklyn Jeffery", "Stefan Snavely", "Ilana Illingworth", "Chadwick Canela" ]

nameArr.each do |name|
  User.create! :user_name => (name), :email => ( name.delete(' ') + '@gmail.com'), :password => (name + "123"), :password_confirmation => (name + '123')
end
