class AttractionsController < ApplicationController
  
  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find(params[:id])
    @ride = @attraction.rides.build(user_id: current_user.id)
  end

  def new
    @attraction = Attraction.new
  end

  def create 
    attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(attraction)
  end

  def edit
    @attraction = Attraction.find(params[:id])
    @ride = @attraction.rides.build(user_id: current_user.id)
  end

  def update
    attraction = Attraction.find(params[:id])
    attraction.update(attraction_params)
    redirect_to attraction_path(attraction)
  end

  private

  def attraction_params
    params.require(:attraction).permit(%i[name min_height tickets happiness_rating nausea_rating])
  end
end