class User < ActiveRecord::Base
  rolify :after_add => :email_premium_user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators, dependent: :destroy

  after_initialize :set_role

  include FriendlyId
  friendly_id :username, use: :slugged

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def downgrade
    self.remove_role :premium
  end

  private

  def set_role
    self.add_role :standard
  end

  def email_premium_user(user)
    if self.is_premium?
      PremiumMailer.premium_upgrade(self).deliver_now
    end
  end

end
