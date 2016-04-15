class PremiumMailer < ApplicationMailer
  def premium_upgrade(user)
    @user = user

    mail(to: user.email, subject: "Thank you for becoming a Premium Wikibloc member!")
  end
end
