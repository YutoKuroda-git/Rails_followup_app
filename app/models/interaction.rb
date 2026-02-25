class Interaction < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  enum contact_type: { email: 0, phone: 1, visit: 2 }

  validates :summary,      presence: true
  validates :contact_type, presence: true
  validates :contacted_at, presence: true

  scope :timeline_order, -> { order(contacted_at: :asc) }
end
