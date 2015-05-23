# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Product.create(title: "Pahare", description: "Cele mai tari pahare!")
Product.create(title: "Servetele", description: "De masa")
Product.create(title: "Laptopuri", description: "Alienware")
Product.create(title: "Mac", description: "nu cumpara...!")



10.times do |g|
	Product.create(title: Faker::Commerce.product_name, description: "Who Cares..")
end

100.times do |c|
	Variant.create(price: (rand(100)).ceil, quantity: (rand(10).ceil).floor , product_id: rand(1..10).floor)
end