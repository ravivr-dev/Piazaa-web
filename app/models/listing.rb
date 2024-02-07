class Listing < ApplicationRecord
  include HasAddress, PermittedAttributes, AccessPolicy,
    Publishable, Expireable, Searchable

  belongs_to :creator, class_name: "User"
  belongs_to :organization

  has_one_attached :cover_photo
  has_rich_text :description

  has_many :conversations

  enum condition: {
    mint: "mint", near_mint: "near_mint",
    used: "used", defective: "defective"
  }

  enum status: {
    draft: "draft", published: "published",
    expired: "expired"
  }

  validates :title, length: { in: 10..100 }
  validates :price, numericality: { only_integer: true }
  validates :condition, presence: true
  validates :tags, length: { in: 1..5 }
  validates :cover_photo, presence: true
  validates :description, presence: true

  scope :feed, -> {
    published
    .order(created_at: :desc)
    .includes(:address)
    .with_attached_cover_photo
  }

  before_save :downcase_tags

  def saved?
    return false unless Current.user.present?

    Current.user.saved_listings.exists?(id: self.id)
  end

  private
    def downcase_tags
      self.tags = tags.map(&:downcase)
    end
end
