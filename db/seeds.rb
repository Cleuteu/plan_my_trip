# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
Relationship.destroy_all
Event.destroy_all
UserTrip.destroy_all
Trip.destroy_all
User.destroy_all

puts 'Creating users...'

user = User.create!(
    first_name: 'Toto',
    last_name: 'Dupont',
    email: 'toto@gmail.com',
    password: 'totototo'
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false,
    # t.string "photo"
  )


user2 = User.create!(
    first_name: 'Alain',
    last_name: 'Dupont',
    email: 'a@a.com',
    password: '123456'
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false,
    # t.string "photo"
  )

puts 'Creating Canadian trip...'

trip = Trip.new(
    name: 'Voyage au Canada',
    start_location: 'New-York, USA',
    end_location: 'Dallas, USA',
    start_date: DateTime.now,
    end_date: Date.new(2018,8,31)
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false,
    # t.string "photo"
  )
trip.user = user
trip.save!

user_trip = UserTrip.new
user_trip.user = user
user_trip.trip = trip
user_trip.save!

event_start = Event.new(name: "Start", category: "settings", date: trip.start_date, location: trip.start_location, trip_id: trip.id, duration: 1)
event_start.save!
event_end = Event.new(name: "End", category: "settings", date: trip.end_date, location: trip.end_location, trip_id: trip.id, duration: 1)
event_end.save!


# def event_create(params)
#   @event = Event.new(event_params)
#   @trip = Trip.find(params[:trip_id])
#   @event.trip_id = @trip.id
#   @parent_id = params[:event][:parent_ids]
#   @child_id = params[:event][:child_ids]
#   @event.save!
#   @relationship = Relationship.create!(parent_id: @parent_id, child_id: @event.id)
#   @relationship = Relationship.create!(parent_id: @event.id, child_id: @child_id)
#   Relationship.destroy(Relationship.where(parent_id: @parent_id, child_id: @child_id).first.id)
# end

puts 'Creating Canadian trip events ...'

avion_montreal_event = Event.create!(
  name: 'Avion Montreal',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,8,31),
  duration: 9,
  trip_id: trip.id
  )
Relationship.create!(parent_id: event_start.id, child_id: avion_montreal_event.id)

visite_montreal_event = Event.create!(
  name: 'Visite Montreal',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,8,31),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: avion_montreal_event.id, child_id: visite_montreal_event.id)

airbnb_montreal_event = Event.create!(
  name: 'Airbnb Montreal',
  category: 'Hébergement',
  # location: 'Washington',
  date: Date.new(2018,8,31),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: visite_montreal_event.id, child_id: airbnb_montreal_event.id)

bus_quebec_event = Event.create!(
  name: 'Bus Quebec City',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,9,01),
  duration: 3,
  trip_id: trip.id
  )
Relationship.create!(parent_id: airbnb_montreal_event.id, child_id: bus_quebec_event.id)

visite_chateau_quebec_event = Event.create!(
  name: 'Visite Chateau',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,01),
  duration: 3,
  trip_id: trip.id
  )
Relationship.create!(parent_id: bus_quebec_event.id, child_id: visite_chateau_quebec_event.id)

hotel_quebec_event = Event.create!(
  name: 'Hôtel Quebec',
  category: 'Hébergement',
  # location: 'Washington',
  date: Date.new(2018,9,01),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: visite_chateau_quebec_event.id, child_id: hotel_quebec_event.id)

voiture_saguenay_event = Event.create!(
  name: 'Drive Saguenay',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 2,
  trip_id: trip.id
  )
Relationship.create!(parent_id: hotel_quebec_event.id, child_id: voiture_saguenay_event.id)

randonnee_event = Event.create!(
  name: 'Randonnée',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 5,
  trip_id: trip.id
  )
Relationship.create!(parent_id: voiture_saguenay_event.id, child_id: randonnee_event.id)

airbnb_saguenay_event = Event.create!(
  name: 'Airbnb Saguenay',
  category: 'Hébergement',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: randonnee_event.id, child_id: airbnb_saguenay_event.id)

voiture_montreal_event = Event.create!(
  name: 'Voiture Montréal',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,9,03),
  duration: 5,
  trip_id: trip.id
  )
Relationship.create!(parent_id: airbnb_saguenay_event.id, child_id: voiture_montreal_event.id)

retour_montreal_event = Event.create!(
  name: 'Retour Montréal',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,03),
  duration: 3,
  trip_id: trip.id
  )
Relationship.create!(parent_id: voiture_montreal_event.id, child_id: retour_montreal_event.id)

voiture_perce_event = Event.create!(
  name: 'Voiture Percé',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: retour_montreal_event.id, child_id: voiture_perce_event.id)

airbnb_perce_event = Event.create!(
  name: 'Airbnb Percé',
  category: 'Hébergement',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: voiture_perce_event.id, child_id: airbnb_perce_event.id)

bateau_perce_event = Event.create!(
  name: 'Bateau Bonne Aventure',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,03),
  duration: 3,
  trip_id: trip.id
  )
Relationship.create!(parent_id: airbnb_perce_event.id, child_id: bateau_perce_event.id)

voiture_toronto_event = Event.create!(
  name: 'Voiture Toronto',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,9,01),
  duration: 3,
  trip_id: trip.id
  )
Relationship.create!(parent_id: airbnb_montreal_event.id, child_id: voiture_toronto_event.id)

airbnb_toronto_event = Event.create!(
  name: 'Airbnb Toronto',
  category: 'Hébergement',
  # location: 'Washington',
  date: Date.new(2018,9,01),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: voiture_toronto_event.id, child_id: airbnb_toronto_event.id)

visite_toronto_event = Event.create!(
  name: 'Visite Toronto',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 3,
  trip_id: trip.id
  )
Relationship.create!(parent_id: airbnb_toronto_event.id, child_id: visite_toronto_event.id)

voiture_niagarafalls_event = Event.create!(
  name: 'Visite Niagara Falls',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 1,
  trip_id: trip.id
  )
Relationship.create!(parent_id: visite_toronto_event.id, child_id: voiture_niagarafalls_event.id)

visite_niagarafalls_event = Event.create!(
  name: 'Visite Niagara Falls',
  category: 'Activité',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 4,
  trip_id: trip.id
  )
Relationship.create!(parent_id: voiture_niagarafalls_event.id, child_id: visite_niagarafalls_event.id)

airbnb_toronto_2_event = Event.create!(
  name: 'Airbnb Toronto',
  category: 'Hébergement',
  # location: 'Washington',
  date: Date.new(2018,9,02),
  duration: 8,
  trip_id: trip.id
  )
Relationship.create!(parent_id: visite_niagarafalls_event.id, child_id: airbnb_toronto_2_event.id)

voiture_montreal_1_event = Event.create!(
  name: 'Voiture Montréal',
  category: 'Transport',
  # location: 'Washington',
  date: Date.new(2018,9,03),
  duration: 4,
  trip_id: trip.id
  )
Relationship.create!(parent_id: airbnb_toronto_2_event.id, child_id: voiture_montreal_1_event.id)


# DERNIERES RELATIONSHIPS AVEC END
Relationship.create!(parent_id: retour_montreal_event.id, child_id: event_end.id)
Relationship.create!(parent_id: bateau_perce_event.id, child_id: event_end.id)
Relationship.create!(parent_id: voiture_montreal_1_event.id, child_id: event_end.id)

puts 'Done!'
