class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :add_canadian_trip, if: :sign_up

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def add_canadian_trip
    trip3 = Trip.new(
    name: 'Road trip Canada - Adrien & Julie',
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
trip3.user = current_user
trip3.remote_photo_url = "https://images.unsplash.com/photo-1519885277449-12eee5564d68"
trip3.save

user_trip = UserTrip.new
user_trip.user = user
user_trip.trip = trip
user_trip.save

  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name])
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end

