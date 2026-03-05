class Customer < ApplicationRecord
  belongs_to :user
  has_many :interactions, dependent: :destroy

  enum :status, { in_progress: 0, pending: 1, completed: 2 }

  validates :company_name, length: { maximum: 50 }, allow_blank: true
  validates :contact_name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, format: { with: /\A[0-9\-\+\(\)]{10,15}\z/ }, allow_blank: true
  validates :needs, length: { maximum: 500 }, allow_blank: true
  validates :notes, length: { maximum: 500 }, allow_blank: true
  validates :status,        presence: true

  def next_due_date
    interactions.where("due_date >= ?", Date.today).order(due_date: :asc).first&.due_date
  end

  def due_soon?
    interactions
      .where(due_date: Date.today..48.hours.from_now.to_date)
      .exists?
  end
end
