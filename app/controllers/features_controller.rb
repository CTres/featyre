class FeaturesController < ApplicationController
  #Filters
  before_filter :find_user
  before_filter :authenticate_user!, :except => :index

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  #Methods 

  def new
    @feature = @user.owned_features.new
    @feature.collaborators.build
  end

  def index
    if params[:query]
    @filters = params[:query].split
    @features = Feature.tagged_with(@filters)
    else
    @features= Feature.all
    end

    if user_signed_in?
    @myfeatures = @user.owned_features
    end
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def create
    @feature = @user.owned_features.new(params[:feature])
    @feature.collaborators << @user

    respond_to do |format|
      if @feature.save
        format.html { redirect_to edit_feature_path(@feature) }
        format.js {redirect_to edit_feature_path(@feature) }
      else
        render "new"
      end
    end
  end

  def update
    @feature = @user.owned_features.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        format.html { redirect_to @feature, notice: 'Feature was successfully updated.' }
        format.js {}
      else
        render action: "edit" 
      end
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
    name = params[:feature][:temp_collaborator]

    respond_to do |format|
      if @feature.insert_collaborator(name, session['token'])
        format.html { redirect_to :back }
        format.js {}
      end
    end
  end

  def remove_collaborator
    @feature = Feature.find(params[:id])
    respond_to do |format|
    if @feature.delete_collaborator(params[:temp_collaborator])
      format.html { redirect_to :back }
      format.js {}
    end
  end
  end
end
