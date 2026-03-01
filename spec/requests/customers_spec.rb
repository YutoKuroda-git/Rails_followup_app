require 'rails_helper'

RSpec.describe "Customers", type: :request do
  let(:user) { create(:user) }
  let!(:customer) { create(:customer, user: user, company_name: "変更前") }

  describe "GET /customers" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされる" do
        get customers_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      before { sign_in user }

      it "一覧ページが表示される" do
        get customers_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /customers" do
    context "ログインしている場合" do
      before { sign_in user }

      it "顧客を作成できる" do
        expect {
          post customers_path, params: {
            customer: {
              company_name: "テスト株式会社",
              contact_name: "山田太郎",
              email: "test@example.com",
              phone: "090-0000-0000",
              status: "in_progress"
            }
          }
        }.to change(Customer, :count).by(1)
      end
    end
  end

  describe "PATCH /customers/:id" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされる" do
        patch customer_path(customer), params: {
          customer: { company_name: "変更後" }
        }

        expect(response).to redirect_to(new_user_session_path)
        expect(customer.reload.company_name).to eq("変更前")
      end
    end

    context "ログインしている場合" do
      before { sign_in user }

      it "顧客情報を更新できる" do
        patch customer_path(customer), params: {
          customer: { company_name: "変更後" }
        }

        expect(response).to redirect_to(customer_path(customer))
        expect(customer.reload.company_name).to eq("変更後")
      end
    end
  end

  describe "DELETE /customers/:id" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされる" do
        expect {
          delete customer_path(customer)
        }.not_to change(Customer, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしている場合" do
      before { sign_in user }

      it "顧客を削除できる" do
        expect {
          delete customer_path(customer)
        }.to change(Customer, :count).by(-1)

        expect(response).to redirect_to(customers_path)
      end
    end
  end
end
