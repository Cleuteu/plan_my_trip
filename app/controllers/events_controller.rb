class EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    @branch = Branch.find(params[:branch_id])
    @trip = @branch.trip
    if @event.save!
      @branch_event = BranchEvent.new(branch_id: @branch.id, event_id: @event.id)
      @branch_event.event_position = 2
      @branch_event.save!
      redirect_to trip_path(@trip)
    else
      render './trips/show'
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :category, :confirmed, :location, :date, :duration, :description, :url, :price)
  end
end
