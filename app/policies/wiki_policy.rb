class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user == wiki.user || user.is_admin?
  end

  def permitted_attributes
    if user.is_admin? || user.is_premium?
      [:title, :body, :private]
    else
      [:title, :body]
    end
  end


end
