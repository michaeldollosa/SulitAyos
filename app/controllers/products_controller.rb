class ProductsController < ApplicationController
  def index
    @products = current_user.products
  end
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    @product.save
    redirect_to @product
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    redirect_to @product
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_path
  end

end
