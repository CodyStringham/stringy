class HomeMailer < ActionMailer::Base

  def contact_email(user)
    @user = user
    mail(to: "info@5tringy.com", from:"#{@user.email}", subject: "5tringy - #{@user.subject}")
  end

end
