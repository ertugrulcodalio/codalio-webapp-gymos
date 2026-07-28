# frozen_string_literal: true

Rails.application.config.to_prepare do
  module Rhino
    class ResourcePolicy < CrudPolicy
      def user
        auth_owner
      end

      def has_role?(user, role)
        return false unless user
        if record.present? && record.respond_to?(:new_record?) && record.new_record? && record.respond_to?(:organization_id) && record.organization_id.nil?
          roles = Rhino.base_owner.roles_for_auth(user)
        else
          roles = Rhino.base_owner.roles_for_auth(user, record)
        end
        roles.key?(role)
      end

      class Scope < ::Rhino::BasePolicy::Scope
        def resolve
          organizations = ::Organization.joins(users_roles: :role).where(users_roles: { user: auth_owner })
          if scope.column_names.include?("organization_id")
            scope.where(organization_id: organizations.select(:id))
          else
            scope.all
          end
        end
      end
    end
  end
end

Rhino.setup do |config|
  # ==> Owner configuration
  # The auth owner class
  # config.auth_owner = 'User'

  # The base owner class
  config.base_owner = "Organization"

  # ==> Resource Configuration

  # Include Rhino::Resource::ActiveRecordExtension by default
  # config.auto_include_active_record = true

  # The root path for the api ie '/api'
  # config.namespace = :api

  # Authentication
  # config.allow_signup = true

  # The list of resources exposed in the API
  config.resources += [ "User", "Account" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "Trainer" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "MembershipPlan" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "MemberProfile" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "GymClass" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "Booking" ]
  config.resources += [ "Organization", "UsersRole", "Role", "UsersRoleInvite" ]
  config.resources += [ "Transaction" ]
end
