class ChallengesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]


  def index
    @challenges = Challenge.all
  end

  def create
  	@challenge = current_user.challenges.build(params[:challenge])
    @challenge.begin=convert_date(params[:date_challenge], :begin)
    @challenge.end=convert_date(params[:date_challenge], :end)
    if @challenge.save
      flash[:success] = "Reto creado"
      redirect_to current_user
    else 
      flash[:error] = "Han habido errores al crear el reto"
      redirect_to current_user
    end
  end

  def destroy
    Challenge.find(params[:id]).destroy
    redirect_to current_user
  end

  private
 
  def convert_date(hash, date_symbol_or_string)
    attribute = date_symbol_or_string.to_s
    return Date.new(hash[attribute + '(1i)'].to_i, hash[attribute + '(2i)'].to_i, hash[attribute + '(3i)'].to_i)   
  end

end