class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @products = current_user.products.paginate(:page => params[:page], :per_page => 10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:product])
    redirect_to @user
  end

  def profile
    @user = current_user
    @products = current_user.products.paginate(:page => params[:page], :per_page => 10)
  end

end
