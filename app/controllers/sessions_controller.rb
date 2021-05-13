class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = " Bonjour #{user.first_name}, tu es bien connecté :) "
      redirect_to :controller => 'users', :action => 'index', :id => current_user.id
    else
      flash.now[:danger] = 'Erreur dans la combinaision Email/Mot de passe'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Tu es bien déconnecté(e), ciao l'artiste !"
    redirect_to :controller => 'static', :action => 'index'
  end
end
