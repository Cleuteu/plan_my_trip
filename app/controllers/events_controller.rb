class EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    @trip = Trip.find(params[:trip_id])
    authorize @event
    @event.trip_id = @trip.id
    @parent_id = params[:event][:parent_ids]
    @child_id = params[:event][:child_ids]
    @parent_event = Event.find(@parent_id)

    #Création de la position et update des positions des descendants
    #Position de l'event créé
    event_position_y = @parent_event.position_y + 150
    @events = Event.where("position_y >= ?", event_position_y)
    @event.position_y = event_position_y
    #Positions des events descendants
    #Si nouvelle branche:
    if Relationship.where(parent_id: @parent_id, child_id: @child_id).empty?
      # @parent_event.position_x > 0? a = 300 : a = -300
      a = 300
      if Event.where("position_x = ? AND position_y = ?", @parent_event.position_x + a, @event.position_y).empty?
        @event.position_x = @parent_event.position_x + a
      elsif Event.where("position_x = ? AND position_y = ?", @parent_event.position_x - a, @event.position_y).empty?
        @event.position_x = @parent_event.position_x - a
      else
        raise
      end
    #Si branche exitante - mono branche
    else
      @event.position_x = @parent_event.position_x
      @events.each { |event| event.update!(position_y: event.position_y + 150) }
    end


    if @event.save!
      @relationship = Relationship.create!(parent_id: @parent_id, child_id: @event.id)
      @relationship = Relationship.create!(parent_id: @event.id, child_id: @child_id)
      unless Relationship.where(parent_id: @parent_id, child_id: @child_id).empty?
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

    #Changement de l'état master
    #Activation master
    if event_params[:master] == "1"
      parent_parent_count = @event.relationships_as_child.count
      parent_child_count = @event.relationships_as_child.count
      child_child_count =  @event.relationships_as_parent.count
      child_parent_count = @event.relationships_as_child.count
      parent_event = @event
      child_event = @event
      while (parent_parent_count == 1 && parent_child_count == 1)
        #Remonte la branche
        parent_event = parent_event.relationships_as_child.first.parent
        parent_parent_count = parent_event.relationships_as_child.count
        parent_child_count = parent_event.relationships_as_parent.count
        parent_event.update!(master: true)
      end
      while (child_parent_count == 1 && child_child_count == 1)
        #Descend la branche
        child_event = child_event.relationships_as_parent.first.child
        child_child_count = child_event.relationships_as_parent.count
        child_parent_count = child_event.relationships_as_child.count
        child_event.update!(master: true)
      end
    end

    #Désactivation master
    if event_params[:master] == "0"
      parent_parent_count = @event.relationships_as_child.count
      parent_child_count = @event.relationships_as_child.count
      child_child_count =  @event.relationships_as_parent.count
      child_parent_count = @event.relationships_as_child.count
      parent_event = @event
      child_event = @event
      while (parent_parent_count == 1 && parent_child_count == 1)
        #Remonte la branche
        parent_event = parent_event.relationships_as_child.first.parent
        parent_parent_count = parent_event.relationships_as_child.count
        parent_child_count = parent_event.relationships_as_parent.count
        parent_event.update!(master: false)
      end
      while (child_parent_count == 1 && child_child_count == 1)
        #Descend la branche
        child_event = child_event.relationships_as_parent.first.child
        child_child_count = child_event.relationships_as_parent.count
        child_parent_count = child_event.relationships_as_child.count
        child_event.update!(master: false)
      end
    end



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

    # @event_to_delete = Event.find(params[:id])
    # @branch = Branch.find(params[:branch_id])
    # branch_events = BranchEvent.where(event_id: @event_to_delete.id)
    # @event_to_delete_parent = branch_events.first.parent_event
    # branch_events.each do |branch_event|
    #   branch_event.event_id = @event_to_delete_parent
    #   branch_event.parent_event = Event.find(@event_to_delete.branch_events.first.parent_event)
    #   branch_event.save
    # end
    # branch_event_children = BranchEvent.where(parent_event: @event_to_delete.id)
    # branch_event_children.each do |branch_event_child|
    #   branch_event_child.parent_event = @event_to_delete_parent
    #   branch_event_child.save
    # end
    # @event_to_delete.destroy!
    # redirect_to trip_path(@branch.trip)
  end

  private

  def event_params
    params.require(:event).permit(:name, :category, :confirmed, :location, :date, :duration, :description, :url, :price, :master)
  end
end
