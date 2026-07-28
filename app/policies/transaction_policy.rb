# frozen_string_literal: true

class TransactionPolicy < Rhino::ResourcePolicy
  def index?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def show?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def create?
    has_role?(user, "gym_member")
  end

  def permitted_attributes_for_show
    if has_role?(user, "gym_staff")
      record.show_params
    elsif has_role?(user, "gym_member")
      [ :id, :amount, :plan_name, :status, :created_at ]
    else
      []
    end
  end

  def permitted_attributes_for_create
    if has_role?(user, "gym_member")
      [ :amount, :plan_name, :status, :user_id ]
    else
      []
    end
  end

  def permitted_attributes_for_update
    []
  end
end
