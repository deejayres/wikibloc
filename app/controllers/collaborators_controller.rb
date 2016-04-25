class CollaboratorsController < ApplicationController

  def create
    wiki = Wiki.find(params[:wiki])
    email = params[:collaborators_email]
    user = User.find_by(email: email)

    collaborator = wiki.collaborators.new(user: user)

    if collaborator.save
      flash[:notice] = "Collaborator Added."
    else
      flash[:alert] = "Could not find a user with that email address. Please try again"
    end
    redirect_to wiki
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "\"#{@collaborator.user.username}\" is no longer a collaborator."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error removing this collaborator. Please try again."
    end
  end
end
