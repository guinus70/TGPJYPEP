class CitiesController < ApplicationController
  def show
    @city = City.find(params[:id])
    @gossips = Gossip.joins(:user).where(:user => User.where(city_id: params[:id]))
  end

  def new
  end
end
