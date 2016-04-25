# Preview all emails at http://localhost:3000/rails/mailers/collaborator_mailer
class CollaboratorMailerPreview < ActionMailer::Preview
  def new_collaborator
    CollaboratorMailer.new_collaborator(Collaborator.last)
  end
end
