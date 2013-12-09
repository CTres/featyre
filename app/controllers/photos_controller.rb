class PhotosController < ApplicationController

# not currently used.


  def destroy
  	@photo = Photo.find(params[:id])
  	@photo.destroy
  	respond_to do |format|
  		format.html {redirect_to :back}
			end
		end

end