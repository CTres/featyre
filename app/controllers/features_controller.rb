class FeaturesController < ApplicationController
  #Filters
  before_filter :find_user
  before_filter :authenticate_user!, :except => :index

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  #Methods 
  def index
    @features = Feature.all
    if user_signed_in?
    @feature = @user.owned_features.new
    @feature.collaborators.build
    end
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def new
    @feature = @user.owned_features.new
    @feature.collaborators.build
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def create
    @feature = @user.owned_features.new(params[:feature])
    
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

  def add_collaborator
    @feature = Feature.find(params[:id])
    @feature.insert_collaborator(params[:feature][:temp_collaborator])
    redirect_to :back
  end

  def remove_collaborator
    puts params
    @feature = Feature.find(params[:id])
    @feature.delete_collaborator(params[:temp_collaborator])
    redirect_to :back
  end
end
