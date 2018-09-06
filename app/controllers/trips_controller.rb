class TripsController < ApplicationController
  before_action :set_trip, only: [:show]
  skip_before_action :authenticate_user!, only: [:calendar]

  def index
    @trips = policy_scope(Trip).order(created_at: :desc)
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    authorize @trip
    if @trip.save
      @start = Event.new(name: "Start", category: "settings", date: @trip.start_date, location: @trip.start_location, trip_id: @trip.id, duration: 1, price: 0, master: true)
      @start.save!
      @end = Event.new(name: "End", category: "settings", date: @trip.end_date, location: @trip.end_location, trip_id: @trip.id, duration: 1, price: 0, master: true)
      @end.save!
      Relationship.create!(parent_id: @start.id, child_id: @end.id)
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end


  def show
    @trip = Trip.find(params[:id])

    #Pour calendar
    respond_to do |format|
      format.html do
        @event = Event.new
        @events_parents = Event.where(trip_id: @trip.id).where(id: Relationship.pluck(:parent_id))
        @events_children = Event.where(trip_id: @trip.id).where(id: Relationship.pluck(:child_id))
        @start_event = Event.find_by(name: 'Start')
        @end_event = Event.find_by(name: 'End')

        # Envoie des datas au JS de Cytoscape
        @relationships = Relationship.where(parent: @trip.events)
        @array_relationships = []
        @array_nodes = []
        @array_nodes << {
                          id: @start_event.id,
                          name: @start_event.name,
                          category: @start_event.category,
                          master: @start_event.master,
                          position_x: 0,
                          position_y: -150
                        }
        @array_nodes << {
                          id: @end_event.id,
                          name: @end_event.name,
                          category: @end_event.category,
                          master: @end_event.master,
                          position_x: 0,
                          position_y: @end_event.position_y
                        }

        hash_relationship = {}
        hash_nodes = {}
        @relationships.each do |relationship|
          hash_relationship[:child_id] = Event.find(relationship.child_id).id
          hash_relationship[:child_name] = Event.find(relationship.child_id).name
          hash_relationship[:parent_id] = Event.find(relationship.parent_id).id
          hash_relationship[:parent_name] = Event.find(relationship.parent_id).name
          if Event.find(relationship.child_id).master == true && Event.find(relationship.parent_id).master == true
            hash_relationship[:master] = "true"
          else
            hash_relationship[:master] = "false"
          end
          @array_relationships << hash_relationship
          hash_relationship = {}
          unless @array_nodes.include?(relationship.child_id)
            event = Event.find(relationship.child_id)
            hash_nodes[:id] = event.id
            hash_nodes[:name] = event.name
            hash_nodes[:category] = event.category
            hash_nodes[:master] = event.master.to_s
            hash_nodes[:no_child] = 'no_child' if event.relationships_as_parent.count == 0
            hash_nodes[:position_x] = event.position_x
            hash_nodes[:position_y] = event.position_y
            if event.relationships_as_parent.count >= 2 && event.master
              hash_nodes[:switch] = 1
              comp_x = event.relationships_as_parent[1].child.position_x - event.relationships_as_parent.first.child.position_x
              #Si 1er enfant à gauche
              if comp_x > 0
                #Et 1er enfant master
                event.relationships_as_parent.first.child.master ? hash_nodes[:switch_state] = "left" : hash_nodes[:switch_state] = "right"
                #Si 1er enfant à droite
              else
                #Et 1er enfant master
                event.relationships_as_parent.first.child.master ? hash_nodes[:switch_state] = "right" : hash_nodes[:switch_state] = "left"
              end
            else
              hash_nodes[:switch] = 0
            end

            @array_nodes << hash_nodes
            hash_nodes = {}
          end
        end

        @array_nodes_toggle = []
        Event.all.each { |event| @array_nodes_toggle << event if event.relationships_as_parent.count >= 2 }

        # Afficher les events masters dans le récapitulatif
        @events_master = Event.where(trip_id: @trip.id).where(master: true).order(:date)
        @total_price = 0
        @events_master.each { |event| @total_price += event.price if event.price.present?}

        # Pour afficher sur la trip-show la map avec des points sur chaque event
        @map_events = Event.where.not(latitude: nil, longitude: nil).where(master: true).order(:date)
        @markers = @map_events.map do |event|
          {
            lat: event.latitude,
            lng: event.longitude,
            infoWindow: { content: render_to_string(partial: "/events/map_box", locals: { event: event }) }
          }
        end
      end
      format.ics do
        calendar = @trip.calendar
        calendar.publish
        send_data calendar.to_ical, filename: "#{@trip.name}.ics"
      end
      # format.json do
      #   render json: @trip
      # end
      # format.xml do
      #   render xml: @trip.as_json, root: 'trip'
      # end
    end
  end

    def final
      @trip = Trip.find(params[:trip_id])
      @trip.user = current_user
      @events_master = Event.where(trip_id: @trip.id).where(master: true).order(:date)
      @map_events = Event.where.not(latitude: nil, longitude: nil).where(master: true)
      @markers = @map_events.map do |event|
        {
          lat: event.latitude,
          lng: event.longitude,
          infoWindow: { content: render_to_string(partial: "/events/map_box", locals: { event: event }) }
        }
      end
    end


  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :start_location, :end_location, :photo)
  end
end
