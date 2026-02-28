class Interaction < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  enum contact_type: { email: 0, phone: 1, chat: 2, visit: 3, other: 4 }

  validates :summary,      presence: true
  validates :contact_type, presence: { message: "を選択してください" }
  validates :contacted_at, presence: true

  scope :timeline_order, -> { order(contacted_at: :asc) }
end
