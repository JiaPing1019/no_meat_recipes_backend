require 'yajl'

puts 'Read the file'
json = File.read(Rails.root.join('db/recipes-english.json'))
recipes = Yajl::Parser.parse(json)
created = 0

puts 'Create and store recipes in the DB'
errors = []

# Consider the recipes as no meat when matching the following conditions
# ① Category name contains Vegan or Vegetarian
# ② Recipe title contains Vegan or Vegetarian
def no_meat_recipe?(title, category)
  title = title.downcase
  category = category.downcase

  title.match('vegetarian').present? ||
    title.match('vegan').present? ||
    category.match('vegetarian').present? ||
    category.match('vegan').present?
end

recipes.each do |data|
  next unless no_meat_recipe?(data['title'], data['category'])

  category = Category.find_by(name: data['category'])
  category = Category.create(name: data['category']) if category.nil?

  recipe = category.recipes.create(
    title: data['title'],
    cook_time: data['cook_time'],
    prep_time: data['prep_time'],
    ratings: data['ratings'],
    cuisine: data['cuisine'],
    author: data['author'],
    image_url: data['image']
  )

  data['ingredients'].each do |ingredient|
    recipe.ingredients.create(name: ingredient)
  end

  created += 1
rescue StandardError => e
  errors << "#{e.class}: #{e.message}"
end

puts 'Finish!!!'

puts '---------------------------------------'
puts '【SUMMARY REPORT】'
puts "Total targeted object: #{recipes.size}"
puts "Created object: #{created}"
puts "Error: #{errors.uniq}"
puts '---------------------------------------'
