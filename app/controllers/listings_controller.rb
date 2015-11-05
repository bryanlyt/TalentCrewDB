class ListingsController < ApplicationController
  before_action :user_logged_in, only: [:create,:edit,:destroy]

  # show all listings by everyone 
  def index
    @listing = Listing.all
  end

  # show all listings according to params[:id]
  def show 
    @listing = Listing.find_by(id: params[:id])
  end

  # create new listing
  def new 
    @user = User.find_by(id: params[:id])
    @listing = @user.listings.build
  end

  def create 
    user = User.find(params[:user_id])
    @listing = user.listings.create(listing_params)

    if @listing.save
      flash[:success] = "New audition/job listing created!"
      redirect_to root_url
    else
      render 'listings#new'
    end
  end

  # make changes to existing listing
  def edit 
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(listing_params)
      redirect_to current_user
    else
      render 'listings#edit'
    end
  end

  # delete listing
  def destroy
    @listing = current_user.listings.find(params[:id])
    @listing.destroy
    redirect_to current_user
  end

  private
    # check for the permitted input for security
    def listing_params
      params.require(:listing)
        .permit(:title, :description)
    end

end
