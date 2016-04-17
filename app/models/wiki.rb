class Wiki < ActiveRecord::Base
  belongs_to :user
  resourcify

  scope :visible_to, -> (user) { where(private: false) << where(user: user) }
  # scope :not_private, -> { where(private: false)}
  # scope :visible_to, -> (user) { where{ (private == false) | (user == user) } }
  #
  # def self.visible_to(user)
  #     self.where(private: false) << self.where(user: user)
  # end

  def self.search(search = nil)
    if search
      (self.where('title ILIKE ?', "%#{search}%").concat(self.where('body ILIKE ?', "%#{search}%")))
    else
      self.all
    end
  end
end
