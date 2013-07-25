class FeaturesController < ApplicationController
  before_filter :find_user
  before_filter :authenticate_user!, :except => :index
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  def index
    @features = Feature.all
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def new
    @feature = @user.features.new
    @collaborators = @feature.collaborators.build
  end

  def edit
    @feature = Feature.find(params[:id])
    @collaborator = @feature.collaborators.new(params[:feature])
  end


  def create
    @feature = @user.features.new(params[:feature])
    if @feature.save
      redirect_to features_path, notice: "Feature was successfully created."
    else
      render "new"
    end
  end

  def update
    @feature = @user.features.find(params[:id])
    if @feature.update_attributes(params[:feature])
      redirect_to @feature, notice: 'Feature was successfully updated.'
    else
      render action: "edit" 
      end
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.destroy
    redirect_to users_url
  end

   def find_user
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end
end
