class Wiki < ActiveRecord::Base
  belongs_to :user
  resourcify

  def self.search(search = nil)
    if search
      (self.where('title ILIKE ?', "%#{search}%").concat(self.where('body ILIKE ?', "%#{search}%")))
    else
      self.all
    end
  end
end
