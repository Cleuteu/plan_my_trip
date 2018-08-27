class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def show
    @events = @trip.events
    @branches = @trip.branches
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :start_location, :end_location, :photo)
  end
end
