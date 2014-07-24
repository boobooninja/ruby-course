class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @users = DoubleDog::Database::SQL::User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    response = DoubleDog::FindUser.new.run( params[:id] )
    if response[:user]
      @user = response[:user]
    else
      redirect_to :index
    end
  end

  # # GET /users/new
  # def new
  #   @user = User.new
  # end

  # # GET /users/1/edit
  # def edit
  # end

  # POST /users
  # POST /users.json
  def create
    if @user = DoubleDog::CreateAccount.new.run(user_params)
      redirect_to "/users/index", notice: 'User was successfully created.'
    else
      render :new
    end

    # @user = User.new(user_params)
    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # # PATCH/PUT /users/1
  # # PATCH/PUT /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /users/1
  # # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def orders
    response = DoubleDog::FindOrderByUser.new.run( params.merge(session_id: session[:remember_token]) )
    if response[:orders]
      @orders = response[:orders]
      render 'orders/index'
    else
      redirect_to "/users/#{params[:id]}"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :admin).merge(session_id: session[:remember_token])
    end
end
