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
    first_name: 'Alex',
    last_name: 'Marichal',
    email: 'alex@alex.com',
    password: 'aaaaaa'
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
    start_location: 'Montreal',
    end_location: 'Dallas, USA',
    start_date: Date.new(2018,9,20),
    end_date: Date.new(2018,9,24)
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

event_start = Event.new(name: "Start", category: "settings", date: trip.start_date, location: trip.start_location, trip_id: trip.id, duration: 1, price: 0, master: true)
event_start.save!
event_end = Event.new(name: "End", category: "settings", date: trip.end_date, location: trip.end_location, trip_id: trip.id, duration: 1, price: 0, master: true)
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

flight_to_montreal = Event.create!(
  name: 'Flight to Montreal',
  category: 'Travel',
  confirmed: true,
  location: 'Montreal',
  date: Date.new(2018,9,20),
  duration: 1,
  description: "Our booking number is NBX87B. Please guys, this time do not forget to put ALL your liquids in your suitcase. Not like last time...",
  url: "https://www.airfrance.fr/FR/fr/local/core/engine/mmb/MmbAction.do",
  trip_id: trip.id,
  master: true,
  price: 350
  )
Relationship.create!(parent_id: event_start.id, child_id: flight_to_montreal.id)

visit_of_montreal = Event.create!(
  name: 'Visit of Montreal',
  category: 'Activity',
  confirmed: false,
  location: 'Montreal',
  date: Date.new(2018,9,21),
  duration: 3,
  description: "Marc Marichal will be our guide. He has been living in the city since 2010 so he'll show us the best non-touristic places. We could go up the Mont-Royal, eat poutine, visit one of the markets, browse the boutiques of the Mile End and visit Basilique Notre-Dame ",
  url: "https://www.votretourdumonde.com/que-visiter-a-montreal/",
  trip_id: trip.id,
  master: true,
  price: 0
  )
Relationship.create!(parent_id: flight_to_montreal.id, child_id: visit_of_montreal.id)

airbnb_montreal_event = Event.create!(
  name: 'Airbnb Montreal',
  category: 'Accommodation',
  location: '1030 Rue Mackay, Montréal, QC H3G 2H1, Canada',
  date: Date.new(2018,9,21),
  duration: 8,
  description: "Our Airbnb is in a nice downtown. We have everything we need and to collect the keys, we'll need to open the little box on the left of the front door. Code is 7942",
  url: "https://www.airbnb.fr/rooms/plus/11008204?location=montreal&search_id=54eef90d-2111-4dda-91e8-2235119e426e&federated_search_id=9c698e08-41c4-4da7-913e-1ff56f42e132",
  trip_id: trip.id,
  master: true,
  price: 67
  )
Relationship.create!(parent_id: visit_of_montreal.id, child_id: airbnb_montreal_event.id)

bus_quebec_event = Event.create!(
  name: 'Bus Quebec City',
  category: 'Travel',
  location: 'Montreal Bus Station',
  date: Date.new(2018,9,22),
  duration: 3,
  description: "We have to leave early to book the tickets. Not possible to do it online and we need cash to pay.",
  url: "http://www.gamtl.com/fr/Bienvenue/",
  trip_id: trip.id,
  master: true,
  price: 45
  )
Relationship.create!(parent_id: airbnb_montreal_event.id, child_id: bus_quebec_event.id)

visite_chateau_quebec_event = Event.create!(
  name: 'Visit Chateau Frontenac',
  category: 'Activity',
  # location: 'Washington',
  date: Date.new(2018,9,22),
  duration: 3,
  description: "The Château Frontenac is one of Canada's grand railway hotels. The hotel is generally recognized as the most photographed hotel in the world, largely for its prominence in the skyline of Quebec City.",
  url: "https://www.fairmont.com/frontenac-quebec/",
  trip_id: trip.id,
  master: true,
  price: 25
  )
Relationship.create!(parent_id: bus_quebec_event.id, child_id: visite_chateau_quebec_event.id)

hotel_quebec_event = Event.create!(
  name: 'Auberge Int.',
  category: 'Accommodation',
  location: '19 Rue Sainte-Ursule, Québec, QC G1R 4E1, Canada',
  date: Date.new(2018,9,22),
  duration: 8,
  description: "Kevin recommended this youth hostel. It has one of the best rooftop in the area and local beers.",
  url: "http://aubergeinternationaledequebec.com/",
  trip_id: trip.id,
  master: true,
  price: 55
  )
Relationship.create!(parent_id: visite_chateau_quebec_event.id, child_id: hotel_quebec_event.id)

voiture_saguenay_event = Event.create!(
  name: 'Bus to Saguenay',
  category: 'Travel',
  location: '320, rue Abraham-Martin, Québec, Québec, Canada, G1K 8N2',
  date: Date.new(2018,9,23),
  duration: 2,
  description: "Leaving from the Gare du Palais. Built in 1915 by the Canadian Pacific Railway, the two-storey châteauesque station is similar in design to the Château Frontenac.",
  url: "https://www.quebecoriginal.com/fr-fr/fiche/transport-et-organismes-touristiques/autocar/gares-routieres-et-ferroviaires/gare-du-palais-terminus-dautobus-de-gare-du-palais-4500244",
  trip_id: trip.id,
  master: true,
  price: 75
  )

# Activer pour seed qui fonctionne
Relationship.create!(parent_id: hotel_quebec_event.id, child_id: voiture_saguenay_event.id)


# #Activer pour seed qui ne fonctionne pas
# phoques_event = Event.create!(
#   name: 'Seals diving',
#   category: 'Activity',
#   # location: 'Washington',
#   date: Date.new(2018,9,02),
#   duration: 2,
#
# description: "",
#   url: "",   trip_id: trip.id,
#   master: true
#   )

# Relationship.create!(parent_id: hotel_quebec_event.id, child_id: phoques_event.id)

# Relationship.create!(parent_id: phoques_event.id, child_id: voiture_saguenay_event.id)

randonnee_event = Event.create!(
  name: 'Hiking',
  category: 'Activity',
  location: 'Saguenay Quebec',
  date: Date.new(2018,9,23),
  duration: 5,
  description: "It should take about 5 hours and we need to buy food in Saguenay",
  url: "",
  trip_id: trip.id,
  master: true,
  price: 10
  )
Relationship.create!(parent_id: voiture_saguenay_event.id, child_id: randonnee_event.id)

airbnb_saguenay_event = Event.create!(
  name: 'Airbnb Saguenay',
  category: 'Accommodation',
  location: '110 Rue Price O, Chicoutimi, QC G7J 1G8, Canada',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "Paul will be there to give us the keys",
  url: "https://www.airbnb.fr/rooms/773017",
  trip_id: trip.id,
  master: true,
  price: 45
  )
Relationship.create!(parent_id: randonnee_event.id, child_id: airbnb_saguenay_event.id)

voiture_montreal_event = Event.create!(
  name: 'Ride to Montreal',
  category: 'Travel',
  # location: 'Washington',
  date: Date.new(2018,9,24),
  duration: 5,
  description: "We can easily book a car in Saguenay. It should not cost more than 75 euros",
  url: "",
  trip_id: trip.id,
  master: true,
  price: 75
  )

retour_montreal_event = Event.create!(
  name: 'Montreal Pub Crawl Night',
  category: 'Activity',
  location: '3979 Rue Saint-Denis, Montreal, Canada',
  date: Date.new(2018,9,24),
  duration: 3,
  description: "It's a local tradition to do a pub crawl on the 1st of November !!!",
  url: "https://www.lockhartmtl.com/rservations",
  trip_id: trip.id,
  master: true,
  price: 50
  )
Relationship.create!(parent_id: voiture_montreal_event.id, child_id: retour_montreal_event.id)

voiture_perce_event = Event.create!(
  name: 'Ride to Percé',
  category: 'Travel',
  location: '1200 Rue Stanley, Montréal, QC H3B 2S8, Canada',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "We booked a nice Audi at Alamo Rent a Car",
  url: "https://www.alamo.ca/fr_CA/car-rental/locations/ca/ymqc71-montreal-stanley-st.html?mcid=yext:245709",
  trip_id: trip.id,
  price: 90
  )
Relationship.create!(parent_id: hotel_quebec_event.id, child_id: voiture_perce_event.id)

airbnb_perce_event = Event.create!(
  name: 'Airbnb Percé',
  category: 'Accommodation',
  location: '125 QC-132, Percé, QC G0C 2L0, Canada',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "It's next to the La Maison Rouge Youth Hostel so we'll be able to meet a lot of people",
  url: "https://www.airbnb.fr/rooms/10546184?location=Perc%C3%A9%2C%20QC%2C%20Canada&search_id=d17d0a05-c71e-4d6f-a403-fdce94e8933c&federated_search_id=e005b1e9-cc30-4659-b380-0b8346989c8f",
  trip_id: trip.id,
  price: 76
  )
Relationship.create!(parent_id: voiture_perce_event.id, child_id: airbnb_perce_event.id)

bateau_perce_event = Event.create!(
  name: 'Bonaventure Island',
  category: 'Activity',
  location: '9 Rue du Quai, Percé, QC G0C 2L0, Canada',
  date: Date.new(2018,9,23),
  duration: 3,
  description: "Julien Cloutier will take us to the Bonaventure Island with his boat. 218 different species of birds have been recorded as visiting, migrating to, or living on Bonaventure island. The most common bird found on the island is the northern gannet. The island is home to one of the largest colonies of gannets in the world, with 51,700 pairs in 2011.",
  url: "https://www.sepaq.com/pq/bon/index.dot?language_id=2",
  trip_id: trip.id,
  price: 17
  )
Relationship.create!(parent_id: airbnb_perce_event.id, child_id: bateau_perce_event.id)

voiture_toronto_event = Event.create!(
  name: 'Ride to Toronto',
  category: 'Travel',
  # location: 'Washington',
  date: Date.new(2018,9,22),
  duration: 3,
  description: "We need to make a quick stop at St Lewis Village along the way.",
  url: "",
  trip_id: trip.id,
  price: 35
  )
Relationship.create!(parent_id: airbnb_montreal_event.id, child_id: voiture_toronto_event.id)

airbnb_toronto_event = Event.create!(
  name: 'Airbnb Toronto',
  category: 'Accommodation',
  location: '5 Selby St, Toronto, ON M4Y 1W3, Canada',
  date: Date.new(2018,9,22),
  duration: 8,
  description: "Pick up the keys at the laundry",
  url: "https://www.airbnb.fr/rooms/plus/10521800?location=Toronto%2C%20ON%2C%20Canada&children=0&guests=1&search_id=7617340e-4a5a-42d1-9dfe-5bf6dc2c805a&federated_search_id=e83c328e-9116-4ebb-8f33-04a6716eb18f",
  trip_id: trip.id,
  price: 69
  )
Relationship.create!(parent_id: voiture_toronto_event.id, child_id: airbnb_toronto_event.id)

visite_toronto_event = Event.create!(
  name: 'Visit Toronto',
  category: 'Activity',
  location: 'Toronto',
  date: Date.new(2018,9,23),
  duration: 3,
  description: "We need to choose among the unique Bata Shoe Museum, the Royal Ontario Museum (ROM),St Lawrence Market and the the CN Tower.",
  url: "https://everynationgta.org/2018/the-5-things-you-need-to-do-in-toronto/?gclid=CjwKCAjwzqPcBRAnEiwAzKRgS5GK56BLLezHApq-SVPF1vPeGGcLTMLd9c7k2krrBb5gkrtwvTfrGxoCc6oQAvD_BwE",
  trip_id: trip.id,
  price: 0
  )
Relationship.create!(parent_id: airbnb_toronto_event.id, child_id: visite_toronto_event.id)

voiture_niagarafalls_event = Event.create!(
  name: 'Ride Niagara Falls',
  category: 'Activity',
  location: 'Toronto',
  date: Date.new(2018,9,23),
  duration: 1,
  description: "We can either keep the car we used or ride motorbikes",
  url: "",
  trip_id: trip.id,
  price: 24
  )
Relationship.create!(parent_id: visite_toronto_event.id, child_id: voiture_niagarafalls_event.id)

visite_niagarafalls_event = Event.create!(
  name: 'Visite Niagara Falls',
  category: 'Activity',
  location: 'Niagara Falls',
  date: Date.new(2018,9,23),
  duration: 4,
  description: "I'm so excited about this visit !!! Take your gopro Tom !",
  url: "https://fr.niagarafallstourism.com/",
  trip_id: trip.id,
  price: 8
  )
Relationship.create!(parent_id: voiture_niagarafalls_event.id, child_id: visite_niagarafalls_event.id)

airbnb_toronto_2_event = Event.create!(
  name: 'Airbnb Toronto 2',
  category: 'Accommodation',
  location: 'Pick up the keys at the laundry',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "5 Selby St, Toronto, ON M4Y 1W3, Canada",
  url: "https://www.airbnb.fr/rooms/plus/10521800?location=Toronto%2C%20ON%2C%20Canada&children=0&guests=1&search_id=7617340e-4a5a-42d1-9dfe-5bf6dc2c805a&federated_search_id=e83c328e-9116-4ebb-8f33-04a6716eb18f",
  trip_id: trip.id,
  price: 84
  )
Relationship.create!(parent_id: visite_niagarafalls_event.id, child_id: airbnb_toronto_2_event.id)

voiture_montreal_1_event = Event.create!(
  name: 'Ride back to Montréal',
  category: 'Travel',
  location: 'Toronto',
  date: Date.new(2018,9,24),
  duration: 4,
  description: "We'll be exhausted, let's take a better car this time",
  url: "",
  trip_id: trip.id,
  price: 38
  )
Relationship.create!(parent_id: airbnb_toronto_2_event.id, child_id: voiture_montreal_1_event.id)


# DERNIERES RELATIONSHIPS AVEC END

nuit_25_event = Event.create!(
  name: 'Night of September 25th',
  category: 'Accommodation',
  location: 'Toronto',
  date: Date.new(2018,9,25),
  duration: 4,
  description: "Where will I sleep?",
  url: "",
  trip_id: trip.id,
  price: 0
  )
Relationship.create!(parent_id: retour_montreal_event.id, child_id: nuit_25_event.id)


nuit_26_event = Event.create!(
  name: 'Night of September 26th',
  category: 'Accommodation',
  location: 'Toronto',
  date: Date.new(2018,9,26),
  duration: 4,
  description: "Where will I sleep?",
  url: "",
  trip_id: trip.id,
  price: 0
  )
Relationship.create!(parent_id: nuit_25_event.id, child_id: nuit_26_event.id)

nuit_27_event = Event.create!(
  name: 'Night of September 27th',
  category: 'Accommodation',
  location: 'Toronto',
  date: Date.new(2018,9,27),
  duration: 4,
  description: "Where will I sleep?",
  url: "",
  trip_id: trip.id,
  price: 0
  )
Relationship.create!(parent_id: nuit_26_event.id, child_id: nuit_27_event.id)

nuit_28_event = Event.create!(
  name: 'Night of September 28th',
  category: 'Accommodation',
  location: 'Toronto',
  date: Date.new(2018,9,28),
  duration: 4,
  description: "Where will I sleep?",
  url: "",
  trip_id: trip.id,
  price: 0
  )
Relationship.create!(parent_id: nuit_27_event.id, child_id: nuit_28_event.id)
Relationship.create!(parent_id: nuit_28_event.id, child_id: event_end.id)




Relationship.create!(parent_id: bateau_perce_event.id, child_id: voiture_montreal_1_event.id)
Relationship.create!(parent_id: airbnb_saguenay_event.id, child_id: voiture_montreal_1_event.id)
Relationship.create!(parent_id: voiture_montreal_1_event.id, child_id: retour_montreal_event.id)


puts 'Done!'
