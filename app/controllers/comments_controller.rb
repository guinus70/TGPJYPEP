class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :edit, :create, :update]

  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end


  def create
    @comment = Comment.new(content: params[:content], user: User.find(current_user.id), gossip: Gossip.find(params[:gossip_id]))

    if @comment.save
      flash[:success] = "Merci #{@comment.user.first_name} ! Nous avons pu créer votre commentaire : #{@comment.content} "
      redirect_to :controller => 'gossips', :action => 'show' , id: Gossip.find(params[:gossip_id])
    else
      flash[:danger] = "Nous n'avons pas réussi à créer le commentaire pour la (ou les) raison(s) suivante(s) : #{@comment.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @gossip = Gossip.find(params[:gossip_id])
    comment_params
    if @comment.update(comment_params)
      flash[:success] = "Merci #{@comment.user.first_name} ! Nous avons pu modifier votre commentaire : #{@comment.content} "
      redirect_to :controller => 'gossips', :action => 'show' , id: Gossip.find(params[:gossip_id])
    else
      flash[:danger] = "Nous n'avons pas réussi à modifier le commentaire pour la (ou les) raison(s) suivante(s) : #{@comment.errors.full_messages.each {|message| message}.join('')}"
      redirect_to :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Merci #{@comment.user.first_name} ! Nous avons pu supprimer le commentaire : #{@comment.content} "
      redirect_to :controller => 'static', :action => 'index'
    else
      flash[:danger] = "Nous n'avons pas réussi à suppimer le commentaire pour la (ou les) raison(s) suivante(s) : #{@comment.errors.full_messages.each {|message| message}.join('')}"
      render :action => 'edit'
    end
  end

  private

  def comment_params
    params.permit(:content)
  end

  def authenticate_user
    unless current_user 
      flash[:danger] = "Pour commenter un gossip, vous devez être connecté..."
      redirect_to new_session_path
    end
  end
end
