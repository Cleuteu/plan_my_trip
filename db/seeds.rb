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
    end_date: Date.new(2018,8,31)
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
  category: 'visite',
  # location: 'Washington',
  date: DateTime.now,
  duration: 9
  )

event.save!

branch_event = BranchEvent.new(
  )

branch_event.branch = branch
branch_event.event = event
branch_event.parent_event = 0
branch_event.save!

event2 = Event.new(
  name: 'Meet Donald',
  category: 'visite',
  # location: 'Washington',
  date: DateTime.now,
  duration: 9

  )

event2.save!

branch_event2 = BranchEvent.new(
  )

branch_event2.branch = branch
branch_event2.event = event2
branch_event2.parent_event = event.id
branch_event2.save!
