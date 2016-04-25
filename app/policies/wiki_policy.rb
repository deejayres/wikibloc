class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    if wiki.private
      user == wiki.user || wiki.collaborators.pluck(:user_id).include?(user.id)
    else
      true
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    if wiki.private
      user == wiki.user || wiki.collaborators.pluck(:user_id).include?(user.id)
    else
      user.present?
    end
  end

  def update?
    if wiki.private
      user == wiki.user || wiki.collaborators.pluck(:user_id).include?(user.id)
    else
      user.present?
    end
  end

  def destroy?
    user == wiki.user || user.is_admin?
  end

  def permitted_attributes
    if user.is_admin? || user.is_premium?
      [:title, :body, :private, :collaborators]
    else
      [:title, :body]
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.is_admin?
        wikis = scope.all
      elsif user.is_premium?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.user == user || wiki.collaborators.pluck(:user_id).include?(user.id)
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private || wiki.collaborators.pluck(:user_id).include?(user.id)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
