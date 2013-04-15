class StaticPagesController < ApplicationController
  def home
  	@user = User.new
  	@home = "home-background"
  end

  def porque
  end

  def como
  end

  def manifiesto
  end
end
