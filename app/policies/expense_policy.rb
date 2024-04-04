class ExpensePolicy < ApplicationPolicy
  def create?
    user.admin_status != true  
  end
  def destroy?
    user.admin_status == true || user.admin_status == false
  end
  def update?
    user.admin_status != true
  end
  def approve?
    user.admin_status == true
  end
  def reject?
    user.admin_status == true
  end
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
