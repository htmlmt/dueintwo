# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

michael = User.create(first_name: "Michael", last_name: "Todd", email: "michael@lemonly.com", username: "michael", address: "600 N. Main Ave., Apt. 208", city: "Sioux Falls", state: "South Dakota", zip: "57104", phone: "3087601395", password: "password", password_confirmation: "password")

amy = User.create(first_name: "Amy", last_name: "Colgan", email: "amy@lemonly.com", username: "amy", address: "196 E. 6th. St., Apt. 303", city: "Sioux Falls", state: "South Dakota", zip: "57104", phone: "6054302665", password: "password", password_confirmation: "password")

john = User.create(first_name: "John", last_name: "Meyer", username: "john", email: "john@lemonly.com", address: "2009 S. Faris Ave.", city: "Sioux Falls", state: "South Dakota", zip: "57104", phone: "6128674746", password: "password", password_confirmation: "password")

josh = User.create(first_name: "Josh", last_name: "Broton", email: "josh@lemonly.com", username: "josh", address: "7005 West 64th Street", city: "Sioux Falls", state: "South Dakota", zip: "57106", phone: "6052123779", password: "password", password_confirmation: "password")

scott = User.create(first_name: "Scott", last_name: "Johns", email: "scott@lemonly.com", username: "scott", address: "8520 SW 212 Street, Apt. 307", city: "Culter Bay", state: "Florida", zip: "33189", phone: "3057733422", password: "password", password_confirmation: "password")

cheryl = User.create(first_name: "Cheryl", last_name: "Loh", email: "cheryl@lemonly.com", username: "cheryl", address: "2540 Ash Street", city: "Vancouver, BC, V5Z 3C4, Canada", state: "", zip: "", phone: "6047900077", password: "password", password_confirmation: "password")

dafne = User.create(first_name: "Dafne", last_name: "Sagastume", email: "dafne@lemonly.com", username: "dafne", address: "1-3936 Main Street", city: "Vancouver, BC v5v 3p2", state: "", zip: "", phone: "6047677630", password: "password", password_confirmation: "password")

# saw = Item.create(name: "1868 Band Saw", description: "Your project needs this ultra-safe, incredibly old band saw. Borrow it, and your life will never be the same.", photo: "https://s3.amazonaws.com/lemonly-product/5017969542_64085c4849_b.jpg", price: 50.00)
#
# lawnmower = Item.create(name: "Lawnmower of Your Dreams", description: "Blades of grass will quiver in this machine's wake. Take it, and cherish it.", photo: "https://s3.amazonaws.com/lemonly-product/5864990376_9b65b45384_b.jpg", price: 20.00)
#
# snow_blower = Item.create(name: "Suave Snow Blower", description: "You won't believe it's winter when this burly beast sets foot on the sidewalk. Destroy the cold, and borrow this.", photo: "https://s3.amazonaws.com/lemonly-product/12099100664_36e48a7eae_b.jpg", price: 30.00)
#
# projector = Item.create(name: "Projector, Makes Bogart Look Amazing", description: "The only thing you'll ever need. Face it.", photo: "https://s3.amazonaws.com/lemonly-product/projector.jpg", price: 40.00)
#
# camera = Item.create(name: "Sweet Camera for Sweet Pics", description: "Come on, you want to look fly, don't you? Rent it, why don't you.", photo: "http://upload.wikimedia.org/wikipedia/commons/c/cf/Nikon_F_SLR_camera_with_NIKKOR-S_Auto_1,4_f%3D5,8cm.JPG", price: 10.00)
#
# screwdriver = Item.create(name: "Screwdriver to Rule Them All", description: "Watch out, sheetrock. It's coming for you", photo: "https://farm3.staticflickr.com/2879/9720230054_028e2fa64d_z.jpg", price: 5.00)
#
# michael.items << saw
# amy.items << snow_blower
# john.items << lawnmower
# josh.items << projector
# scott.items << camera
# dafne.items << screwdriver