class WikisController < ApplicationController
  def index
    @user = current_user
    @wikis = @user.wikis
  end

  def show
  end

  def new
  end

  def edit
  end
end
