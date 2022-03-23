# no_meat_recipes_backend

## Introduction

This is a project that helps users find the most relevant vegan/vegetarian recipes that they can easily cook for their vegan/vegetarian food.

## User story

- As a Vegetarian, I want the recipes without any animal, including pigs, chickens, cows, sheep, and fish
- As a Vegan, I want the recipes without any animal, including pigs, chickens, cows, sheep, and fish. Plus without dairy products and eggs 
- As a User, I want to search recipes that match my current ingredients

## Quickstart

- Clone/download the repository
```
git clone git@github.com:JiaPing1019/no_meat_recipes_backend.git
```

- Move to ruby_app directory
```
 cd no_meat_recipes_backend  
```

- Install the dependencies specified in the Gemfile
```
bundle install
```

- Setup the PostgreSQL DB
```
bundle exec rake db:drop db:create
```

- Run the migration files
```
bundle exec rake db:migrate
```

- Start the Rails server
```
bundle exec rails s
```
Run it on [http://localhost:3000](http://localhost:3000)

- Add seed data to the database.
```
bundle exec rake db:seed
```

## About Test

Use [RSpec](http://rspec.info/) to make sure our code run properly

```
bundle exec rspec   ## runs the entire test suite
```

## Pending features

- [ ] Backend can response the query based on `catogory_name` 、 `title` 、 `cook_time` 、 `prep_time`  、 `ratings`  
- [ ] The API for single recipe to see the cooking method more detailly  

-----------
Thank you for taking time to review my code. If you have any suggestions or feedback, I would definitely like to hear from you. Cheers. 
