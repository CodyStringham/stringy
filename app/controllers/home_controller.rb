class HomeController < ApplicationController

  def index
  end

  def contact
    c = ContactForm.new(name: contact_params[:name], email: contact_params[:email], subject: contact_params[:subject], message: contact_params[:message])
    if c.deliver
      render :contact
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end

end
