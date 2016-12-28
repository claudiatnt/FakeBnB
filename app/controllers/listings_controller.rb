class ListingsController < ApplicationController
  before_action :find_user, except: [:index]
  before_action :find_listing, only: [:show, :edit, :update, :destroy]
  before_action :find_location, only: [:show, :edit, :update, :destroy]

  def index
    listings_per_page = 5
    params[:page] = 1 unless params[:page]
    if params[:button].nil?
    	first_listing = (params[:page].to_i - 1 ) * listings_per_page
    	listings = Listing.all
    	@total_pages = listings.count / listings_per_page
    	@current_page = params[:page].to_i
    	if listings.count % listings_per_page > 0
      		@total_pages += 1
    	end
    	@listings = listings[first_listing...(first_listing + listings_per_page)]
    elsif params[:button][0][:movement] == "up"
    	params[:page] = 1 if params[:page].nil?
    	@current_page = params[:page].to_i
    	@page = params[:button][0][:page].to_i + 1
    	redirect_to listings_path(page: @page)
    elsif params[:button][0][:movement] == "down"
    	@current_page = params[:page].to_i
    	@page = params[:button][0][:page].to_i - 1
    	redirect_to listings_path(page: @page)
     end
  end


  def new
    @listing = @user.listings.new
    @location = Location.new
  end

  def create
    @listing = @user.listings.build(listing_params)
    @location = Location.new(location_params)
    if @listing.save
      @location.listing_id = @listing.id
      if @location.save
        redirect_to user_listing_path(@user, @listing.id)
      else
        render "new"
      end
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      if params[:listing]["location"].nil?
        redirect_to user_listing_path(@user, @listing.id)
      else
        if @location.update(location_params)
          redirect_to user_listing_path(@user, @listing.id)
        else
          render 'edit'
        end
      end
    else
      render 'edit'
    end
  end

  def destroy
    if @listing.destroy
      @location.destroy
      redirect_to root_path
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :rules, :bedroom, :bathroom, :price, :availability_start, :availability_end, :verification)
  end

  def location_params
    params.require(:listing)["location"].permit(:address, :city, :state, :country) unless params[:listing]["location"].nil?
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def find_location
    @location = Location.find_by(listing_id: params[:id])
  end

end
