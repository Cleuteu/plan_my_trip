class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:add_branch_relationship]

  def create
    @event = Event.new(event_params)
    @trip = Trip.find(params[:trip_id])
    authorize @event
    @event.trip_id = @trip.id
    @parent_id = params[:event][:parent_ids]
    @parent_event = Event.find(@parent_id)
    @child_id = params[:event][:child_ids]
    @child_event = Event.find(@child_id)

    #Création de la position et update des positions des descendants
      a = 300 #Pas en x
      b = 150 #Pas en y
    #Position de l'event créé
    event_position_y = @parent_event.position_y + b
    events = Event.where("position_y >= ?", event_position_y)
    @event.position_y = event_position_y
    #Positions des events descendants
    #Si nouvelle branche:
    bool = Relationship.where(parent_id: @parent_id, child_id: @child_id).empty?
    if bool
      # @parent_event.position_x > 0? a = 300 : a = -300
      if Event.where("position_x = ? AND position_y = ?", @parent_event.position_x + a, @event.position_y).empty?
        @event.position_x = @parent_event.position_x + a
        # events_x = Event.where("position_y >= ? AND position_y < ?", event_position_y, @child_event.position_y)
        # events_x.each { |event| event.update!(position_x: event.position_x - a) }
      elsif Event.where("position_x = ? AND position_y = ?", @parent_event.position_x - a, @event.position_y).empty?
        @event.position_x = @parent_event.position_x - a
        # events_x = Event.where("position_y >= ? AND position_y < ?", event_position_y, @child_event.position_y)
        # events_x.each { |event| event.update!(position_x: event.position_x + a) }
      else
        flash[:alert] = "Can't add an event here, sorry!"
        render 'trips/show'
      end
    #Si branche exitante - mono branche
    else

      @event.position_x = @parent_event.position_x
      events.each { |event| event.update!(position_y: event.position_y + b) }
    # Détection de master
    @event.master = true if @parent_event.master == true && @child_event.master == true
    end
    if @event.save!
      @relationship = Relationship.create!(parent_id: @parent_id, child_id: @event.id)
      unless bool
        @relationship = Relationship.create!(parent_id: @event.id, child_id: @child_id)
        Relationship.destroy(Relationship.where(parent_id: @parent_id, child_id: @child_id).first.id)
      end
      redirect_to trip_path(@trip)
    else
      render './trips/show'
    end
  end

   def update
    @event = Event.find(params[:id])
    @trip = Trip.find(params[:trip_id])

    if @event.update!(event_params)
      redirect_to trip_path(@trip)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @trip = Trip.find(params[:trip_id])
    @event_parent = Relationship.where(child: @event).first.parent
    @event_child = Relationship.where(parent: @event).first.child

    if Relationship.where(parent: @event).count + Relationship.where(child: @event).count >= 3
      flash[:alert] = "Cant delete this event!"
      redirect_to trip_path(@trip)
    else
      Relationship.create!(parent_id: @event_parent.id, child_id: @event_child.id)
      Relationship.destroy(Relationship.where(parent_id: @event_parent.id, child_id: @event.id).first.id)
      Relationship.destroy(Relationship.where(parent_id: @event.id, child_id: @event_child.id).first.id)
      @event.destroy!
      flash[:success] = "Event deleted"
      redirect_to trip_path(@trip)
    end
  end

  def switch_master
    @event = Event.find(params[:id])
    @trip= Trip.find(@event.trip_id)

    master_nodes = []
    unmaster_nodes = []

    if @event.relationships_as_parent.first.child.master
      master_child_event = @event.relationships_as_parent.first.child
      unmaster_child_event = @event.relationships_as_parent[1].child
    else
      unmaster_child_event = @event.relationships_as_parent.first.child
      master_child_event = @event.relationships_as_parent[1].child
    end

    #Activation master
    while unmaster_child_event.master == false
      unmaster_nodes << unmaster_child_event
      unmaster_child_event = unmaster_child_event.relationships_as_parent.first.child
    end
    unmaster_nodes << unmaster_child_event


    #Désactivation de la master
    while master_child_event.master && unmaster_nodes.exclude?(master_child_event)
      master_nodes << master_child_event
      if master_child_event.relationships_as_parent.first.child.master
        master_child_event = master_child_event.relationships_as_parent.first.child
      else
        master_child_event = master_child_event.relationships_as_parent[1].child
      end
    end

    master_nodes.each { |event| event.update!(master: false) }
    unmaster_nodes.each { |event| event.update!(master: true) }

    redirect_to trip_path(@trip)
  end

  def add_branch_relationship
    raise
  end

  private

  def event_params
    params.require(:event).permit(:name, :category, :confirmed, :location, :date, :duration, :description, :url, :price, :master, :photo)
  end
end
