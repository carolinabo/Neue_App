class ConsumptionsController < ApplicationController
  before_filter :signed_in_user

  def new
    @consumption = Consumption.new
  end

  def index
    @consumptions = Consumption.all
  end

  def show
    @consumption = Consumption.find(params[:id])
  end

  def edit
    @consumption = Consumption.find(params[:id])
  end

  def update
    @consumption = Consumption.find(params[:id])

    if @consumption.update_attributes(params[:consumption])
      flash[:success] = "Update successful!"
      redirect_to consumptions_path
    else
      render 'edit'
    end
  end

  def destroy
    @consumption = Consumption.find(params[:id])
    @consumption.destroy
    flash[:success] = "Consumption destroyed."
    redirect_to consumptions_path
  end

  def create
    @consumption = Consumption.new (params[:consumption])
    if @consumption.save
      flash[:success] = "Consumption saved!"
      redirect_to consumptions_path
    else
      render 'new'
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Bitte melden Sie sich an."
    end
  end
end
