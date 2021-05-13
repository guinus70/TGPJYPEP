class StaticController < ApplicationController
  def index
    @gossips = Gossip.all
    params[:id]
  end

  def team
  end

  def contact
  end
end
