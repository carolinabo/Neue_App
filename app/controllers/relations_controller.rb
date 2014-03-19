class RelationsController < ApplicationController
  before_filter :signed_in_user

  def new
    @relation = Relation.new
  end

  def index
    @relations = Relation.all
  end

  def show
    @relation = Relation.find(params[:id])
  end

  def edit
    @relation = Relation.find(params[:id])
  end

  def update
    @relation = Relation.find(params[:id])

    if @relation.update_attributes(params[:relation])
      flash[:success] = "Update successful!"
      redirect_to relations_path
    else
      render 'edit'
    end
  end

  def destroy
    @relation = Relation.find(params[:id])
    @relation.destroy
    flash[:success] = "Relation destroyed."
    redirect_to relations_path
  end

  def create
    @relation = Relation.new (params[:relation])
    if @relation.save
      flash[:success] = "Relation saved!"
      redirect_to relations_path
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
