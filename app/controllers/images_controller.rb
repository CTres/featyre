class ImagesController < ApplicationController

  def new
  @feature = Feature.find(:id)
  @image = @feature.images.new
  end
end