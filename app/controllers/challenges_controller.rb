class ChallengesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]


  def index
  end

  def create
  	@challenge = current_user.challenges.build(params[:challenge])
    
    if @challenge.save
      flash[:success] = "Reto creado"
      redirect_to current_user
    else
      redirect_to current_user
    end
  end

  def destroy
    Challenge.find(params[:id]).destroy
    redirect_to user
  end

end