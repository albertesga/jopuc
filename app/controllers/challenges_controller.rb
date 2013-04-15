class ChallengesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
  	@challenge = current_user.microposts.build(params[:challenge])
    if @challenge.save
      flash[:success] = "Reto creado"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

end