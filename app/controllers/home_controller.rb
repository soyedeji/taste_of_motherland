class HomeController < ApplicationController
  def index
    # Load all categories for the filter dropdown
    @categories = Category.all

    # Base query for menus
    @menus = Menu.all

    # If a category is selected, filter products by that category
    if params[:category_id].present?
      @menus = @menus.where(category_id: params[:category_id])
    end

    # If a search keyword is provided, filter by product name or description
    if params[:search].present?
      keyword = params[:search].downcase
      @menus = @menus.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end

    # Paginate the results
    @menus = @menus.page(params[:page]).per(10) # 10 items per page
  end
end
