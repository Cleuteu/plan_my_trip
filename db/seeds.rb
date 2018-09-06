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

puts 'Creating trips...'

trip = Trip.new(
    name: 'Surf trip Morocco',
    start_location: 'Essaouira',
    end_location: 'Essaouira',
    start_date: Date.new(2018,1,3),
    end_date: Date.new(2018,1,28)
  )
trip.user = user
trip.remote_photo_url = "http://www.epicgapyear.com/wp-content/uploads/2016/11/south-afriac-mozambique-surf-trip-adventure-surfing-camp-ticket-to-ride-gap-year.jpg"
trip.save!

trip2 = Trip.new(
    name: 'Journey to Italy',
    start_location: 'Venise',
    end_location: 'Venise',
    start_date: Date.new(2018,3,8),
    end_date: Date.new(2018,4,1)
  )
trip2.user = user
trip2.remote_photo_url = "https://images.unsplash.com/photo-1520874628750-bed9c0a19086"
trip2.save!

trip3 = Trip.new(
    name: 'Road trip Canada',
    start_location: 'Montreal',
    end_location: 'Montreal',
    start_date: Date.new(2018,9,20),
    end_date: Date.new(2018,9,24)
    # reset_password_token: '',
    # reset_password_sent_at: '',
    # remember_created_at: '',
    # created_at: ,
    # updated_at", null: false,
    # t.string "photo"
  )
trip3.user = user
trip3.remote_photo_url = "https://images.unsplash.com/photo-1519885277449-12eee5564d68"
trip3.save!

user_trip = UserTrip.new
user_trip.user = user
user_trip.trip = trip
user_trip.save!

puts 'Creating Canadian trip events ...'

#Pas pour positions x
a = 300
#En y
b = 150

event_start = Event.new(
                        position_x: 0,
                        position_y: -b,
                        name: "Start",
                        category: "Setting",
                        date: trip3.start_date,
                        location: trip3.start_location,
                        trip_id: trip3.id,
                        duration: 1,
                        price: 0,
                        master: true
                        )
event_start.save!
event_end = Event.new(
                      position_x: 0,
                      position_y: 12*b,
                      name: "End",
                      category: "Setting",
                      date: trip3.end_date,
                      location: trip3.end_location,
                      trip_id: trip3.id,
                      duration: 1,
                      price: 0,
                      master: true,
                      )
event_end.save!

flight_to_montreal = Event.create!(
  name: 'Flight to Montreal',
  category: 'Travel',
  confirmed: true,
  location: 'Montreal',
  date: Date.new(2018,9,20),
  duration: 1,
  description: "Your booking number is NBX87B and your check-in will take place at the counter number 23 on the 3rd floor of the airport. Do not forget to put ALL your liquids in your suitcase. At the arrival, you can contact John Dow's Taxi (+11907657654). It's the cheapest company in Montreal and the service is good.",
  url: "https://www.airfrance.fr/FR/fr/local/core/engine/mmb/MmbAction.do",
  trip_id: trip3.id,
  master: true,
  price: 350,
  position_x: 0,
  position_y: 0
  )
Relationship.create!(parent_id: event_start.id, child_id: flight_to_montreal.id)

visit_of_montreal = Event.create!(
  name: 'Visit of Montreal',
  category: 'Activity',
  confirmed: false,
  location: 'Montreal',
  date: Date.new(2018,9,21),
  duration: 3,
  description: "Marc Boutayer will be your guide. He has been living in the city since 1976 so he'll show you the best non-touristic places and adapt the journey to your expections. You could go up the Mont-Royal, eat poutine, visit one of the markets, browse the boutiques of the Mile End and visit Basilique Notre-Dame. Enjoy this wonderful city, the local people are really friendly and they love meeting foreign people.",
  url: "https://www.votretourdumonde.com/que-visiter-a-montreal/",
  trip_id: trip3.id,
  #photo: '';
  master: true,
  price: 0,
  position_x: 0,
  position_y: b
  )
Relationship.create!(parent_id: flight_to_montreal.id, child_id: visit_of_montreal.id)

airbnb_montreal_event = Event.create!(
  name: 'St Paul Youth Hostel',
  category: 'Accommodation',
  location: '1030 Rue Mackay, Montréal, QC H3G 2H1, Canada',
  date: Date.new(2018,9,21),
  duration: 8,
  description: "This Youth Hostel is in a nice downtown. You'll have everything you need and to collect the keys if you arrive after 10pm, you'll need to open the little box on the left of the front door. Code is 7942",
  url: "https://www.aubergesaint-paul.com/",
  trip_id: trip3.id,
  master: true,
  price: 67,
  position_x: 0,
  position_y: 2*b
  )
Relationship.create!(parent_id: visit_of_montreal.id, child_id: airbnb_montreal_event.id)

bus_quebec_event = Event.create!(
  name: 'Bus Quebec City',
  category: 'Travel',
  location: 'Montreal Bus Station',
  date: Date.new(2018,9,22),
  duration: 3,
  description: "You'll have to leave early to book the tickets. Not possible to do it online and or with a credit card at the counter of the company. This company provide free WiFi during the trip.",
  url: "http://www.gamtl.com/fr/Bienvenue/",
  trip_id: trip3.id,
  master: true,
  price: 45,
  position_x: -a,
  position_y: 3*b
  )
Relationship.create!(parent_id: airbnb_montreal_event.id, child_id: bus_quebec_event.id)

visite_chateau_quebec_event = Event.create!(
  name: 'Chateau Frontenac',
  category: 'Activity',
  location: '1 Rue des Carrières, Québec, QC G1R 4P5, Canada',
  date: Date.new(2018,9,22),
  duration: 3,
  description: "The Château Frontenac is one of Canada's grand railway hotels. The hotel is generally recognized as the most photographed hotel in the world, largely for its prominence in the skyline of Quebec City.",
  url: "https://www.fairmont.com/frontenac-quebec/",
  trip_id: trip3.id,
  master: true,
  price: 25,
  position_x: -a,
  position_y: 4*b
  )
Relationship.create!(parent_id: bus_quebec_event.id, child_id: visite_chateau_quebec_event.id)

hotel_quebec_event = Event.create!(
  name: 'Auberge Int.',
  category: 'Accommodation',
  location: '19 Rue Sainte-Ursule, Québec, QC G1R 4E1, Canada',
  date: Date.new(2018,9,22),
  duration: 8,
  description: "Our customers recommended this youth hostel. It has one of the best rooftop in the area and local beers. Breakfast is included and on the 22nd you'll be able to compete with other guests at the massive trivia quizz!",
  url: "http://aubergeinternationaledequebec.com/",
  trip_id: trip3.id,
  master: true,
  price: 55,
  position_x: -a,
  position_y: 5*b
  )
Relationship.create!(parent_id: visite_chateau_quebec_event.id, child_id: hotel_quebec_event.id)

voiture_saguenay_event = Event.create!(
  name: 'Bus to Saguenay',
  category: 'Travel',
  location: '320, rue Abraham-Martin, Québec, Québec, Canada, G1K 8N2',
  date: Date.new(2018,9,23),
  duration: 2,
  description: "You'll take the bus at the Gare du Palais. Built in 1915 by the Canadian Pacific Railway, the two-storey châteauesque station is similar in design to the Château Frontenac.",
  url: "https://www.quebecoriginal.com/fr-fr/fiche/transport-et-organismes-touristiques/autocar/gares-routieres-et-ferroviaires/gare-du-palais-terminus-dautobus-de-gare-du-palais-4500244",
  trip_id: trip3.id,
  master: true,
  price: 75,
  position_x: -2*a,
  position_y: 6*b
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
#   url: "",   trip_id: trip3.id,
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
  description: "Peter we'll be you're guide during this hike. He knows the best spots! It should take about 5 hours and you'll need to buy food in Saguenay to avoid buying expensive commercial food at the departure point.",
  url: "https://tourisme.saguenay.ca/fr/quoi-faire/sports-et-plein-air/randonnees-et-observation/randonnees-pedestres",
  trip_id: trip3.id,
  master: true,
  price: 10,
  position_x: -2*a,
  position_y: 7*b
  )
Relationship.create!(parent_id: voiture_saguenay_event.id, child_id: randonnee_event.id)

airbnb_saguenay_event = Event.create!(
  name: 'Saguenay Youth Hostel',
  category: 'Accommodation',
  location: '110 Rue Price O, Chicoutimi, QC G7J 1G8, Canada',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "In this youth hostel, you'll have a dormitory just for your group and will be able to enjoy the swimming pool in the basement 24/7. Feel free to ask the staff if you need any advice for the local restaurants.",
  url: "https://ajsaguenay.com/",
  trip_id: trip3.id,
  master: true,
  price: 45,
  position_x: -2*a,
  position_y: 8*b
  )
Relationship.create!(parent_id: randonnee_event.id, child_id: airbnb_saguenay_event.id)

# voiture_montreal_event = Event.create!(
#   name: 'Ride to Montreal',
#   category: 'Travel',
#   # location: 'Washington',
#   date: Date.new(2018,9,24),
#   duration: 5,
#   description: "We can easily book a car in Saguenay. It should not cost more than 75 euros",
#   url: "",
#   trip_id: trip3.id,
#   master: true,
#   price: 75,
#   position_x: -a,
#   position_y: 9*b
#   )

pub_crawl_event = Event.create!(
  name: 'Pub Crawl Night',
  category: 'Activity',
  location: '3979 Rue Saint-Denis, Montreal, Canada',
  date: Date.new(2018,9,24),
  duration: 3,
  description: "It's a local tradition to do a pub crawl on the 1st of November in Montreal!!! Here is the address of the Lockhart. It's only a suggestion but the staff is really friendly and you'll have a discount if say you come from our agency. The Traveling Wilburys will be playing this night.",
  url: "https://www.lockhartmtl.com/rservations",
  trip_id: trip3.id,
  master: true,
  price: 50,
  position_x: 0,
  position_y: 10*b
  )
# Relationship.create!(parent_id: voiture_montreal_event.id, child_id: pub_crawl_event.id)

voiture_perce_event = Event.create!(
  name: 'Ride to Percé',
  category: 'Travel',
  location: '1200 Rue Stanley, Montréal, QC H3B 2S8, Canada',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "We recommend you yo contact Alamo Rent a Car. They have the best quality per service deals in the area. You won't need any insurance if you subscribed to our global travel insurance.",
  url: "https://www.alamo.ca/fr_CA/car-rental/locations/ca/ymqc71-montreal-stanley-st.html?mcid=yext:245709",
  trip_id: trip3.id,
  price: 90,
  position_x: 0,
  position_y: 6*b
  )
Relationship.create!(parent_id: hotel_quebec_event.id, child_id: voiture_perce_event.id)

airbnb_perce_event = Event.create!(
  name: 'La Maison Rouge',
  category: 'Accommodation',
  location: '125 QC-132, Percé, QC G0C 2L0, Canada',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "Your stay at La Maison Rouge gives you access to all the facilities of the establishment such as the living room, the solarium, the terrace and the kitchen. You will also be near a lot of activities such as the Percé rock, Mount Sainte-Anne, Emerald River, Bonaventure Island, hiking trails, museums, theatres and more !",
  url: "https://lamaisonrouge.ca/fr/index.html",
  trip_id: trip3.id,
  price: 76,
  position_x: 0,
  position_y: 7*b
  )
Relationship.create!(parent_id: voiture_perce_event.id, child_id: airbnb_perce_event.id)

bateau_perce_event = Event.create!(
  name: 'Bonaventure Island',
  category: 'Activity',
  location: '9 Rue du Quai, Percé, QC G0C 2L0, Canada',
  date: Date.new(2018,9,23),
  duration: 3,
  description: "Julien Cloutier will take you to the Bonaventure Island with his boat. 218 different species of birds have been recorded as visiting, migrating to, or living on Bonaventure island. The most common bird found on the island is the northern gannet. The island is home to one of the largest colonies of gannets in the world, with 51,700 pairs in 2011. Located in the island’s reception area, the restaurant of Parc national de l'île-Bonaventure-et-du-Rocher-Percé, Resto des Margaulx, offers a wholesome menu with a maritime spirit.",
  url: "https://www.sepaq.com/pq/bon/index.dot?language_id=2",
  trip_id: trip3.id,
  price: 17,
  position_x: 0,
  position_y: 8*b
  )
Relationship.create!(parent_id: airbnb_perce_event.id, child_id: bateau_perce_event.id)

voiture_toronto_event = Event.create!(
  name: 'Ride to Toronto',
  category: 'Travel',
  # location: 'Washington',
  date: Date.new(2018,9,22),
  duration: 3,
  description: "We recommend you to make a quick stop at St Lewis Village along the way. It's a must see! The legend says it was Neil Young's haven of peace.",
  url: "",
  trip_id: trip3.id,
  price: 35,
  position_x: a,
  position_y: 3*b
  )
Relationship.create!(parent_id: airbnb_montreal_event.id, child_id: voiture_toronto_event.id)

airbnb_toronto_event = Event.create!(
  name: 'All Days Hostel',
  category: 'Accommodation',
  location: '5 Selby St, Toronto, ON M4Y 1W3, Canada',
  date: Date.new(2018,9,22),
  duration: 8,
  description: "Pick up the keys at the laundry on the ground floor if you arrive after 10pm",
  url: "https://www.alldayshostel.com/",
  trip_id: trip3.id,
  price: 69,
  position_x: a,
  position_y: 4*b
  )
Relationship.create!(parent_id: voiture_toronto_event.id, child_id: airbnb_toronto_event.id)

visite_toronto_event = Event.create!(
  name: 'Visit Toronto',
  category: 'Activity',
  location: 'Toronto',
  date: Date.new(2018,9,23),
  duration: 3,
  description: "Our suggestions: the unique Bata Shoe Museum, the Royal Ontario Museum (ROM),St Lawrence Market and the the CN Tower.",
  url: "https://everynationgta.org/2018/the-5-things-you-need-to-do-in-toronto/?gclid=CjwKCAjwzqPcBRAnEiwAzKRgS5GK56BLLezHApq-SVPF1vPeGGcLTMLd9c7k2krrBb5gkrtwvTfrGxoCc6oQAvD_BwE",
  trip_id: trip3.id,
  price: 0,
  position_x: a,
  position_y: 5*b
  )
Relationship.create!(parent_id: airbnb_toronto_event.id, child_id: visite_toronto_event.id)

voiture_niagarafalls_event = Event.create!(
  name: 'Ride Niagara Falls',
  category: 'Activity',
  location: 'Toronto',
  date: Date.new(2018,9,23),
  duration: 1,
  description: "You can either keep the car you used or ride motorbikes you can rent everywhere. The ride shouldn't take you more than 1h30.",
  url: "",
  trip_id: trip3.id,
  price: 24,
  position_x: a,
  position_y: 6*b
  )
Relationship.create!(parent_id: visite_toronto_event.id, child_id: voiture_niagarafalls_event.id)

visite_niagarafalls_event = Event.create!(
  name: 'Niagara Falls',
  category: 'Activity',
  location: 'Niagara Falls',
  date: Date.new(2018,9,23),
  duration: 4,
  description: "Niagara Falls is a geological wonder and one of the most famous waterfalls in the world. Straddling the border between the United States and Canada, it has been a popular tourist attraction for over 200 years, as well as a major source of hydroelectric power.  ",
  url: "https://fr.niagarafallstourism.com/",
  trip_id: trip3.id,
  price: 8,
  position_x: a,
  position_y: 7*b
  )
Relationship.create!(parent_id: voiture_niagarafalls_event.id, child_id: visite_niagarafalls_event.id)

airbnb_toronto_2_event = Event.create!(
  name: 'All Days Hostel',
  category: 'Accommodation',
  location: 'Pick up the keys at the laundry on the ground floor if you arrive after 10pm',
  date: Date.new(2018,9,23),
  duration: 8,
  description: "5 Selby St, Toronto, ON M4Y 1W3, Canada",
  url: "https://www.alldayshostel.com/",
  trip_id: trip3.id,
  price: 84,
  position_x: a,
  position_y: 8*b
  )
Relationship.create!(parent_id: visite_niagarafalls_event.id, child_id: airbnb_toronto_2_event.id)

ride_back_montreal_event = Event.create!(
  name: 'Back to Montréal',
  category: 'Travel',
  location: 'Toronto Train Station, ON M5J 1E6, Canada',
  date: Date.new(2018,9,24),
  duration: 4,
  description: "At this time you'll be exhausted, so we recommend you to take the train",
  url: "https://torontounion.ca/",
  trip_id: trip3.id,
  price: 38,
  master: true,
  position_x: 0,
  position_y: 9*b
  )
Relationship.create!(parent_id: airbnb_toronto_2_event.id, child_id: ride_back_montreal_event.id)

back_flight_event = Event.create!(
  name: 'Flight back Paris',
  category: 'Travel',
  location: 'Airport Montreal, Canada',
  date: Date.new(2018,9,24),
  duration: 3,
  description: "Time to come back to work. Your booking number is TH8CKL and your check-in will take place at the counter number 12 on the 1st floor of the airport. We hope you enjoyed your trip and our service. Feel free to send us some pictures :)",
  url: "https://www.airfrance.fr/FR/fr/local/core/engine/mmb/MmbAction.do",
  trip_id: trip3.id,
  master: true,
  price: 0,
  position_x: 0,
  position_y: 11*b
  )

Relationship.create!(parent_id: pub_crawl_event.id, child_id: back_flight_event.id)
Relationship.create!(parent_id: back_flight_event.id, child_id: event_end.id)


# DERNIERES RELATIONSHIPS AVEC END

# nuit_25_event = Event.create!(
#   name: 'Night of September 25th',
#   category: 'Accommodation',
#   location: 'Toronto',
#   date: Date.new(2018,9,25),
#   duration: 4,
#   description: "Where will I sleep?",
#   url: "",
#   trip_id: trip3.id,
#   price: 0
  # )
# Relationship.create!(parent_id: pub_crawl_event.id, child_id: nuit_25_event.id)


# nuit_26_event = Event.create!(
#   name: 'Night of September 26th',
#   category: 'Accommodation',
#   location: 'Toronto',
#   date: Date.new(2018,9,26),
#   duration: 4,
#   description: "Where will I sleep?",
#   url: "",
#   trip_id: trip3.id,
#   price: 0
#   )
# Relationship.create!(parent_id: nuit_25_event.id, child_id: nuit_26_event.id)

# nuit_27_event = Event.create!(
#   name: 'Night of September 27th',
#   category: 'Accommodation',
#   location: 'Toronto',
#   date: Date.new(2018,9,27),
#   duration: 4,
#   description: "Where will I sleep?",
#   url: "",
#   trip_id: trip3.id,
#   price: 0
#   )
# Relationship.create!(parent_id: nuit_26_event.id, child_id: nuit_27_event.id)

# nuit_28_event = Event.create!(
#   name: 'Night of September 28th',
#   category: 'Accommodation',
#   location: 'Toronto',
#   date: Date.new(2018,9,28),
#   duration: 4,
#   description: "Where will I sleep?",
#   url: "",
#   trip_id: trip3.id,
#   price: 0
#   )
# # Relationship.create!(parent_id: nuit_27_event.id, child_id: nuit_28_event.id)
# Relationship.create!(parent_id: nuit_25_event.id, child_id: event_end.id)




Relationship.create!(parent_id: bateau_perce_event.id, child_id: ride_back_montreal_event.id)
Relationship.create!(parent_id: airbnb_saguenay_event.id, child_id: ride_back_montreal_event.id)
Relationship.create!(parent_id: ride_back_montreal_event.id, child_id: pub_crawl_event.id)

puts 'Done!'
