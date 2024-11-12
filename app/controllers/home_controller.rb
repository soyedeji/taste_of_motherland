class HomeController < ApplicationController
  def index
    # Load all categories for the filter dropdown
    @categories = Category.all

    # If a category is selected, filter products by that category with pagination
    @menus = if params[:category_id]
               Menu.where(category_id: params[:category_id]).page(params[:page]).per(10) # 10 items per page
    else
               Menu.page(params[:page]).per(10) # 10 items per page
    end
  end
end
