# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
Review.destroy_all
Message.destroy_all
Renting.destroy_all
Suit.destroy_all
User.destroy_all

puts 'Creating users, suits, rentings and messages...'

user = User.new(
    first_name: 'Toto',
    last_name: 'Dupont',
    email: 'toto@gmail.com',
    encrypted_password: 'totototo',
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false
    # t.string "photo" ,
  )


trip = Trip.new(
    name: 'Voyage aux USA',
    start_location: 'New-York',
    end_location: 'Dallas',
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false
    # t.string "photo" ,
  )

user.save!
trip.save!

user_trip = UserTrip.new

user_trip.user = user
user_trip.trip = trip

user_trip.save!
