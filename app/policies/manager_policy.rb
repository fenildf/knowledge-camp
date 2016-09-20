class ManagerPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def method_missing(method_sym, *arguments, &block)
    if /.+?/.match(method_sym)
      admin?
    end
  end
end
