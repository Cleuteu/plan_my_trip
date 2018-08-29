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

branch2 = Branch.new(
  master: false
  )

branch2.trip = trip
branch2.save!

branch3 = Branch.new(
  master: false
  )

branch3.trip = trip
branch3.save!

event = Event.new(
  name: 'White House',
  category: 'visite',
  # location: 'Washington',
  date: DateTime.now,
  duration: 9
  )

event.save!


event2 = Event.new(
  name: 'Meet Donald',
  category: 'visite',
  # location: 'Washington',
  date: DateTime.now,
  duration: 9
  )

event2.save!

event3 = Event.new(
  name: 'Train to NY',
  category: 'visite',
  # location: 'Washington',
  date: DateTime.now,
  duration: 9
  )

event3.save!

event4 = Event.new(
  name: 'Bus to Chicago',
  category: 'visite',
  # location: 'Washington',
  date: DateTime.now,
  duration: 9
  )

event4.save!

#Branche 1
#Branche 1 et White-house
branch_event = BranchEvent.new()

branch_event.branch = branch
branch_event.event = event
branch_event.parent_event = 0
branch_event.save!

#Branche 1 et Meet Donald
branch_event2 = BranchEvent.new()

branch_event2.branch = branch
branch_event2.event = event2
branch_event2.parent_event = event.id
branch_event2.save!

#Branche 2
#Branche 2 et Event Meet trump
branch_event3 = BranchEvent.new()

branch_event3.branch = branch2
branch_event3.event = event2
branch_event3.parent_event = event.id
branch_event3.save!

#Branche 2 et Event NY
branch_event4 = BranchEvent.new()

branch_event4.branch = branch2
branch_event4.event = event3
branch_event4.parent_event = event2.id
branch_event4.save!

#Branche 3
#Branche 3 et Event Meet Trump
branch_event5 = BranchEvent.new()

branch_event5.branch = branch3
branch_event5.event = event2
branch_event5.parent_event = event.id
branch_event5.save!

#Branche 3 et Event Chicago
branch_event6 = BranchEvent.new()

branch_event6.branch = branch3
branch_event6.event = event4
branch_event6.parent_event = event2.id
branch_event6.save!
