class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :remove_avatar

  before_save :purge_avatar, if: -> { remove_avatar == "1" }

  has_one_attached :avatar
  has_many :customers, dependent: :destroy
  has_many :interactions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validate :avatar_size

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def guest?
    email == "guest@example.com"
  end

  private

  def avatar_size
    if avatar.attached? && avatar.blob.byte_size > 2.megabytes
      errors.add(:avatar, "は2MB以下にしてください")
      avatar.purge
    end
  end

  def purge_avatar
    avatar.purge
  end
end
