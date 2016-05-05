class StoreFlavorsController < ApplicationController
  load_and_authorize_resource
  before_action :set_store_flavors, only: [:show, :edit, :update, :destroy]
  
  def index
    @store_flavors = StoreFlavor.paginate(page: params[:page]).per_page(10) 
  end

  def show
  end

  def new
    @store_flavor = StoreFlavor.new
  end

  def edit
  end

  def create
    @store_flavor = StoreFlavor.new(store_flavor_params)
    
    if @store_flavor.save
      redirect_to store_flavor_path(@store_flavor), notice: "Successfully created #{@store_flavor}."
    else
      render action: 'new'
    end
  end

  def update
    if @store_flavor.update(store_flavor_params)
      redirect_to store_flavor_path(@store_flavor), notice: "Successfully updated #{@store_flavor.name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @store_flavor.destroy
    redirect_to store_flavors_path, notice: "Successfully removed #{@store_flavor} from the AMC system."
  end

  private
  def set_store_flavors
    @store_flavor = StoreFlavor.find(params[:id])
  end

  def store_flavor_params
    params.require(:store_flavor).permit(:store_id, :flavor_id)
  end

end