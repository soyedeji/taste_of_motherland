# class HomeController < ApplicationController
#   def index
#     @categories = Category.all
#     @menus = Menu.all

#     # Filter by Category if a category_id is provided
#     if params[:category_id].present?
#       @menus = @menus.where(category_id: params[:category_id])
#     end

#     # Search by Keyword in Name or Description
#     if params[:search].present?
#       @menus = @menus.where("name LIKE :query OR description LIKE :query", query: "%#{params[:search]}%")
#     end

#     # Add Pagination
#     @menus = @menus.page(params[:page]).per(10)
#   end
# end


class HomeController < ApplicationController
  def index
    @categories = Category.all

    # Base query
    @menus = Menu.all

    # Filter by availability
    if params[:filter] == "available"
      @menus = @menus.where(availability_status: true)
    end

    # Filter by "new" products (created within the last 3 days)
    if params[:filter] == "new"
      @menus = @menus.where("created_at >= ?", 3.days.ago)
    end

    # Filter by "recently updated" products (updated within the last 3 days, but not newly created)
    if params[:filter] == "recently_updated"
      @menus = @menus.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
    end

    # Pagination
    @menus = @menus.page(params[:page]).per(10)
  end
end
