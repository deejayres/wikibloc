class WikisController < ApplicationController
  before_action :authenticate_user!
  def index
    @wikis =  policy_scope(Wiki)
    @wikis = Wiki.where(id: @wikis.map(&:id))
    @wikis = @wikis.search(params[:search])

  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    authorize @wiki
    @wiki = current_user.wikis.build(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was saved successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving your wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to profile_path
    else
      flash.now[:alert] = "There was an error deleting the post. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(policy(@wiki).permitted_attributes)
  end
end
