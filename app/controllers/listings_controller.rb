class ListingsController < ApplicationController
  before_action :find_user, except: [:index]
  before_action :list_limit, only: [:index]
  before_action :grouped_options, only: [:index]
  before_action :find_listing, only: [:show, :edit, :update, :destroy]
  before_action :find_location, only: [:show, :edit, :update, :destroy]

  def index
    params[:page] = 1 unless params[:page]
    if params[:button].nil?
    	listings = Listing.filter(params)
    	@total_pages = total_pages(listings.count, @list_limit)
    	@current_page = params[:page].to_i
    	@listings = shown_list(listings, params[:page], @list_limit)
    else
      movement = params[:button][0][:movement]
      page = params[:button][0][:page]
      pagination_buttons(movement, page)
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
    params.require(:listing).permit(:title, :description, :rules, :bedroom, :bathroom, :price, :availability_start, :availability_end, :verification, { photos: [] })
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

# pagination

  def offset_value(page_number, list_limit)
    (page_number.to_i - 1) * list_limit
  end

  def list_limit
    @list_limit = 5.0
  end

  def total_pages(total, limit)
    (total / limit).ceil
  end

  def shown_list(full_list, page_number, list_limit)
    full_list.offset(offset_value(page_number, list_limit)).limit(list_limit)
  end

  def pagination_buttons(movement, page)
    if movement == "up"
      @page = page.to_i + 1
      redirect_to listings_path(page: @page)
    else
      @page = page.to_i - 1
      redirect_to listings_path(page: @page)
    end
  end

# filter things

  def grouped_options
    @select_options = [["Status",["Latest"]],["Price",['Below','Above']], ["Rooms", ["Bedrooms", "Bathrooms"]],["Text", ["Description", "Rules"]], ["Location",["City"]]]
  end

end
