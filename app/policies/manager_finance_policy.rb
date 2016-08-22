class ManagerFinancePolicy < ManagerPolicy
  def preview?
    supervisor? or admin?
  end

  def hmdm?
    supervisor? or admin?
  end
end
