class CommentPolicy < ApplicationPolicy
  def create?
    user.admin_status == true
  end
  def reply?
    user.admin_status == false
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
