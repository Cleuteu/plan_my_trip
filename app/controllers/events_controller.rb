class EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    @trip = Trip.find(params[:trip_id])
    if @event.save!
      @branch_event = BranchEvent.new(branch_id: @branch.id, event_id: @event.id)
      @branch_event.save!
      redirect_to trip_path(@trip)
    else
      render './trips/show'
    end
  end

  def update
    # @event = Event.find(params[:id])
    # if @event.update(event_params)
    #   @branch_event = BranchEvent.new(branch_id: @branch.id, event_id: @event.id)
    #   redirect_to trip_path(@event.branches.first.trip)
    # end
  end

  def destroy
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
    params.require(:event).permit(:name, :category, :confirmed, :location, :date, :duration, :description, :url, :price)
  end
end
