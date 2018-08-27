# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
UserTrip.destroy_all
Trip.destroy_all
User.destroy_all

puts 'Creating users and trips...'

user = User.new(
    first_name: 'Toto',
    last_name: 'Dupont',
    email: 'toto@gmail.com',
    password: 'totototo'
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false
    # t.string "photo" ,
  )
user.save!


trip = Trip.new(
    name: 'Voyage aux USA',
    start_location: 'New-York',
    end_location: 'Dallas',
    start_date: DateTime.now,
    end_date: DateTime.now
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false
    # t.string "photo" ,
  )

trip.user = user
trip.save!

user_trip = UserTrip.new

user_trip.user = user
user_trip.trip = trip

user_trip.save!

branch = Branch.new(
  master: true
  )

branch.trip = trip
branch.save!

event = Event.new(
  name: 'White House',
  type: 'visite',
  #TODO changer type en category
  location: 'Washington',
  date: DateTime.now,
  duration: 9
  )

event.save!

branch_event = BranchEvent.new(
  event_position: 1
  )

branch_event.branch = branch
branch_event.event = event
