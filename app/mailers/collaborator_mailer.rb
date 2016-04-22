class CollaboratorMailer < ApplicationMailer
  def new_collaborator(collaborator)

    @collaborator = collaborator

    mail(to: collaborator.user.email, subject: "You have been made a collaborator on a wiki at Wikibloc.")
  end
end
