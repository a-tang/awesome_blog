# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  Category.create(name: Faker::Hacker.adjective)
end

categories = Category.all

50.times do
  q = Article.create  title:      Faker::Company.bs,
                      text:       Faker::Lorem.paragraph,
                      category:   categories.shuffle.first
    10.times do
      random = rand(20)
      if random < 10
        q.comments.create(commenter: Faker::StarWars.quote)
        q.comments.create(body: Faker::StarWars.quote)
      else
        q.comments.create(commenter: Faker::ChuckNorris.fact)
        q.comments.create(body: Faker::StarWars.quote)
      end
    end
end
