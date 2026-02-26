class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [ :show, :edit, :update, :destroy ]

  def index
    @customers         = current_user.customers.includes(:interactions).order(updated_at: :desc)
    @in_progress_count = @customers.in_progress.count
    @pending_count     = @customers.pending.count
    @completed_count   = @customers.completed.count
    @due_soon_count    = @customers.in_progress.count(&:due_soon?)
  end

  def show
    @interactions = @customer.interactions.timeline_order
    @interaction  = Interaction.new
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = current_user.customers.build(customer_params)
    if @customer.save
      redirect_to @customer, notice: "顧客を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "削除しました"
  end

  private

  def set_customer
    @customer = current_user.customers.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:company_name, :contact_name, :email, :phone, :needs, :notes, :status)
  end
end
