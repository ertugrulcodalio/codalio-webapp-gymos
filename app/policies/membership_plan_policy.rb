# frozen_string_literal: true

class MembershipPlanPolicy < Rhino::ResourcePolicy
  def index?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def show?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def create?
    has_role?(user, "gym_staff")
  end

  def update?
    has_role?(user, "gym_staff")
  end

  def destroy?
    has_role?(user, "gym_staff")
  end

  def permitted_attributes_for_show
    if has_role?(user, "gym_staff")
      record.show_params
    elsif has_role?(user, "gym_member")
      [ :id, :name, :price, :status, :weekly_class_limit ]
    else
      []
    end
  end

  def permitted_attributes_for_create
    if has_role?(user, "gym_staff")
      record.create_params
    else
      []
    end
  end

  def permitted_attributes_for_update
    if has_role?(user, "gym_staff")
      record.update_params
    else
      []
    end
  end
end
