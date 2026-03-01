# spec/models/user_spec.rb
require "rails_helper"

RSpec.describe User, type: :model do
  describe ".guest" do
    it "ゲストユーザーを作成または取得する" do
      user = User.guest

      expect(user).to be_persisted
      expect(user.email).to eq("guest@example.com")
      expect(user.name).to eq("ゲストユーザー")
    end
  end

  describe "#guest?" do
    it "ゲストユーザーならtrue" do
      user = User.guest
      expect(user.guest?).to be true
    end

    it "通常ユーザーならfalse" do
      user = User.create!(
        email: "normal@example.com",
        password: "password",
        name: "通常ユーザー"
      )

      expect(user.guest?).to be false
    end
  end
end
