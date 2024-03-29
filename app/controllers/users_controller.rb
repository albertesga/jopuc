class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :show]
  before_filter :correct_user,   only: [:edit, :update, :show]

  def new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:notice] = "Bienvendio a JoPuc. Ya puedes subir retos."
      redirect_to @user
    else
      render :template => '/static_pages/home'
    end
  end

  def show
    @user = User.find(params[:id])
    @challenges = @user.challenges
    @challenge = current_user.challenges.build if signed_in?
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Usuario actualizado"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

private

    def signed_in_user
      redirect_to login_url, notice: "Haz login, por favor." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
