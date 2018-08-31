class EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    @trip = Trip.find(params[:trip_id])
    @event.trip_id = @trip.id
    @parent_id = params[:event][:parent_ids]
    @child_id = params[:event][:child_ids]
    if @event.save!
      @relationship = Relationship.create!(parent_id: @parent_id, child_id: @event.id)
      @relationship = Relationship.create!(parent_id: @event.id, child_id: @child_id)
      if Relationship.where(parent_id: @parent_id, child_id: @child_id).empty?
      else
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
    if event_params[:master] == "1"
      parent_count = @event.relationships_as_child.count
      child_count = @event.relationships_as_child.count
      parent_event = @event
      # if parent_count = 1
      #   parent_event = @event.relationships_as_child.first.parent
      #   parent_count = parent_event.relationships_as_child.count
      #   parent_event.update!(master: true)

      while (parent_count == 1 && child_count == 1)
        parent_event = parent_event.relationships_as_child.first.parent
        parent_count = parent_event.relationships_as_child.count

        child_count = parent_event.relationships_as_parent.count

        parent_event.update!(master: true)

      end
      # end
    end
    if @event.update!(event_params)
      redirect_to trip_path(@trip)
    end
  # raise
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
