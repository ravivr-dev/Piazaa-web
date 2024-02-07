class User < ApplicationRecord
  include Authentication, PasswordReset

  kredis_datetime :last_logged_in
  kredis_unique_list :recently_viewed_listings, limit: 5

  validates :name, presence: true
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: false }

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  has_and_belongs_to_many :saved_listings,
    join_table: "saved_listings",
    class_name: "Listing"


  before_validation :strip_extraneous_spaces

  private

    def strip_extraneous_spaces
      self.name = self.name&.strip
      self.email = self.email&.strip
    end
end
