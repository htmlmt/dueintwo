# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Item.create(name: "1868 Band Saw", description: "Your project needs this ultra-safe, incredibly old band saw. Borrow it, and your life will never be the same.", photo: "hhttps://s3.amazonaws.com/lemonly-product/5017969542_64085c4849_b.jpg", price: 50.00)

Item.create(name: "Lawnmower of Your Dreams", description: "Blades of grass will quiver in this machine's wake. Take it, and cherish it.", photo: "https://s3.amazonaws.com/lemonly-product/5864990376_9b65b45384_b.jpg", price: 20.00)

Item.create(name: "Suave Snow Blower", description: "You won't believe it's winter when this burly beast sets foot on the sidewalk. Destroy the cold, and borrow this.", photo: "https://s3.amazonaws.com/lemonly-product/12099100664_36e48a7eae_b.jpg", price: 30.00)