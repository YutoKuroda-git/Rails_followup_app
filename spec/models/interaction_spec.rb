# spec/models/interaction_spec.rb
require "rails_helper"

RSpec.describe Interaction, type: :model do
  let(:user) do
    User.create!(
      email: "test2@example.com",
      password: "password",
      name: "テストユーザー"
    )
  end

  let(:customer) do
    Customer.create!(
      contact_name: "山田",
      user: user,
      status: :in_progress
    )
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:customer) }
  end

  describe "validations" do
    it "必須項目が揃っていれば有効" do
      interaction = Interaction.new(
        customer: customer,
        user: user,
        summary: "要約",
        action_taken: "対応内容",
        contact_type: :email,
        contacted_at: Time.current
      )

      expect(interaction).to be_valid
    end
  end

  describe "enum contact_type" do
    it "contact_typeが定義されている" do
      expect(Interaction.contact_types.keys).to match_array(
        %w[email phone chat visit other]
      )
    end
  end

  describe "scope timeline_order" do
    it "contacted_atの昇順で並ぶ" do
      older = Interaction.create!(
        customer: customer,
        user: user,
        summary: "a",
        action_taken: "b",
        contact_type: :email,
        contacted_at: 2.days.ago
      )

      newer = Interaction.create!(
        customer: customer,
        user: user,
        summary: "a",
        action_taken: "b",
        contact_type: :email,
        contacted_at: 1.day.ago
      )

      expect(Interaction.timeline_order).to eq([ older, newer ])
    end
  end
end
