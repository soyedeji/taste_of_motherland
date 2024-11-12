class HomeController < ApplicationController
  def index
    # If a category is selected, filter products by that category
    if params[:category_id]
      @selected_category = Category.find(params[:category_id])
      @menus = @selected_category.menus
    else
      # Otherwise, show all products
      @menus = Menu.all
    end

    # Load all categories for the filter dropdown
    @categories = Category.all
  end
end
