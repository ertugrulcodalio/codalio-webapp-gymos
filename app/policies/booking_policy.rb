# frozen_string_literal: true

class BookingPolicy < Rhino::ResourcePolicy
  def index?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def show?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def create?
    return false unless has_role?(user, "gym_staff") || has_role?(user, "gym_member")

    if has_role?(user, "gym_member")
      org = record.organization || user.users_roles.first&.organization
      profile = MemberProfile.find_by(user_id: user.id, organization_id: org&.id)
      return false unless profile && profile.status == "Active"

      plan = profile.membership_plan
      return false unless plan

      limit = plan.weekly_class_limit
      if limit.present?
        start_of_week = Time.current.beginning_of_week
        end_of_week = Time.current.end_of_week
        active_bookings_count = Booking.where(user_id: user.id, organization_id: org&.id)
                                       .joins(:gym_class)
                                       .where(gym_classes: { start_time: start_of_week..end_of_week })
                                       .where.not(status: "Cancelled")
                                       .count

        if active_bookings_count >= limit
          raise Pundit::NotAuthorizedError, "Booking limit reached for your membership tier"
        end
      end
    end

    true
  end

  def update?
    has_role?(user, "gym_staff") || has_role?(user, "gym_member")
  end

  def destroy?
    has_role?(user, "gym_staff")
  end

  def permitted_attributes_for_show
    if has_role?(user, "gym_staff")
      record.show_params
    elsif has_role?(user, "gym_member")
      [ :id, :user_id, :status, :gym_class_id ]
    else
      []
    end
  end

  def permitted_attributes_for_create
    if has_role?(user, "gym_staff")
      record.create_params
    elsif has_role?(user, "gym_member")
      [ :status, { user: [ :id ] }, { gym_class: [ :id ] }, { organization: [ :id ] } ]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if has_role?(user, "gym_staff")
      record.update_params
    elsif has_role?(user, "gym_member")
      [ :status ]
    else
      []
    end
  end
end
