class PhotosController < ApplicationController

# not currently used.


  def new
	  @feature = Feature.find(params[:feature_id])
	  @photo = @feature.photos.build
	  	end

	def create
		puts 'in photos controller create!'
		@feature = Feature.find(params[:feature_id])
		@photo = @feature.photos.create(image: params[:photo])
	end

end