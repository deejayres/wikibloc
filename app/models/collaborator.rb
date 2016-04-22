class Collaborator < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user

  validates :user_id, presence: true
  validates :wiki_id, presence: true

  after_create :send_collaborator_email

  private
  def send_collaborator_email
    CollaboratorMailer.new_collaborator(self).deliver_now
  end
end
