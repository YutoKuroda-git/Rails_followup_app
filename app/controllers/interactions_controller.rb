class InteractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer

  def create
    @interaction = @customer.interactions.build(interaction_params)
    @interaction.user = current_user
    if @interaction.save
      @customer.update(status: params[:interaction][:status]) if params[:interaction][:status].present?
      redirect_to @customer, notice: "タイムラインに追加しました"
    else
      flash.now[:alert] = "タイムラインに追加できませんでした"
      @interactions = @customer.interactions.timeline_order
      render "customers/show", status: :unprocessable_entity
    end
  end

  def destroy
    @interaction = @customer.interactions.find(params[:id])
    @interaction.destroy
    redirect_to @customer, notice: "削除しました"
  end

  private

  def set_customer
    @customer = current_user.customers.find(params[:customer_id])
  end

  def interaction_params
    params.require(:interaction).permit(:contact_type, :summary, :action_taken, :due_date, :contacted_at)
  end
end
