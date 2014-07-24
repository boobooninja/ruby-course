class SessionsController < ApplicationController
  def new
  end

  def create
    response = DoubleDog::SignIn.new.run(session_params)

    if response[:user]
      @user = response[:user]
      session[:remember_token] = response[:session_id]
      redirect_to "/users/#{@user.id}", notice: 'Session was successfully created.'
    else
      render 'signin'
    end
  end

  def destroy
    session[:remember_token] = nil
    redirect_to '/signin'
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
