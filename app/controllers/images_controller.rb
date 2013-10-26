class ImagesController < ApplicationController

def create
puts params
@feature = Feature.find(params[:feature_id])
@feature.images.create(params[:image])
redirect_to :back
end

end