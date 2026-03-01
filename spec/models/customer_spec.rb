require "rails_helper"

RSpec.describe Customer, type: :model do
  let(:user) { create(:user) }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:interactions).dependent(:destroy) }
  end

  describe "validations" do
    it "contact_nameがあれば有効" do
      customer = Customer.new(
        contact_name: "山田",
        user: user,
        status: :in_progress
      )
      expect(customer).to be_valid
    end

    it "contact_nameが空だと無効" do
      customer = Customer.new(
        contact_name: "",
        user: user,
        status: :in_progress
      )
      expect(customer).not_to be_valid
    end

    it "company_nameは50文字以内" do
      customer = Customer.new(
        contact_name: "山田",
        company_name: "a" * 51,
        user: user,
        status: :in_progress
      )
      expect(customer).not_to be_valid
    end
  end

  describe "enum status" do
    it "in_progress / pending / completed が定義されている" do
      expect(Customer.statuses.keys).to match_array(
        %w[in_progress pending completed]
      )
    end
  end

  describe "#next_due_date" do
    it "最も近いdue_dateを返す" do
      customer = Customer.create!(
        contact_name: "山田",
        user: user,
        status: :in_progress
      )

      customer.interactions.create!(
        user: user,
        summary: "a",
        action_taken: "b",
        contact_type: :email,
        contacted_at: Time.current,
        due_date: 3.days.from_now
      )

      customer.interactions.create!(
        user: user,
        summary: "a",
        action_taken: "b",
        contact_type: :email,
        contacted_at: Time.current,
        due_date: 1.day.from_now
      )

      expect(customer.next_due_date).to eq(1.day.from_now.to_date)
    end
  end

  describe "#due_soon?" do
    it "48時間以内のdue_dateがあればtrue" do
      customer = Customer.create!(
        contact_name: "山田",
        user: user,
        status: :in_progress
      )

      customer.interactions.create!(
        user: user,
        summary: "a",
        action_taken: "b",
        contact_type: :email,
        contacted_at: Time.current,
        due_date: 1.day.from_now
      )

      expect(customer.due_soon?).to be true
    end
  end
end
