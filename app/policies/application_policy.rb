class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    Rails.logger.debug 'initialize'
    @user = user
    @record = record
    Rails.logger.debug @user
    Rails.logger.debug @record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  protected
  def admin?
    Rails.logger.debug 'admin?'
    Rails.logger.debug @user
    user.admin?
  end

  def supervisor?
    user.supervisor?
  end

  def teller?
    user.teller?
  end
end
