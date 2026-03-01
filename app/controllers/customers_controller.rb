class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [ :show, :edit, :update, :destroy ]
  before_action :restrict_guest!, only: [ :destroy ]

  def index
    @customers         = current_user.customers.includes(:interactions).order(updated_at: :desc)
    @in_progress_count = @customers.in_progress.count
    @pending_count     = @customers.pending.count
    @completed_count   = @customers.completed.count

    if params[:q].present?
    query = "%#{params[:q]}%"
    @customers = @customers.where(
      "company_name LIKE :q OR contact_name LIKE :q OR email LIKE :q",
      q: query
      )
    end

    if params[:status].present?
      @customers = @customers.where(status: params[:status])
    end

    @customers = @customers.sort_by { |c| [ c.due_soon? ? 0 : 1, -c.updated_at.to_i ] }
    @customers = Kaminari.paginate_array(@customers).page(params[:page]).per(10)
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
