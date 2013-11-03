class ImagesController < ApplicationController

  def new
  @feature = Feature.find(:id)
  @image = @feature.images.new
  end

  def create
    @feature = Feature.find(:id)
    @image = @feature.images.new()
    if @image.save
      respond_to do |format|
        format.html {}
        format.json {}
        format.js   {}  
    # if @image.save
    #   if request.xhr?
    #     return "#{@image.image_url}"
    #   end
    # end
  end
end