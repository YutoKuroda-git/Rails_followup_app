require "rails_helper"

RSpec.describe "Interactions", type: :request do
  let(:user) { create(:user) }
  let(:customer) { create(:customer, user: user) }
  let!(:interaction) { create(:interaction, user: user, customer: customer) }

  describe "POST /customers/:customer_id/interactions" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされる" do
        post customer_interactions_path(customer), params: {
          interaction: {
            contact_type: "email",
            summary: "テスト対応",
            action_taken: "次回連絡",
            contacted_at: Time.current
          }
        }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      before { sign_in user }

      it "対応履歴を作成できる" do
        expect {
          post customer_interactions_path(customer), params: {
            interaction: {
              contact_type: "email",
              summary: "テスト対応",
              action_taken: "次回連絡",
              contacted_at: Time.current
            }
          }
        }.to change(Interaction, :count).by(1)
      end
    end
  end

  describe "DELETE /customers/:customer_id/interactions/:id" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされる" do
        expect {
          delete customer_interaction_path(customer, interaction)
        }.not_to change(Interaction, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      before { sign_in user }

      it "対応履歴を削除できる" do
        expect {
          delete customer_interaction_path(customer, interaction)
        }.to change(Interaction, :count).by(-1)
      end
    end
  end
end
