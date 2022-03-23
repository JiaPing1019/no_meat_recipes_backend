require 'yajl'

puts 'Read the file'
json = File.read(Rails.root.join('db/recipes-english.json'))
recipes = Yajl::Parser.parse(json)
created = 0

puts 'Create and store recipes in the DB'
errors = []
start_time = Time.zone.now

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

def find_category(category_name)
  # There are some data with no category, we give them 「undefined」 category for now
  return Category.find_or_create_by(name: 'undefined') if category_name.empty? 

  category = Category.find_by(name: category_name)
  return category if category.present?

  Category.create(name: category_name)
end

recipes.each do |data|
  next unless no_meat_recipe?(data['title'], data['category'])

  category = find_category(data['category'])

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
  errors << "#{e.class}: #{e.message}. Failed recipe title: #{data['title']}."
end

finished_time = Time.zone.now 

puts 'Finish!!!'

puts '---------------------------------------'
puts '【SUMMARY REPORT】'
puts "Total targeted object: #{recipes.size}"
puts "Created object: #{created}"
puts "Total execution time: #{finished_time - start_time}" 
puts "Error: #{errors.uniq}"
puts '---------------------------------------'
