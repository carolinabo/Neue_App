class ResourcesController < ApplicationController
  before_filter :signed_in_user

  def new
    @resource = Resource.new
  end

  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find(params[:id])
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])

    if @resource.update_attributes(params[:resource])
      flash[:success] = "Update successful!"
      redirect_to resources_path
    else
      render 'edit'
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    flash[:success] = "Resource destroyed."
    redirect_to resources_path
  end

  def create
    @resource = Resource.new (params[:resource])
    if @resource.save
      flash[:success] = "Resource saved!"
      redirect_to resources_path
    else
      render 'new'
    end
  end

  def new_project
    system "rake db:reset_data"
    flash[:success] = "Data destroyed!"
    redirect_to resources_path
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Bitte melden Sie sich an."
    end
  end
end
