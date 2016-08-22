class WaresPolicy < ApplicationPolicy
  def show?
    teller? or supervisor? or admin?
  end

  def hmdm?
    teller? or supervisor? or admin?
  end
end
