class Admin::MenusController < Admin::BaseController
  before_action :set_menu, only: [ :edit, :update, :destroy ]
  before_action :load_categories, only: [ :new, :create, :edit, :update ]

  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to admin_menus_path, notice: "Menu item added successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      redirect_to admin_menus_path, notice: "Menu updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to admin_menus_path, notice: "Menu item deleted successfully."
  end

  private

  def set_menu
    @menu = Menu.find(params[:id])
  end

  def load_categories
    @categories = Category.all
  end

  def menu_params
    params.require(:menu).permit(:name, :description, :price, :category_id, :availability_status, :image)
  end
end
