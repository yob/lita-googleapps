module Lita
  # A google apps user
  class GoogleUser
    attr_reader :id, :full_name, :email, :created_at, :last_login_at, :ou_path

    def self.from_api_user(user)
      GoogleUser.new(
        id: user.id,
        full_name: user.name.full_name,
        email: user.primaryEmail,
        suspended: user.suspended,
        created_at: user.creation_time,
        last_login_at: user.lastLoginTime,
        ou_path: user.orgUnitPath,
        admin: user.isAdmin,
        delegated_admin: user.isDelegatedAdmin,
        two_factor_enabled: user.isEnrolledIn2Sv,
        two_factor_enforced: user.isEnforcedIn2Sv,
      )
    end

    def initialize(id:, full_name:, email:, suspended:, created_at:, last_login_at:, ou_path:, admin:, delegated_admin:, two_factor_enabled:, two_factor_enforced:)
      @id = id
      @email = email
      @full_name = full_name
      @suspended = suspended
      @created_at = created_at
      @last_login_at = last_login_at
      @ou_path = ou_path
      @admin = admin
      @delegated_admin = delegated_admin
      @two_factor_enabled = two_factor_enabled
      @two_factor_enforced = two_factor_enforced
    end

    def to_s
      @email
    end

    def admin?
      @admin
    end

    def delegated_admin?
      @delegated_admin
    end

    def suspended?
      @suspended
    end

    def two_factor_enabled?
      @two_factor_enabled
    end

    def two_factor_enforced?
      @two_factor_enforced
    end

  end
end
