class UsersController < ApplicationController
  def index
    params[:user] = User.find(params[:id])
    params[:gossips] = Gossip.where(user_id: params[:user].id)
  end

  def show
    @user = User.find(params[:id])
    @user_city = City.find(@user.city_id)
    @user_gossip_count = Gossip.where(user_id: @user.id).count
  end

  def new
    @new_user = User.new 
    @city = City.all.order(:name)
  end

  def create  
    @new_user = User.new(first_name: params[:first_name], last_name: params[:last_name], age: params[:age], email: params[:email], password: params[:password], description: params[:description],city: City.find(params[:city_id]))

    if @new_user.save
      flash[:success] = "Merci #{@new_user.first_name} ! Nous avons pu créer ton compte ! "
      redirect_to :controller => 'static', :action => 'index'
    else
      flash[:danger] = "Nous n'avons pas réussi à créer ton compte pour la (ou les) raison(s) suivante(s) : #{@new_user.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'new'
    end
  end
end
