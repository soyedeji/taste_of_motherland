class HomeController < ApplicationController
  def index
    @categories = Category.all
    @menus = Menu.all

    # Filter by Category if a category_id is provided
    if params[:category_id].present?
      @menus = @menus.where(category_id: params[:category_id])
    end

    # Search by Keyword in Name or Description
    if params[:search].present?
      @menus = @menus.where("name LIKE :query OR description LIKE :query", query: "%#{params[:search]}%")
    end

    # Add Pagination
    @menus = @menus.page(params[:page]).per(10)
  end
end
