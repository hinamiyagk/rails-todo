class UserSessionsController < ApplicationController
  def new
    redirect_to :root, notice: 'You are already logged in' if current_user
  end

  def create
    if current_user
      redirect_to :root, notice: 'You are already logged in'
    elsif @user = login(params[:email].downcase, params[:password], params[:remember_me])
      redirect_back_or_to(@user, success: 'Login successful')
    else
      flash.now[:error] = 'Invalid email or password'
      render action: 'new'
    end
  end

  def index
    redirect_to :login
  end

  def destroy
    logout
    redirect_to(:root, flash: { success: 'Logged out!' })
  end
end
