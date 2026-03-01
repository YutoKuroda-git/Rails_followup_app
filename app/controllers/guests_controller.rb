class GuestsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    guest = User.guest
    sign_in guest
    redirect_to customers_path, notice: "ゲストとしてログインしました"
  end
end
