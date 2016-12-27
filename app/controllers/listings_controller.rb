class ListingsController < ApplicationController
	before_action :find_user
	before_action :find_listing, only: [:show, :edit, :update, :destroy]
	before_action :find_location, only: [:show, :edit, :update, :destroy]

	def index
		@listings.all
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
		byebug
		if @listing.update(listing_params)
			if @location.update(location_params)
				redirect_to user_listing_path(@user, @listing.id)
			else
				render 'edit'
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
			params.require(:listing).permit(:title, :description, :rules, :bedroom, :bathroom, :price, :availability_start, :availability_end)
	end

	def location_params
		params.require(:listing)["location"].permit(:address, :city, :state, :country)
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