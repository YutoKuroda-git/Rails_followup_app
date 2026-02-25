class Customer < ApplicationRecord
  belongs_to :user
  has_many :interactions, dependent: :destroy

  enum status: { in_progress: 0, pending: 1, completed: 2 }

  validates :company_name,  presence: true
  validates :contact_name,  presence: true
  validates :status,        presence: true

  def due_soon?
    interactions
      .where(due_date: Date.today..48.hours.from_now.to_date)
      .exists?
  end
end
