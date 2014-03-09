class HomeController < ApplicationController

  def index
    @contact_email = Home.new
  end

  def create
    @contact_email = Home.new(params[:home])
    if @contact_email.save
      HomeMailer.contact_email(@contact_email).deliver
      redirect_to contact_path(@contact_email)
    else
      render "index"
    end
  end

end
