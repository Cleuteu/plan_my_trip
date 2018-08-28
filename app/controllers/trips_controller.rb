class TripsController < ApplicationController
  before_action :set_trip, only: [:show]

  def index
    @trips = Trip.all
  end

  def show
    @branches = @trip.branches
    @branch = Branch.new
    @event = Event.new

    # Pour afficher sur la trip-show la map avec des points sur chaque event
    @events = Event.where.not(latitude: nil, longitude: nil)
    @markers = @events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
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
