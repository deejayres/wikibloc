# Preview all emails at http://localhost:3000/rails/mailers/premium_mailer
class PremiumMailerPreview < ActionMailer::Preview
  def premium_upgrade
    PremiumMailer.premium_upgrade(User.last)
  end
end
