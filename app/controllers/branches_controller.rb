class BranchesController < ApplicationController

  def create
    @trip = Trip.find(params[:trip_id])
    @branch = Branch.new(branch_params)
    @branch.trip_id = @trip.id

    if @branch.save
      redirect_to trip_path(@trip)
    else
      render './trips/show'
    end
  end

  private

  def branch_params
    params.require(:branch).permit(:master)
  end
end
