class HomeMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact_email(user)
    @user = user
    @greeting = "Hi"

    mail(to: "info@5tringy.com", subject: "Contact Email - 5tringy.com")
  end

end
