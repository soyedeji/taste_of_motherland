class Admin::MenusController < Admin::BaseController
  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to admin_menus_path, notice: "Product added successfully."
    else
      render :new
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      redirect_to admin_menus_path, notice: "Product updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    redirect_to admin_menus_path, notice: "Product deleted successfully."
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :description, :price, :category, :availability_status, :image)
  end
end
