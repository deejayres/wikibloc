class Wiki < ActiveRecord::Base
  belongs_to :user
  resourcify

  scope :publicly_viewable, -> { where( private: false ) }
  scope :privately_viewable, -> { where( private: true ) }
  scope :visible_to, -> ( user ) { user && (user.is_admin? || user.is_premium?) ? all : publicly_viewable }

  def self.search(search = nil)
    if search
      (self.where('title ILIKE ?', "%#{search}%").concat(self.where('body ILIKE ?', "%#{search}%")))
    else
      self.all
    end
  end

  def downgrade
    self.update(private: false)
  end
end
