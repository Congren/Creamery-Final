class User < ActiveRecord::Base
  # get modules to help with some functionality
  include CreameryHelpers::Validations
  has_secure_password
  # Relationships
  belongs_to :employee

  # Validations
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format"
  validate :employee_is_active_in_system

  def role?(authorized_role)
    if self.employee.nil?
      self.employee = Employee.new
      self.employee.role = "guest"
    end
    return false if self.employee.role.nil?
    self.employee.role.to_sym == authorized_role
  end
  private

  def self.authenticate(email,password_digest)
    find_by_email(email).try(:authenticate, password_digest)
  end
  def employee_is_active_in_system
    is_active_in_system(:employee)
  end

end
