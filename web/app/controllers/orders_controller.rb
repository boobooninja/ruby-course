class OrdersController < ApplicationController
  # before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # @orders = Order.all
    @orders = DoubleDog::Database::SQL::Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    # @order = DoubleDog::Database::SQL::Order.find(params[:id])
    response = DoubleDog::FindOrder.new.run( params[:id] )
    if response[:order]
      @order = response[:order]
    else
      redirect_to :index
    end
  end

  # GET /orders/new
  def new
    @items = DoubleDog::Database::SQL::Item.all
    @order = DoubleDog::Database::SQL::Order.new
  end

  # # GET /orders/1/edit
  # def edit
  # end

  # POST /orders
  # POST /orders.json
  def create
    response = DoubleDog::CreateOrder.new.run( order_params )
    if response[:order]
      redirect_to "/orders/#{response[:order].id}", notice: 'Order was successfully created.'
    else
      @items = DoubleDog::Database::SQL::Item.all
      render :new
    end

    # @order = Order.new(order_params)

    # respond_to do |format|
    #   if @order.save
    #     format.html { redirect_to @order, notice: 'Order was successfully created.' }
    #     format.json { render :show, status: :created, location: @order }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # # PATCH/PUT /orders/1
  # # PATCH/PUT /orders/1.json
  # def update
  #   respond_to do |format|
  #     if @order.update(order_params)
  #       format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @order }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /orders/1
  # # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_order
    #   @order = Order.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(items: []).merge(session_id: session[:remember_token])
    end
end
