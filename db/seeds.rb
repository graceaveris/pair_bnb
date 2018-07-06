# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#LISTING SEED
user = User.create(first_name: 'Wolfgang', last_name: 'Bergdorf', email: 'wolfgangbergdorf@gmail.com', password: 'wolfgangrules', confirmation_token: '4567', remember_token: '8912')
listing = Listing.create(property_name: 'Black Forest Castle', property_description: 'Grand castle deep in the Black Forest. 6 bedrooms, all with fireplaces, drawbridge entrance and two pet bears." ', max_guest_number: 12, country: 'Germany', city: 'Swartzwald', price: 280, user_id: 7)
# Seed Listings
