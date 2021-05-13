# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


User.destroy_all
City.destroy_all
Tagossip.destroy_all
Gossip.destroy_all
Tag.destroy_all
Privatemessage.destroy_all

Faker::Config.locale = 'fr'

users = Array.new
gossips = Array.new


10.times do
    city = City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

puts "city ok"

10.times do 
    user = User.create!(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name, 
        description: Faker::Lorem.paragraph(sentence_count: 2),
        email: Faker::Internet.email,
        age: rand(18..70),
        city_id: City.all.sample.id,
        password: "Azerty"
        )
        users << user    
end

puts "users created"

10.times do 
    tag = Tag.create!(title: Faker::Lorem.word)
end

puts "tag ok"

20.times do 
    gossip = Gossip.create!(
        title: Faker::Hipster.sentence(word_count: 3),
        content: Faker::Hipster.sentences(number: 2),
        user_id: User.all.sample.id
    )
    gossips << gossip
end

puts "gossip created"

20.times do 
    tagossip = Tagossip.create!(tag_id: Tag.all.sample.id, gossip_id: Gossip.all.sample.id)
end

puts "gossips attributed"

10.times do
    private_message = Privatemessage.create!(
        content: Faker::Quote.yoda,
        recipient_id: User.all.sample.id,
        sender_id: User.all.sample.id
        )
end

20.times do
    comment = Comment.create(
      user_id: users[rand(0..9)].id,
      gossip_id: gossips[rand(0..19)].id,
      content: Faker::TvShows::GameOfThrones.quote 
    )
    puts "Seeding Comment '#{comment.content}' from User #{comment.user_id} to gossip #{comment.gossip_id}"
  end